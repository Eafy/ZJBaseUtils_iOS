//
//  NSString+ZJRSA.h
//  ZJBaseUtils
//
//  Created by eafy on 2020/8/16.
//  Copyright © 2020 ZJ<lizhijian_21@163.com>. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (ZJRSA)

/// RSA 加密
/// @param pubKey 公钥
- (NSString *)zj_rsaEncryptWithPublicKey:(NSString *)pubKey;

/// RSA 加密
/// @param privKey 私钥
- (NSString *)zj_rsaEncryptWithPrivateKey:(NSString *)privKey;

/// RSA 解密
/// @param pubKey 公钥
- (NSString *)zj_rsaDecryptWithPublicKey:(NSString *)pubKey;

/// RSA 解密
/// @param privKey 私钥
- (NSString *)zj_rsaDecryptWithPrivateKey:(NSString *)privKey;

@end

NS_ASSUME_NONNULL_END
