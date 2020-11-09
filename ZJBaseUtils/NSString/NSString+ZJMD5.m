//
//  NSString+ZJMD5.m
//  ZJBaseUtils
//
//  Created by eafy on 2020/8/16.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import "NSString+ZJMD5.h"
#import "NSString+ZJExt.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonHMAC.h>

@implementation NSString (ZJMD5)

- (NSString *)zj_md5String
{
    const char *string = self.UTF8String;
    int length = (int)strlen(string);
    unsigned char bytes[CC_MD5_DIGEST_LENGTH];
    CC_MD5(string, length, bytes);
    return [NSString zj_stringFromBytes:bytes length:CC_MD5_DIGEST_LENGTH];
}

- (NSString *)zj_md5For16String
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
