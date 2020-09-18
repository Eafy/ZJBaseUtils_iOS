//
//  NSString+JMRSA.h
//  JMBaseUtils
//
//  Created by lzj<lizhijian_21@163.com> on 2020/8/16.
//  Copyright © 2020 Jimi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (JMRSA)

/// RSA 加密
/// @param pubKey 公钥
- (NSString *)jm_rsaEncryptWithPublicKey:(NSString *)pubKey;

/// RSA 加密
/// @param privKey 私钥
- (NSString *)jm_rsaEncryptWithPrivateKey:(NSString *)privKey;

/// RSA 解密
/// @param pubKey 公钥
- (NSString *)jm_rsaDecryptWithPublicKey:(NSString *)pubKey;

/// RSA 解密
/// @param privKey 私钥
- (NSString *)jm_rsaDecryptWithPrivateKey:(NSString *)privKey;

@end

NS_ASSUME_NONNULL_END
