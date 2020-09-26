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
    self.isRunning = YES;
    [super start];
}

- (void)cancel
{
    self.isRunning = NO;
    [self wakeup];
    [super cancel];
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

+ (BOOL)isSleep
{
    return [(ZJThread *)[NSThread currentThread] isSleep];
}

+ (BOOL)isRunning
{
    return [(ZJThread *)[NSThread currentThread] isRunning];
}

+ (void)sleep:(NSTimeInterval)ti
{
    [(ZJThread *)[NSThread currentThread] sleep:ti];
}

+ (void)wakeup
{
    [(ZJThread *)[NSThread currentThread] wakeup];
}

@end
