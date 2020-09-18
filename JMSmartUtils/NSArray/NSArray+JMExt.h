//
//  NSArray+JMExt.h
//  JMBaseUtils
//
//  Created by lzj<lizhijian_21@163.com> on 2020/8/11.
//  Copyright © 2020 lzj<lizhijian_21@163.com><lizhijian_21@163.com>. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray (JMExt)

/// 转换为Json字符串
- (NSString *)jm_toJsonString;

/// 计算2个数组的交集
/// @param array 对比的数组
- (NSArray *)jm_intersecWithArray:(NSArray *)array;

/// 计算2个数组的差集
/// @param array 对比的数组
- (NSArray *)jm_exceptWithArray:(NSArray *)array;

/// 计算2个数组的并集
/// @param array 对比的数组
- (NSArray *)jm_unionWithArray:(NSArray *)array;

/// 反转数组（反序）
- (NSArray *)jm_reverseArray;

@end

NS_ASSUME_NONNULL_END
