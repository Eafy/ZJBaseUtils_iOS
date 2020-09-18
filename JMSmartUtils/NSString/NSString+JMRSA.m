//
//  NSString+JMRSA.m
//  JMBaseUtils
//
//  Created by lzj<lizhijian_21@163.com> on 2020/8/16.
//  Copyright © 2020 Jimi. All rights reserved.
//

#import "NSString+JMRSA.h"
#import "NSData+JMRSA.h"
#import "NSData+JMExt.h"

@implementation NSString (JMRSA)

- (NSString *)jm_rsaEncryptWithPublicKey:(NSString *)pubKey
{
    if(!self || !pubKey){
        return nil;
    }
    
    NSData *data = [[self dataUsingEncoding:NSUTF8StringEncoding] jm_rsaEncryptWithPublicKey:pubKey];
    NSString *ret = [data jm_base64String];
    return ret;
}

- (NSString *)jm_rsaEncryptWithPrivateKey:(NSString *)privKey
{
    if(!self || !privKey){
        return nil;
    }
    
    NSData *data = [[self dataUsingEncoding:NSUTF8StringEncoding] jm_rsaEncryptWithPublicKey:privKey];
    NSString *ret = [data jm_base64String];
    return ret;
}

- (NSString *)jm_rsaDecryptWithPublicKey:(NSString *)pubKey
{
    if(!self || !pubKey){
        return nil;
    }
    
    NSData *data = [[NSData alloc] initWithBase64EncodedString:self options:NSDataBase64DecodingIgnoreUnknownCharacters];
    data = [data jm_rsaDecryptWithPublicKey:pubKey];
    NSString *ret = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return ret;
}

- (NSString *)jm_rsaDecryptWithPrivateKey:(NSString *)privKey
{
    if(!self || !privKey){
        return nil;
    }
    
    NSData *data = [[NSData alloc] initWithBase64EncodedString:self options:NSDataBase64DecodingIgnoreUnknownCharacters];
    data = [data jm_rsaDecryptWithPrivateKey:privKey];
    NSString *ret = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return ret;
}

@end
