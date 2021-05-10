//
//  NSString+ZJSHA.m
//  ZJBaseUtils
//
//  Created by eafy on 2020/8/16.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import "NSString+ZJSHA.h"
#import "NSString+ZJExt.h"
#import <CommonCrypto/CommonCryptor.h>
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonHMAC.h>

@implementation NSString (ZJSHA)

- (NSString *)zj_sha1String
{
    const char *string = self.UTF8String;
    int length = (int)strlen(string);
    unsigned char bytes[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(string, length, bytes);
    return [NSString zj_stringFromBytes:bytes length:CC_SHA1_DIGEST_LENGTH];
}

- (NSString *)zj_sha256String
{
    const char *string = self.UTF8String;
    int length = (int)strlen(string);
    unsigned char bytes[CC_SHA256_DIGEST_LENGTH];
    CC_SHA256(string, length, bytes);
    return [NSString zj_stringFromBytes:bytes length:CC_SHA256_DIGEST_LENGTH];
}

- (NSString *)zj_sha512String
{
    const char *string = self.UTF8String;
    int length = (int)strlen(string);
    unsigned char bytes[CC_SHA512_DIGEST_LENGTH];
    CC_SHA512(string, length, bytes);
    return [NSString zj_stringFromBytes:bytes length:CC_SHA512_DIGEST_LENGTH];
}

- (NSString *)zj_shaWithKey:(NSString *)key type:(ZJ_SHA_TYPE)type
{
    NSData *keyData = [key dataUsingEncoding:NSUTF8StringEncoding];
    NSData *messageData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableData *mutableData = [NSMutableData dataWithLength:CC_SHA1_DIGEST_LENGTH];
    
    CCHmacAlgorithm mode = kCCHmacAlgSHA1;
    switch (type) {
        case ZJ_SHA_TYPE_1:
            mode = kCCHmacAlgSHA1;
            break;
        case ZJ_SHA_TYPE_256:
            mode = kCCHmacAlgSHA256;
            break;
        case ZJ_SHA_TYPE_512:
            mode = kCCHmacAlgSHA512;
            break;
    }
    CCHmac(mode, keyData.bytes, keyData.length, messageData.bytes, messageData.length, mutableData.mutableBytes);
    return [NSString zj_stringFromBytes:(unsigned char *)mutableData.bytes length:mutableData.length];
}

@end
