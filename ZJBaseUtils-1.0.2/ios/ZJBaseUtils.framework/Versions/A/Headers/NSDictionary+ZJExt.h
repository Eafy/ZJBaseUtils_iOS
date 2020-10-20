//
//  NSDictionary+ZJExt.h
//  ZJBaseUtils
//
//  Created by eafy on 2020/8/16.
//  Copyright © 2020 ZJ<lizhijian_21@163.com>. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (ZJExt)

/// 转换为Json字符串
- (NSString *)zj_toJsonString;

@end

NS_ASSUME_NONNULL_END