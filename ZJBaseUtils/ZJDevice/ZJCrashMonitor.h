//
//  ZJCrashMonitor.h
//  ZJBaseUtils
//
//  Created by eafy on 2023/5/28.
//  Copyright © 2023 ZJ. All rights reserved.
//

#import <Foundation/Foundation.h>

/// 闪退名称
extern NSString * _Nonnull const kZJCrashName;
/// 闪退原因
extern NSString * _Nonnull const kZJCrashReason;
/// 闪退栈信息（字符串列表）
extern NSString * _Nonnull const kZJCrashStackSymbols;

NS_ASSUME_NONNULL_BEGIN

@interface ZJCrashMonitor : NSObject

/// 注册闪退监控(如果之前注册了其他闪退收集，需要在注册其他sdk之后再次注册此方法，不影响第三方收集)
/// - Parameters:
///   - infoCb: 闪退信息
+ (void)registerCrashHandler:(nullable void (^)(NSDictionary *info))infoCb;

/// 检测启动连续闪退次数
/// - Parameter intervalTime: 启动闪退最小间隔时间(秒)，0使用默认值5
/// - Parameter count: 连续闪退次数，0使用默认值3
+ (BOOL)checkCrashCountOnLaunch:(CGFloat)intervalTime count:(NSInteger)count API_AVAILABLE(macos(10.6), ios(4.0), watchos(2.0), tvos(9.0));

/// 清除连续闪退次数
+ (void)clearCrashCount;


@end

NS_ASSUME_NONNULL_END
