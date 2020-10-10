//
//  NSThread+ZJExt.h
//  ZJBaseUtils
//
//  Created by eafy on 2020/8/16.
//  Copyright © 2020 ZJ<lizhijian_21@163.com>. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSThread (ZJExt)

/// 是否正在休眠
@property (readonly) BOOL zj_isSleep;
/// 线程信号量
@property (readonly) NSCondition *zj_condition;

/// 休眠线程
/// @param ti 休眠时间（秒）
- (void)zj_sleep:(NSTimeInterval)ti;

/// 唤醒线程
- (void)zj_wakeup;

@end

NS_ASSUME_NONNULL_END
