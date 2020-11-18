//
//  ZJSystem+WiFi.m
//  ZJBaseUtils
//
//  Created by eafy on 2020/11/18.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import "ZJSystem+WiFi.h"
#import <SystemConfiguration/CaptiveNetwork.h>
#import <arpa/inet.h>
#import <netinet/in.h>
#import <ifaddrs.h>

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

+ (NSString *)gatewayIpForWiFi
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
                    NSLog(@"广播地址：%@", [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_dstaddr)->sin_addr)]);
                    NSLog(@"本机地址：%@", [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)]);
                    NSLog(@"子网掩码地址：%@", [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_netmask)->sin_addr)]);
                    NSLog(@"接口名：%@", [NSString stringWithUTF8String:temp_addr->ifa_name]);
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    
    freeifaddrs(interfaces);
    in_addr_t i = inet_addr([address cStringUsingEncoding:NSUTF8StringEncoding]);
    in_addr_t *x = &i;
//    unsigned char *s = getdefaultgateway(x);
//    NSString *ip = [NSString stringWithFormat:@"%d.%d.%d.%d",s[0],s[1],s[2],s[3]];
//    free(s);
                    
    return @"";
}

@end
