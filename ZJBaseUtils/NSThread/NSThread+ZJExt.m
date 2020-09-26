//
//  NSThread+ZJExt.m
//  ZJBaseUtils
//
//  Created by eafy on 2020/8/16.
//  Copyright © 2020 ZJ<lizhijian_21@163.com>. All rights reserved.
//

#import "NSThread+ZJExt.h"
#include <objc/runtime.h>

static const void *kZJCustomConditionKey = &kZJCustomConditionKey;
static const void *kZJCustomIsSleepKey = &kZJCustomIsSleepKey;

@interface NSThread (ZJExt)

/// 线程信号量
@property (nonatomic, strong) NSCondition *zj_condition;

@end

@implementation NSThread (ZJExt)

- (void)setZj_condition:(NSCondition *)condition
{
    objc_setAssociatedObject(self, kZJCustomConditionKey, condition, OBJC_ASSOCIATION_RETAIN);
}

- (NSCondition *)zj_condition {
    return objc_getAssociatedObject(self, kZJCustomConditionKey);
}

- (void)setZj_isSleep:(BOOL)isSleep {
    objc_setAssociatedObject(self, kZJCustomIsSleepKey, [NSNumber numberWithBool:isSleep], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)zj_isSleep {
    return [objc_getAssociatedObject(self, kZJCustomIsSleepKey) boolValue];
}

#pragma mark -

- (void)zj_sleep:(NSTimeInterval)ti
{
    if (!self.zj_condition) {
        self.zj_condition = [[NSCondition alloc] init];
    }
    [self.zj_condition lock];
    
    self.zj_isSleep = YES;
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:ti];
    BOOL signaled = NO;
    while (self.zj_isSleep && (signaled = [self.zj_condition waitUntilDate:date])) {
    }
    
    self.zj_isSleep = NO;
    [self.zj_condition unlock];
}

- (void)zj_wakeup
{
    [self.zj_condition lock];
    self.zj_isSleep = NO;
    [self.zj_condition signal];
    [self.zj_condition unlock];
}

@end
