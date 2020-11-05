//
//  NSString+ZJAESDES.m
//  ZJBaseUtils
//
//  Created by eafy on 2020/8/16.
//  Copyright © 2020 ZJ<lizhijian_21@163.com>. All rights reserved.
//

#import "NSString+ZJAESDES.h"

@implementation NSString (ZJAESDES)

- (NSString *)zj_aesDesWithType:(ZJ_AES_TYPE)type key:(NSString *)key ccOperation:(CCOperation)operation options:(CCOptions)options iv:(NSString *)iv
{
    NSData *result = nil;
    if (operation == kCCEncrypt) {
        result = [[self dataUsingEncoding:NSUTF8StringEncoding] zj_aesDesWithType:type key:key ccOperation:operation options:options iv:nil];
        result = [result base64EncodedDataWithOptions:NSDataBase64Encoding64CharacterLineLength];
    } else {
        result = [[self dataUsingEncoding:NSUTF8StringEncoding] zj_aesDesWithType:type key:key ccOperation:kCCDecrypt options:options iv:nil];
    }
    
    if (result) {
        NSString *resultStr = [[NSString alloc] initWithData:result encoding:NSUTF8StringEncoding];
        return resultStr;
    }
    
    return nil;
}

- (NSString *)zj_aes256EncryptWithKey:(NSString *)key
{
    return [self zj_aesDesWithType:ZJ_AES_TYPE_256 key:key ccOperation:kCCEncrypt options:kCCOptionPKCS7Padding|kCCOptionECBMode iv:nil];
}

- (NSString *)zj_aes256DecryptWithKey:(NSString *)key
{
    return [self zj_aesDesWithType:ZJ_AES_TYPE_256 key:key ccOperation:kCCDecrypt options:kCCOptionPKCS7Padding|kCCOptionECBMode iv:nil];
}

@end
