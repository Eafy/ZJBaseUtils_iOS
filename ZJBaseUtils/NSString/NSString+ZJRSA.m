//
//  NSString+ZJRSA.m
//  ZJBaseUtils
//
//  Created by eafy on 2020/8/16.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import <ZJBaseUtils/NSString+ZJRSA.h>
#import <ZJBaseUtils/NSData+ZJRSA.h>
#import <ZJBaseUtils/NSData+ZJExt.h>

@implementation NSString (ZJRSA)

- (NSString *)zj_rsaEncryptWithPublicKey:(NSString *)pubKey
{
    if(!self || !pubKey){
        return nil;
    }
    
    NSData *data = [[self dataUsingEncoding:NSUTF8StringEncoding] zj_rsaEncryptWithPublicKey:pubKey];
    NSString *ret = [data zj_toBase64String];
    return ret;
}

- (NSString *)zj_rsaEncryptWithPrivateKey:(NSString *)privKey
{
    if(!self || !privKey){
        return nil;
    }
    
    NSData *data = [[self dataUsingEncoding:NSUTF8StringEncoding] zj_rsaEncryptWithPublicKey:privKey];
    NSString *ret = [data zj_toBase64String];
    return ret;
}

- (NSString *)zj_rsaDecryptWithPublicKey:(NSString *)pubKey
{
    if(!self || !pubKey){
        return nil;
    }
    
    NSData *data = [[NSData alloc] initWithBase64EncodedString:self options:NSDataBase64DecodingIgnoreUnknownCharacters];
    data = [data zj_rsaDecryptWithPublicKey:pubKey];
    NSString *ret = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return ret;
}

- (NSString *)zj_rsaDecryptWithPrivateKey:(NSString *)privKey
{
    if(!self || !privKey){
        return nil;
    }
    
    NSData *data = [[NSData alloc] initWithBase64EncodedString:self options:NSDataBase64DecodingIgnoreUnknownCharacters];
    data = [data zj_rsaDecryptWithPrivateKey:privKey];
    NSString *ret = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return ret;
}

@end
