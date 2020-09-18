//
//  NSString+JMAESDES.m
//  JMBaseUtils
//
//  Created by lzj<lizhijian_21@163.com> on 2020/8/16.
//  Copyright © 2020 Jimi. All rights reserved.
//

#import "NSString+JMAESDES.h"
#include "NSData+JMAESDES.h"

@implementation NSString (JMAESDES)

- (NSString *)jm_aes256EncryptWithKey:(NSString *)key
{
    NSData *result = [[self dataUsingEncoding:NSUTF8StringEncoding] jm_aesDesWithType:JM_AES_TYPE_256 key:key ccOperation:kCCEncrypt options:kCCOptionPKCS7Padding|kCCOptionECBMode iv:nil];
    NSData *base64Data = [result base64EncodedDataWithOptions:NSDataBase64Encoding64CharacterLineLength];
    NSString *resultStr = [[NSString alloc] initWithData:base64Data encoding:NSUTF8StringEncoding];
    return resultStr;
}

- (NSString *)jm_aes256DecryptWithKey:(NSString *)key
{
    NSData *result = [[self dataUsingEncoding:NSUTF8StringEncoding] jm_aesDesWithType:JM_AES_TYPE_256 key:key ccOperation:kCCDecrypt options:kCCOptionPKCS7Padding|kCCOptionECBMode iv:nil];
    return [[NSString alloc] initWithData:result encoding:NSUTF8StringEncoding];
}

@end
