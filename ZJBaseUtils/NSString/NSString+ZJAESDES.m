//
//  NSString+ZJAESDES.m
//  ZJBaseUtils
//
//  Created by eafy on 2020/8/16.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import "NSString+ZJAESDES.h"
#include "NSData+ZJAESDES.h"

@implementation NSString (ZJAESDES)

- (NSString *)zj_aes256EncryptWithKey:(NSString *)key
{
    NSData *result = [[self dataUsingEncoding:NSUTF8StringEncoding] zj_aesDesWithType:ZJ_AES_TYPE_256 key:key ccOperation:kCCEncrypt options:kCCOptionPKCS7Padding|kCCOptionECBMode iv:nil];
    NSData *base64Data = [result base64EncodedDataWithOptions:NSDataBase64Encoding64CharacterLineLength];
    NSString *resultStr = [[NSString alloc] initWithData:base64Data encoding:NSUTF8StringEncoding];
    return resultStr;
}

- (NSString *)zj_aes256DecryptWithKey:(NSString *)key
{
    NSData *result = [[self dataUsingEncoding:NSUTF8StringEncoding] zj_aesDesWithType:ZJ_AES_TYPE_256 key:key ccOperation:kCCDecrypt options:kCCOptionPKCS7Padding|kCCOptionECBMode iv:nil];
    return [[NSString alloc] initWithData:result encoding:NSUTF8StringEncoding];
}

@end
