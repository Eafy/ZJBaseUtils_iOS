//
//  NSData+ZJAESDES.h
//  ZJBaseUtils
//
//  Created by eafy on 2020/8/16.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCryptor.h>

typedef NS_ENUM(NSUInteger, ZJ_AES_TYPE) {
    ZJ_AES_TYPE_128      = 0,
    ZJ_AES_TYPE_192,
    ZJ_AES_TYPE_256,
    ZJ_DES_TYPE_1,
    ZJ_DES_TYPE_3,
};

NS_ASSUME_NONNULL_BEGIN

@interface NSData (ZJAESDES)

/// DES编码
/// @param key 秘钥
/// @param options 加密选项
/// @param iv iv
- (NSData *_Nullable)zj_desWithType:(CCOperation)type key:(NSString *)key options:(CCOptions)options iv:(NSString * _Nullable)iv;

/// AES编码或DES解码(未验证)
/// @param type 编码类型
/// @param key 秘钥
/// @param operation 编码或解码
/// @param options CCOptions类型
/// @param iv iv值
- (NSData *)zj_aesDesWithType:(ZJ_AES_TYPE)type key:(NSString *)key ccOperation:(CCOperation)operation options:(CCOptions)options iv:(NSString * _Nullable)iv;

/// AES编码
/// @param type 编码类型
/// @param key 秘钥
/// @param options CCOptions类型
/// @param iv iv值
- (NSData *)zj_aes256EncryptWithType:(ZJ_AES_TYPE)type key:(NSString *)key options:(CCOptions)options iv:(NSString * _Nullable)iv;

/// AES解码
/// @param type 编码类型
/// @param key 秘钥
/// @param options CCOptions类型
/// @param iv iv值
- (NSData *)zj_aes256DecryptWithType:(ZJ_AES_TYPE)type key:(NSString *)key options:(CCOptions)options iv:(NSString * _Nullable)iv;

@end

NS_ASSUME_NONNULL_END
