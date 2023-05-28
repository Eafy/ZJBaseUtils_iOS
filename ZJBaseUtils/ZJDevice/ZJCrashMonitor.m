//
//  ZJCrashMonitor.m
//  ZJBaseUtils
//
//  Created by eafy on 2023/5/28.
//  Copyright © 2023 ZJ. All rights reserved.
//

#import "ZJCrashMonitor.h"
#import <UIKit/UIKit.h>

NSString *const kZJCrashName = @"kZJCrashName";
NSString *const kZJCrashReason = @"kZJCrashName";
NSString *const kZJCrashStackSymbols = @"kZJCrashName";
NSString *const kZJCrashCount = @"kZJCrashCount";

typedef void (^ZJCrashMonitorCb)(NSDictionary *info);
static ZJCrashMonitorCb __gCrashMonitorCb = nil;
static NSUncaughtExceptionHandler *__gPreUncaughtExceptionHandler = nil;

/// 启动的间隔时间
static CGFloat __gLaunchCrachIntervalTime = 5;
/// 启动的闪退次数
static NSInteger __gLaunchCrachCount = 3;
static id __gKillMessageObserver = nil;

@implementation ZJCrashMonitor

static void uncaughtExceptionHandler(NSException *exception) {
    if (!__gCrashMonitorCb) return;
    // 异常的堆栈信息
    NSArray *stackArray = [exception callStackSymbols];
    // 出现异常的原因
    NSString *reason = [exception reason];
    // 异常名称
    NSString *name = [exception name];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:name forKey:kZJCrashName];
    [dic setValue:reason forKey:kZJCrashReason];
    [dic setValue:stackArray forKey:kZJCrashStackSymbols];
    __gCrashMonitorCb(dic);
    if (__gPreUncaughtExceptionHandler) {
        __gPreUncaughtExceptionHandler(exception);
    }
}

+ (void)registerCrashHandler:(nullable void (^)(NSDictionary *info))infoCb {
    if (infoCb) {
        __gPreUncaughtExceptionHandler = NSGetUncaughtExceptionHandler();   //保存上1个异常处理句柄
        NSSetUncaughtExceptionHandler(&uncaughtExceptionHandler);
    } else {
        if (__gPreUncaughtExceptionHandler) {
            NSSetUncaughtExceptionHandler(__gPreUncaughtExceptionHandler);
            __gPreUncaughtExceptionHandler = nil;
        } else {
            NSSetUncaughtExceptionHandler(nil);
        }
    }
    __gCrashMonitorCb = infoCb;
}

+ (BOOL)checkCrashCountOnLaunch:(CGFloat)intervalTime count:(NSInteger)count {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSInteger crashCount = [userDefaults integerForKey:kZJCrashCount];
    [userDefaults setInteger:crashCount + 1 forKey:kZJCrashCount];
    [userDefaults synchronize];
    
    if (intervalTime > 1) {
        __gLaunchCrachIntervalTime = intervalTime;
    }
    if (count > 0) {
        __gLaunchCrachCount = count;
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, __gLaunchCrachIntervalTime * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:kZJCrashCount];
        [[NSUserDefaults standardUserDefaults] synchronize];
        if (__gKillMessageObserver) {
            [[NSNotificationCenter defaultCenter] removeObserver:__gKillMessageObserver];
            __gKillMessageObserver = nil;
        }
    });
    if (crashCount > __gLaunchCrachCount) {
        return YES;
    }
    if (!__gKillMessageObserver) {
        __gKillMessageObserver = [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationWillTerminateNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
            [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:kZJCrashCount];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }];
    }
    return NO;
}

+ (void)clearCrashCount {
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:kZJCrashCount];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
