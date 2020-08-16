//
//  NSString+ZJAESDES.h
//  ZJBaseUtils
//
//  Created by eafy on 2020/8/16.
//  Copyright © 2020 ZJ<lizhijian_21@163.com>. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (ZJAESDES)

/// AES编码
/// @param key 秘钥
- (NSString *)zj_aes256EncryptWithKey:(NSString *)key;

/// AES解码
/// @param key 秘钥
- (NSString *)zj_aes256DecryptWithKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
