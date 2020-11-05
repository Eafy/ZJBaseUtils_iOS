//
//  NSString+ZJAESDES.h
//  ZJBaseUtils
//
//  Created by eafy on 2020/8/16.
//  Copyright © 2020 ZJ<lizhijian_21@163.com>. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "NSData+ZJAESDES.h"

NS_ASSUME_NONNULL_BEGIN

@interface NSString (ZJAESDES)

/// AES编码或DES解码
/// @param type 编码类型
/// @param key 秘钥
/// @param operation 编码或解码
/// @param options CCOptions类型
/// @param iv iv值
- (NSString * _Nullable)zj_aesDesWithType:(ZJ_AES_TYPE)type key:(NSString *)key ccOperation:(CCOperation)operation options:(CCOptions)options iv:(NSString * _Nullable)iv;

/// AES编码
/// @param key 秘钥
- (NSString * _Nullable)zj_aes256EncryptWithKey:(NSString *)key;

/// AES解码
/// @param key 秘钥
- (NSString * _Nullable)zj_aes256DecryptWithKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
