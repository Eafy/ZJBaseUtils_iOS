//
//  NSString+ZJAESDES.h
//  ZJBaseUtils
//
//  Created by eafy on 2020/8/16.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ZJBaseUtils/NSData+ZJAESDES.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (ZJAESDES)

/// AES编码或DES解码
/// @param type 编码类型
/// @param key 秘钥
/// @param operation 编码或解码
/// @param options CCOptions类型
/// @param iv iv值
- (NSString * _Nullable)zj_aesDesWithType:(ZJ_AES_TYPE)type key:(NSString *)key ccOperation:(CCOperation)operation options:(CCOptions)options iv:(NSString * _Nullable)iv;

/// DES编码(输出Base64编码字符串)
/// @param key 秘钥
/// @param options 加密选项
/// @param iv iv
- (NSString *_Nullable)zj_desEncodeToBase64WithKey:(NSString *)key options:(CCOptions)options iv:(NSString * _Nullable)iv;

/// DES解码(输入Base64编码字符串)
/// @param key 秘钥
/// @param options 加密选项
/// @param iv iv
- (NSString *_Nullable)zj_desDecodeFromBase64WithKey:(NSString *)key options:(CCOptions)options iv:(NSString * _Nullable)iv;

/// DES编码(输出十六进制字符串)
/// @param key 秘钥
/// @param options 加密选项
/// @param iv iv
- (NSString *_Nullable)zj_desEncodeToHexWithKey:(NSString *)key options:(CCOptions)options iv:(NSString * _Nullable)iv;

/// DES解码(输入十六进制字符串)
/// @param key 秘钥
/// @param options 加密选项
/// @param iv iv
- (NSString *_Nullable)zj_desDecodeFromHexWithKey:(NSString *)key options:(CCOptions)options iv:(NSString * _Nullable)iv;

/// AES编码
/// @param key 秘钥
- (NSString * _Nullable)zj_aes256EncryptWithKey:(NSString *)key;

/// AES解码
/// @param key 秘钥
- (NSString * _Nullable)zj_aes256DecryptWithKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
