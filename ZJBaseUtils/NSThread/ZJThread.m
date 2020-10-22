//
//  ZJThread.m
//  ZJBaseUtils
//
//  Created by eafy on 2020/9/26.
//  Copyright © 2020 ZJ<lizhijian_21@163.com>. All rights reserved.
//

#import "ZJThread.h"

@interface ZJThread ()

/// 线程信号量
@property (nonatomic, strong) NSCondition *condition;
@property (nonatomic,assign) BOOL isSleep;
@property (nonatomic,assign) BOOL isRunning;

@end

@implementation ZJThread

- (void)start
{
    if (!self.isRunning) {
        self.isRunning = YES;
        [super start];
    }
}

- (void)cancel
{
    if (self.isRunning) {
        self.isRunning = NO;
        [self wakeup];
        [super cancel];
    }
}

#pragma mark -

- (void)sleep:(NSTimeInterval)ti
{
    if (!self.condition) {
        self.condition = [[NSCondition alloc] init];
    }
    [self.condition lock];
    
    self.isSleep = YES;
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:ti];
    BOOL signaled = NO;
    while (self.isSleep && (signaled = [self.condition waitUntilDate:date])) {
    }
    
    self.isSleep = NO;
    [self.condition unlock];
}

- (void)wakeup
{
    [self.condition lock];
    self.isSleep = NO;
    [self.condition signal];
    [self.condition unlock];
}

#pragma mark -

+ (ZJThread *)current
{
    NSThread *thread = [NSThread currentThread];
    if ([thread isKindOfClass:[ZJThread class]]) {
        return (ZJThread *)thread;
    }
    
    return nil;
}

+ (BOOL)isSleep
{
    ZJThread *thread = [ZJThread current];
    if ([thread isKindOfClass:[ZJThread class]]) {
        return [thread isSleep];
    }
    return NO;
}

+ (BOOL)isRunning
{
    ZJThread *thread = [ZJThread current];
    if ([thread isKindOfClass:[ZJThread class]]) {
        return [thread isRunning];
    }
    return NO;
}

+ (void)sleep:(NSTimeInterval)ti
{
    ZJThread *thread = [ZJThread current];
    if ([thread isKindOfClass:[ZJThread class]]) {
        [thread sleep:ti];
    }
}

+ (void)wakeup
{
    ZJThread *thread = [ZJThread current];
    if ([thread isKindOfClass:[ZJThread class]]) {
        [thread wakeup];
    }
}

@end
