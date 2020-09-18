//
//  NSString+JMSHA.m
//  JMBaseUtils
//
//  Created by lzj<lizhijian_21@163.com> on 2020/8/16.
//  Copyright © 2020 Jimi. All rights reserved.
//

#import "NSString+JMSHA.h"
#import "NSString+JMExt.h"
#import <CommonCrypto/CommonCryptor.h>
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonHMAC.h>

@implementation NSString (JMSHA)

- (NSString *)jm_sha1String
{
    const char *string = self.UTF8String;
    int length = (int)strlen(string);
    unsigned char bytes[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(string, length, bytes);
    return [NSString jm_stringFromBytes:bytes length:CC_SHA1_DIGEST_LENGTH];
}

- (NSString *)jm_sha256String
{
    const char *string = self.UTF8String;
    int length = (int)strlen(string);
    unsigned char bytes[CC_SHA256_DIGEST_LENGTH];
    CC_SHA256(string, length, bytes);
    return [NSString jm_stringFromBytes:bytes length:CC_SHA256_DIGEST_LENGTH];
}

- (NSString *)jm_sha512String
{
    const char *string = self.UTF8String;
    int length = (int)strlen(string);
    unsigned char bytes[CC_SHA512_DIGEST_LENGTH];
    CC_SHA512(string, length, bytes);
    return [NSString jm_stringFromBytes:bytes length:CC_SHA512_DIGEST_LENGTH];
}

- (NSString *)jm_shaWithKey:(NSString *)key type:(JM_SHA_TYPE)type
{
    NSData *keyData = [key dataUsingEncoding:NSUTF8StringEncoding];
    NSData *messageData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableData *mutableData = [NSMutableData dataWithLength:CC_SHA1_DIGEST_LENGTH];
    
    CCHmacAlgorithm mode = kCCHmacAlgSHA1;
    switch (type) {
        case JM_SHA_TYPE_1:
            mode = kCCHmacAlgSHA1;
            break;
        case JM_SHA_TYPE_256:
            mode = kCCHmacAlgSHA256;
            break;
        case JM_SHA_TYPE_512:
            mode = kCCHmacAlgSHA512;
            break;
    }
    CCHmac(mode, keyData.bytes, keyData.length, messageData.bytes, messageData.length, mutableData.mutableBytes);
    return [NSString jm_stringFromBytes:(unsigned char *)mutableData.bytes length:mutableData.length];
}

@end
