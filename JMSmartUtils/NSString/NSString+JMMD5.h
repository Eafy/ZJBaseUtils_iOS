//
//  NSString+JMMD5.h
//  JMBaseUtils
//
//  Created by lzj<lizhijian_21@163.com> on 2020/8/16.
//  Copyright © 2020 Jimi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (JMMD5)

/// 返还32位MD5字符串
- (NSString *)jm_md5String;

/// 返还16位MD5字符串
- (NSString *)jm_md5For16String;

@end

NS_ASSUME_NONNULL_END
