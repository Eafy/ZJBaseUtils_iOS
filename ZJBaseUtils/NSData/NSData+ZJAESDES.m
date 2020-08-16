//
//  NSData+ZJAESDES.m
//  ZJBaseUtils
//
//  Created by eafy on 2020/8/16.
//  Copyright © 2020 ZJ<lizhijian_21@163.com>. All rights reserved.
//

#import "NSData+ZJAESDES.h"

@implementation NSData (ZJAESDES)

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
            keySize = kCCKeySizeDES;
            algorithm = kCCAlgorithmDES;
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
    NSInteger keyLength = MAX(keySize, key.length);
    char keyPtr[keyLength + 1];
    bzero(keyPtr, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = self.length;
    size_t bufferSize = dataLength + blockSize;
    void * buffer = malloc(bufferSize);
    size_t numBytesDecrypted = 0;
    char ivPtr[blockSize+1];
    memset(ivPtr, 0, sizeof(ivPtr));
    if (iv != nil) {
        [iv getCString:ivPtr maxLength:sizeof(ivPtr) encoding:NSUTF8StringEncoding];
    }
    CCCryptorStatus cryptStatus = CCCrypt(operation,
                                          algorithm,
                                          options,
                                          keyPtr,
                                          keySize,
                                          ivPtr,
                                          self.bytes,
                                          dataLength,
                                          buffer,
                                          bufferSize,
                                          &numBytesDecrypted);
    if (cryptStatus == kCCSuccess) {
        NSData * result = [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted];
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
