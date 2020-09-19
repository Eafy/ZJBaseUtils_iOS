//
//  NSData+ZJExt.h
//  ZJBaseUtils
//
//  Created by eafy on 2020/8/12.
//  Copyright © 2020 ZJ<lizhijian_21@163.com>. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSData (ZJExt)

/// 转换为base64编码的字符串
- (NSString *)zj_base64String;

/// 转换为十六进制字符
- (NSString *)toHexString;

@end

NS_ASSUME_NONNULL_END
