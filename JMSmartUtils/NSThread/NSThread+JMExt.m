//
//  NSThread+JMExt.m
//  JMBaseUtils
//
//  Created by lzj<lizhijian_21@163.com> on 2020/8/16.
//  Copyright © 2020 Jimi. All rights reserved.
//

#import "NSThread+JMExt.h"
#include <objc/runtime.h>

static const void *kJMCustomConditionKey = &kJMCustomConditionKey;
static const void *kJMCustomIsSleepKey = &kJMCustomIsSleepKey;

@implementation NSThread (JMExt)

- (void)setJm_condition:(NSCondition *)condition
{
    objc_setAssociatedObject(self, kJMCustomConditionKey, condition, OBJC_ASSOCIATION_RETAIN);
}

- (NSCondition *)jm_condition {
    return objc_getAssociatedObject(self, kJMCustomConditionKey);
}

- (void)setJm_isSleep:(BOOL)isSleep {
    objc_setAssociatedObject(self, kJMCustomIsSleepKey, [NSNumber numberWithBool:isSleep], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)jm_isSleep {
    return  [objc_getAssociatedObject(self, kJMCustomIsSleepKey) boolValue];
}

#pragma mark -

- (void)jm_sleep:(NSTimeInterval)ti
{
    if (!self.jm_condition) {
        self.jm_condition = [[NSCondition alloc] init];
    }
    [self.jm_condition lock];
    
    self.jm_isSleep = YES;
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:ti];
    BOOL signaled = NO;
    while (self.jm_isSleep && (signaled = [self.jm_condition waitUntilDate:date])) {
    }
    
    self.jm_isSleep = NO;
    [self.jm_condition unlock];
}

- (void)jm_wakeup
{
    [self.jm_condition lock];
    self.jm_isSleep = NO;
    [self.jm_condition signal];
    [self.jm_condition unlock];
}

@end
