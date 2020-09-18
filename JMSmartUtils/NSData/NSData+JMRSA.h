//
//  NSData+JMRSA.h
//  JMBaseUtils
//
//  Created by lzj<lizhijian_21@163.com> on 2020/8/16.
//  Copyright © 2020 Jimi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSData (JMRSA)

/// RSA加密
/// @param keyRef SecKeyRef描述
/// @param isSign 是否加标签
- (NSData *)jm_rsaEncryptWithKeyRef:(SecKeyRef)keyRef isSign:(BOOL)isSign;

/// RSA加密
/// @param pubKey 公钥
- (NSData *)jm_rsaEncryptWithPublicKey:(NSString *)pubKey;

/// RSA加密
/// @param privKey 私钥
- (NSData *)jm_rsaEncryptWithPrivateKey:(NSString *)privKey;

/// RSA解密
/// @param keyRef keyRef SecKeyRef描述
- (NSData *)jm_rsaDecrypttWithKeyRef:(SecKeyRef)keyRef;

/// RSA解密
/// @param pubKey 公钥
- (NSData *)jm_rsaDecryptWithPublicKey:(NSString *)pubKey;

/// RSA解密
/// @param privKey 私钥
- (NSData *)jm_rsaDecryptWithPrivateKey:(NSString *)privKey;

@end

NS_ASSUME_NONNULL_END
