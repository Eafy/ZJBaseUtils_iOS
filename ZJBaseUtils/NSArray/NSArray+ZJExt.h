//
//  NSArray+ZJExt.h
//  ZJBaseUtils
//
//  Created by eafy on 2020/8/11.
//  Copyright © 2020 Eafy<lizhijian_21@163.com>. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray (ZJExt)

/// 转换为Json字符串
- (NSString *)zj_toJsonString;

/// 计算2个数组的交集
/// @param array 对比的数组
- (NSArray *)zj_intersecWithArray:(NSArray *)array;

/// 计算2个数组的差集
/// @param array 对比的数组
- (NSArray *)zj_exceptWithArray:(NSArray *)array;

/// 计算2个数组的并集
/// @param array 对比的数组
- (NSArray *)zj_unionWithArray:(NSArray *)array;

/// 反转数组（反序）
- (NSArray *)zj_reverseArray;

@end

NS_ASSUME_NONNULL_END
