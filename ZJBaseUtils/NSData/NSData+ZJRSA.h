//
//  NSData+ZJRSA.h
//  ZJBaseUtils
//
//  Created by eafy on 2020/8/16.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSData (ZJRSA)

/// RSA加密
/// @param keyRef SecKeyRef描述
/// @param isSign 是否加标签
- (NSData *)zj_rsaEncryptWithKeyRef:(SecKeyRef)keyRef isSign:(BOOL)isSign;

/// RSA加密
/// @param pubKey 公钥
- (NSData *)zj_rsaEncryptWithPublicKey:(NSString *)pubKey;

/// RSA加密
/// @param privKey 私钥
- (NSData *)zj_rsaEncryptWithPrivateKey:(NSString *)privKey;

/// RSA解密
/// @param keyRef keyRef SecKeyRef描述
- (NSData *)zj_rsaDecrypttWithKeyRef:(SecKeyRef)keyRef;

/// RSA解密
/// @param pubKey 公钥
- (NSData *)zj_rsaDecryptWithPublicKey:(NSString *)pubKey;

/// RSA解密
/// @param privKey 私钥
- (NSData *)zj_rsaDecryptWithPrivateKey:(NSString *)privKey;

@end

NS_ASSUME_NONNULL_END
