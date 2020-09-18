//
//  UIViewController+JMExt.h
//  JMBaseUtils
//
//  Created by lzj<lizhijian_21@163.com> on 2020/8/18.
//  Copyright © 2020 Jimi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (JMExt)

/// 获取当前显示的控制器
+ (UIViewController *_Nullable)jm_currentViewController;

/// 查找destVc的上一个控制器
/// @param destVc 索引控制器
+ (UIViewController *)jm_findPresentedViewController:(UIViewController *)destVc;

/// 退出所有控制器，直到与window.rootViewController或destVc相等为止
/// @param destVc 目标控制器
+ (void)exitViewController:(Class _Nonnull)destVc;

/// 推出所有控制器直到toVc
/// @param currentVc 当前控制器
/// @param toVc 目标控制器
+ (void)exitViewController:(UIViewController * _Nullable)currentVc toVC:(Class _Nonnull)toVc;

@end

NS_ASSUME_NONNULL_END
