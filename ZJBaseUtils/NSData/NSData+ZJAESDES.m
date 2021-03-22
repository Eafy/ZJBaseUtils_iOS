//
//  NSData+ZJAESDES.m
//  ZJBaseUtils
//
//  Created by eafy on 2020/8/16.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import "NSData+ZJAESDES.h"

@implementation NSData (ZJAESDES)

- (NSData *_Nullable)zj_desWithType:(CCOperation)type key:(NSString *)key options:(CCOptions)options iv:(NSString * _Nullable)iv
{
    CCAlgorithm algorithm = kCCAlgorithmDES;
    NSUInteger blockSize = kCCBlockSizeDES;
    NSUInteger keySize = kCCKeySizeDES;
    
    size_t bufferSize = (self.length + blockSize) & ~(blockSize - 1);
    void * buffer = malloc(bufferSize);
    memset(buffer, 0, bufferSize);
    
    size_t numBytesDecrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(type,
                                          algorithm,
                                          options,
                                          [key UTF8String],
                                          keySize,
                                          iv ? [iv UTF8String] : NULL,
                                          self.bytes,
                                          self.length,
                                          buffer,
                                          bufferSize,
                                          &numBytesDecrypted);
    
    NSData *result = nil;
    if (cryptStatus == kCCSuccess) {
        result = [NSData dataWithBytes:buffer length:numBytesDecrypted];
    }
    
    if (buffer) {
        free(buffer);
        buffer = NULL;
    }
    return result;
}

- (NSData *)zj_aesDesWithType:(ZJ_AES_TYPE)type key:(NSString *)key ccOperation:(CCOperation)operation options:(CCOptions)options iv:(NSString *)iv
{
    NSUInteger keySize;
    CCAlgorithm algorithm;
    NSUInteger blockSize;
    switch (type) {
        case ZJ_AES_TYPE_128: {
            keySize = kCCKeySizeAES128;
            algorithm = kCCAlgorithmAES128;
            blockSize = kCCBlockSizeAES128;
            break;
        }
        case ZJ_AES_TYPE_192: {
            keySize = kCCKeySizeAES192;
            algorithm = kCCAlgorithmAES128;
            blockSize = kCCBlockSizeAES128;
            break;
        }
        case ZJ_AES_TYPE_256: {
            keySize = kCCKeySizeAES256;
            algorithm = kCCAlgorithmAES128;
            blockSize = kCCBlockSizeAES128;
            break;
        }
        case ZJ_DES_TYPE_1: {
            algorithm = kCCAlgorithmDES;
            keySize = kCCKeySizeDES;
            blockSize = kCCBlockSizeDES;
            break;
        }
        case ZJ_DES_TYPE_3: {
            keySize = kCCKeySize3DES;
            algorithm = kCCAlgorithm3DES;
            blockSize = kCCBlockSize3DES;
            break;
        }
        default: {
            return nil;
        }
    }
    
    size_t bufferSize = self.length + blockSize;
    void * buffer = malloc(bufferSize);
    
    size_t numBytesDecrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(operation,
                                          algorithm,
                                          options,
                                          [key UTF8String],
                                          keySize,
                                          iv ? [iv UTF8String] : NULL,
                                          self.bytes,
                                          self.length,
                                          buffer,
                                          bufferSize,
                                          &numBytesDecrypted);
    if (cryptStatus == kCCSuccess) {
        NSData * result = [NSData dataWithBytes:buffer length:numBytesDecrypted];
        if (result != nil) {
            return result;
        }
    } else {
        if (buffer) {
            free(buffer);
            buffer = NULL;
        }
    }
    return nil;
}

- (NSData *)zj_aes256EncryptWithType:(ZJ_AES_TYPE)type key:(NSString *)key options:(CCOptions)options iv:(NSString *)iv
{
    NSData *encodeData = [self zj_aesDesWithType:type key:key ccOperation:kCCEncrypt options:options iv:iv];
    return encodeData;
}

- (NSData *)zj_aes256DecryptWithType:(ZJ_AES_TYPE)type key:(NSString *)key options:(CCOptions)options iv:(NSString *)iv
{
    return [self zj_aesDesWithType:ZJ_DES_TYPE_1 key:key ccOperation:kCCDecrypt options:options iv:iv];
}

@end
