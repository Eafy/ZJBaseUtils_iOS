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

/// 数组计算交集(两数组比较取相同，组成新数组)
/// @param array 需对比处理的数组
- (NSArray *)zj_intersecWithArray:(NSArray *)array;

/// 数组计算差集(两数组比较取不同，组成新数组)
/// @param array 需对比处理的数组
- (NSArray *)zj_exceptWithArray:(NSArray *)array;

/// 数组计算并集(两数组数据合并，组成新数组)
/// @param array 需对比处理的数组
- (NSArray *)zj_unionWithArray:(NSArray *)array;

/// 反转数组
- (NSArray *)zj_reverseArray;

@end

NS_ASSUME_NONNULL_END
