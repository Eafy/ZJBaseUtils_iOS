//
//  NSString+ZJMD5.h
//  ZJBaseUtils
//
//  Created by eafy on 2020/8/16.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (ZJMD5)

/// 返还32位MD5字符串（默认大写）
- (NSString *)zj_md5String;

/// 返还32位MD5字符串（默认小写）
- (NSString *)zj_md5LowercaseString;

/// 返还16位MD5字符串（默认大写）
- (NSString *)zj_md5For16String;

/// 返还32位MD5字符串（默认小写）
- (NSString *)zj_md5LowercaseFor16String;

@end

NS_ASSUME_NONNULL_END
