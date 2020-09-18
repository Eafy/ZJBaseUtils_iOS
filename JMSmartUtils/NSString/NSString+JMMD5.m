//
//  NSString+JMMD5.m
//  JMBaseUtils
//
//  Created by lzj<lizhijian_21@163.com> on 2020/8/16.
//  Copyright © 2020 Jimi. All rights reserved.
//

#import "NSString+JMMD5.h"
#import "NSString+JMExt.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonHMAC.h>

@implementation NSString (JMMD5)

- (NSString *)jm_md5String
{
    const char *string = self.UTF8String;
    int length = (int)strlen(string);
    unsigned char bytes[CC_MD5_DIGEST_LENGTH];
    CC_MD5(string, length, bytes);
    return [NSString jm_stringFromBytes:bytes length:CC_MD5_DIGEST_LENGTH];
}

- (NSString *)jm_md5For16String
{
    const char *string = self.UTF8String;
    int length = (int)strlen(string);
    unsigned char bytes[CC_MD5_DIGEST_LENGTH];
    CC_MD5(string, length, bytes);
    return [NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X",
           bytes[8], bytes[10],
           bytes[12], bytes[14],
           bytes[16], bytes[18],
           bytes[20], bytes[22]
           ];
}

@end
