//
//  ZJThread.h
//  ZJBaseUtils
//
//  Created by eafy on 2020/9/26.
//  Copyright © 2020 ZJ<lizhijian_21@163.com>. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZJThread : NSThread

/// 是否正在休眠
@property (readonly) BOOL isSleep;
/// 是否正在运行
@property (readonly) BOOL isRunning;

/// 休眠线程
/// @param ti 休眠时间（秒）
- (void)sleep:(NSTimeInterval)ti;

/// 唤醒线程
- (void)wakeup;

#pragma mark -

+ (ZJThread *)current;

+ (BOOL)isSleep;

+ (BOOL)isRunning;

/// 休眠线程
/// @param ti 休眠时间（秒）
+ (void)sleep:(NSTimeInterval)ti;

/// 唤醒线程
+ (void)wakeup;

@end

NS_ASSUME_NONNULL_END
