//
//  NSData+JMAESDES.h
//  JMBaseUtils
//
//  Created by lzj<lizhijian_21@163.com> on 2020/8/16.
//  Copyright © 2020 Jimi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCryptor.h>

typedef NS_ENUM(NSUInteger, JM_AES_TYPE) {
    JM_AES_TYPE_128      = 0,
    JM_AES_TYPE_192,
    JM_AES_TYPE_256,
    JM_DES_TYPE_1,
    JM_DES_TYPE_3,
};

NS_ASSUME_NONNULL_BEGIN

@interface NSData (JMAESDES)

/// AES编码或DES解码
/// @param type 编码类型
/// @param key 秘钥
/// @param operation 编码或解码
/// @param options CCOptions类型
/// @param iv iv值
- (NSData *)jm_aesDesWithType:(JM_AES_TYPE)type key:(NSString *)key ccOperation:(CCOperation)operation options:(CCOptions)options iv:(NSString * _Nullable)iv;

/// AES编码
/// @param type 编码类型
/// @param key 秘钥
/// @param options CCOptions类型
/// @param iv iv值
- (NSData *)jm_aes256EncryptWithType:(JM_AES_TYPE)type key:(NSString *)key options:(CCOptions)options iv:(NSString * _Nullable)iv;

/// AES解码
/// @param type 编码类型
/// @param key 秘钥
/// @param options CCOptions类型
/// @param iv iv值
- (NSData *)jm_aes256DecryptWithType:(JM_AES_TYPE)type key:(NSString *)key options:(CCOptions)options iv:(NSString * _Nullable)iv;

@end

NS_ASSUME_NONNULL_END
