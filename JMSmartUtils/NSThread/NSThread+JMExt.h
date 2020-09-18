//
//  NSThread+JMExt.h
//  JMBaseUtils
//
//  Created by lzj<lizhijian_21@163.com> on 2020/8/16.
//  Copyright © 2020 Jimi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSThread (JMExt)

@property (atomic, assign) BOOL jm_isSleep;     //是否正在休眠
@property (atomic, strong) NSCondition *jm_condition;   //线程信号量

/// 休眠线程
/// @param ti 休眠时间（秒）
- (void)jm_sleep:(NSTimeInterval)ti;

/// 唤醒线程
- (void)jm_wakeup;

@end

NS_ASSUME_NONNULL_END
