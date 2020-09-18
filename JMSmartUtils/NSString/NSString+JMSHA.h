//
//  NSString+JMSHA.h
//  JMBaseUtils
//
//  Created by lzj<lizhijian_21@163.com> on 2020/8/16.
//  Copyright © 2020 Jimi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, JM_SHA_TYPE) {
    JM_SHA_TYPE_1 = 1,
    JM_SHA_TYPE_256 = 2,
    JM_SHA_TYPE_512 = 3
};

@interface NSString (JMSHA)

@property (readonly) NSString *jm_sha1String;
@property (readonly) NSString *jm_sha256String;
@property (readonly) NSString *jm_sha512String;

/// SHA加密
/// @param key 加密的key
/// @param type 加密类型
- (NSString *)jm_shaWithKey:(NSString *)key type:(JM_SHA_TYPE)type;

@end

NS_ASSUME_NONNULL_END
