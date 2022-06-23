//
//  ZJSystem+WiFi.m
//  ZJBaseUtils
//
//  Created by eafy on 2020/11/18.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import <ZJBaseUtils/ZJSystem+WiFi.h>
#import <SystemConfiguration/CaptiveNetwork.h>
#import <arpa/inet.h>
#import <netinet/in.h>
#import <ifaddrs.h>
#import <sys/sysctl.h>
#import <ZJBaseUtils/ZJNetRoute.hpp>

#define CTL_NET         4               /* network, see socket.h */
 
#define ROUNDUP(a) ((a) > 0 ? (1 + (((a) - 1) | (sizeof(long) - 1))) : sizeof(long))

@implementation ZJSystem (WiFi)

+ (NSString *)fetchSSIDInfo
{
    NSString *wifiName = nil;
    CFArrayRef wifiInterfaces = CNCopySupportedInterfaces();
    if (!wifiInterfaces) {
        return nil;
    }
    NSArray *interfaces = (__bridge NSArray *)wifiInterfaces;
    for (NSString *interfaceName in interfaces) {
        CFDictionaryRef dictRef = CNCopyCurrentNetworkInfo((__bridge CFStringRef)(interfaceName));
        
        if (dictRef) {
            NSDictionary *networkInfo = (__bridge NSDictionary *)dictRef;
            NSLog(@"network info -> %@", networkInfo);
            wifiName = [networkInfo objectForKey:(__bridge NSString *)kCNNetworkInfoKeySSID];
            CFRelease(dictRef);
        }
    }
    
    CFRelease(wifiInterfaces);
    if (wifiName.length == 0) {
        NSArray *ifs = (__bridge_transfer id)CNCopySupportedInterfaces();
        id info = nil;
        for (NSString *ifnam in ifs) {
            info = (__bridge_transfer id)CNCopyCurrentNetworkInfo((__bridge CFStringRef)ifnam);
            if (info && [(NSArray *)info count]) { break; }
        }
        wifiName = info[@"SSID"];
    }

    return wifiName;
}

+ (NSString *)localIP
{
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    
    success = getifaddrs(&interfaces);
    if (success == 0) {
        temp_addr = interfaces;
        while (temp_addr != NULL) {
            if (temp_addr->ifa_addr->sa_family == AF_INET) {
                if ([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                    NSLog(@"本机地址：%@", address);
//                    NSLog(@"广播地址：%@", [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_dstaddr)->sin_addr)]);
//                    NSLog(@"本机地址：%@", [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)]);
//                    NSLog(@"子网掩码地址：%@", [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_netmask)->sin_addr)]);
//                    NSLog(@"接口名：%@", [NSString stringWithUTF8String:temp_addr->ifa_name]);
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    
    freeifaddrs(interfaces);
    if (!address || [address length] == 0) {
        address = @"127.0.0.1";
    }
  
    return address;
}

+ (NSString *)gatewayIPFromWiFi
{
    NSString *address = nil;
    
    /* net.route.0.inet.flags.gateway */
    int mib[] = {CTL_NET, PF_ROUTE, 0, AF_INET, NET_RT_FLAGS, RTF_GATEWAY};
    size_t l;
    char * buf, * p;
    struct rt_msghdr * rt;
    struct sockaddr * sa;
    struct sockaddr * sa_tab[RTAX_MAX];
    int i;
    int r = -1;
    
    if(sysctl(mib, sizeof(mib)/sizeof(int), 0, &l, 0, 0) < 0) {
        address = @"192.168.0.1";
    }
    
    if(l>0) {
        buf = malloc(l);
        if(sysctl(mib, sizeof(mib)/sizeof(int), buf, &l, 0, 0) < 0) {
            address = @"192.168.0.1";
        }
        
        for(p=buf; p<buf+l; p+=rt->rtm_msglen) {
            rt = (struct rt_msghdr *)p;
            sa = (struct sockaddr *)(rt + 1);
            for(i=0; i<RTAX_MAX; i++)
            {
                if(rt->rtm_addrs & (1 << i)) {
                    sa_tab[i] = sa;
                    sa = (struct sockaddr *)((char *)sa + ROUNDUP(sa->sa_len));
                } else {
                    sa_tab[i] = NULL;
                }
            }
            
            if( ((rt->rtm_addrs & (RTA_DST|RTA_GATEWAY)) == (RTA_DST|RTA_GATEWAY))
               && sa_tab[RTAX_DST]->sa_family == AF_INET
               && sa_tab[RTAX_GATEWAY]->sa_family == AF_INET) {
                unsigned char octet[4]  = {0,0,0,0};
                int i;
                for (i=0; i<4; i++){
                    octet[i] = ( ((struct sockaddr_in *)(sa_tab[RTAX_GATEWAY]))->sin_addr.s_addr >> (i*8) ) & 0xFF;
                }
                if(((struct sockaddr_in *)sa_tab[RTAX_DST])->sin_addr.s_addr == 0) {
                    in_addr_t addr = ((struct sockaddr_in *)(sa_tab[RTAX_GATEWAY]))->sin_addr.s_addr;
                    r = 0;
                    address = [NSString stringWithFormat:@"%s", inet_ntoa(*((struct in_addr*)&addr))];
                    NSLog(@"网关地址：%@",address);
                    break;
                }
            }
        }
        free(buf);
    }
    return address;
}

@end
