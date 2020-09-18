//
//  NSString+JMAESDES.h
//  JMBaseUtils
//
//  Created by lzj<lizhijian_21@163.com> on 2020/8/16.
//  Copyright © 2020 Jimi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (JMAESDES)

/// AES编码
/// @param key 秘钥
- (NSString *)jm_aes256EncryptWithKey:(NSString *)key;

/// AES解码
/// @param key 秘钥
- (NSString *)jm_aes256DecryptWithKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
