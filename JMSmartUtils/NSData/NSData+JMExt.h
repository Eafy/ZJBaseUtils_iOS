//
//  NSData+JMExt.h
//  JMBaseUtils
//
//  Created by lzj<lizhijian_21@163.com> on 2020/8/12.
//  Copyright © 2020 Jimi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSData (JMExt)

/// 转换为base64编码的字符串
- (NSString *)jm_base64String;

/// 转换为十六进制字符
- (NSString *)toHexString;

@end

NS_ASSUME_NONNULL_END
