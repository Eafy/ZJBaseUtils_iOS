//
//  NSString+ZJAESDES.m
//  ZJBaseUtils
//
//  Created by eafy on 2020/8/16.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import <ZJBaseUtils/NSString+ZJAESDES.h>
#import <ZJBaseUtils/NSData+ZJExt.h>
#import <ZJBaseUtils/NSString+ZJExt.h>

@implementation NSString (ZJAESDES)

- (NSString *)zj_aesDesWithType:(ZJ_AES_TYPE)type key:(NSString *)key ccOperation:(CCOperation)operation options:(CCOptions)options iv:(NSString *)iv
{
    NSData *result = nil;
    if (operation == kCCEncrypt) {
        result = [[self dataUsingEncoding:NSUTF8StringEncoding] zj_aesDesWithType:type key:key ccOperation:operation options:options iv:iv];
        result = [result base64EncodedDataWithOptions:NSDataBase64Encoding64CharacterLineLength];
    } else {
        result = [[self dataUsingEncoding:NSUTF8StringEncoding] zj_aesDesWithType:type key:key ccOperation:kCCDecrypt options:options iv:iv];
    }
    
    if (result) {
        NSString *resultStr = [[NSString alloc] initWithData:result encoding:NSUTF8StringEncoding];
        return resultStr;
    }
    
    return nil;
}

- (NSString *_Nullable)zj_desEncodeToBase64WithKey:(NSString *)key options:(CCOptions)options iv:(NSString * _Nullable)iv
{
    NSString *result = nil;
    NSData *data = [[self dataUsingEncoding:NSUTF8StringEncoding] zj_desWithType:kCCEncrypt key:key options:options iv:iv];
    if (data) {
        result = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    }
    return result;
}

- (NSString *_Nullable)zj_desDecodeFromBase64WithKey:(NSString *)key options:(CCOptions)options iv:(NSString * _Nullable)iv
{
    NSString *result = nil;
    NSData *data = [[[NSData alloc] initWithBase64EncodedString:self options:NSDataBase64DecodingIgnoreUnknownCharacters] zj_desWithType:kCCDecrypt key:key options:options iv:iv];
    if (data) {
        result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    return result;
}

- (NSString *_Nullable)zj_desEncodeToHexWithKey:(NSString *)key options:(CCOptions)options iv:(NSString * _Nullable)iv
{
    NSString *result = nil;
    NSData *data = [[self dataUsingEncoding:NSUTF8StringEncoding] zj_desWithType:kCCEncrypt key:key options:options iv:iv];
    if (data) {
        result = [data zj_toHexString];
    }
    return result;
}

- (NSString *_Nullable)zj_desDecodeFromHexWithKey:(NSString *)key options:(CCOptions)options iv:(NSString * _Nullable)iv
{
    NSString *result = nil;
    NSData *data = [[self zj_toData] zj_desWithType:kCCDecrypt key:key options:options iv:iv];
    if (data) {
        result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    return result;
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
