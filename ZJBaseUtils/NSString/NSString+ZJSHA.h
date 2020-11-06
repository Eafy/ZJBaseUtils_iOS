//
//  NSString+ZJSHA.h
//  ZJBaseUtils
//
//  Created by eafy on 2020/8/16.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, ZJ_SHA_TYPE) {
    ZJ_SHA_TYPE_1 = 1,
    ZJ_SHA_TYPE_256 = 2,
    ZJ_SHA_TYPE_512 = 3
};

@interface NSString (ZJSHA)

@property (readonly) NSString *zj_sha1String;
@property (readonly) NSString *zj_sha256String;
@property (readonly) NSString *zj_sha512String;

/// SHA加密
/// @param key 加密的key
/// @param type 加密类型
- (NSString *)zj_shaWithKey:(NSString *)key type:(ZJ_SHA_TYPE)type;

@end

NS_ASSUME_NONNULL_END
