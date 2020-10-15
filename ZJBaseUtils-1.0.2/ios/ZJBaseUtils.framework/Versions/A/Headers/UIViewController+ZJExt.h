//
//  UIViewController+ZJExt.h
//  ZJBaseUtils
//
//  Created by eafy on 2020/8/18.
//  Copyright © 2020 ZJ<lizhijian_21@163.com>. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (ZJExt)

/// 获取当前显示的控制器
+ (UIViewController *_Nullable)zj_currentViewController;

/// 查找destVc的上一个控制器
/// @param destVc 索引控制器
+ (UIViewController *)zj_findPresentedViewController:(UIViewController *)destVc;

/// 退出所有控制器，直到与window.rootViewController或destVc相等为止
/// @param destVc 目标控制器
+ (void)exitViewController:(Class _Nonnull)destVc;

/// 推出所有控制器直到toVc
/// @param currentVc 当前控制器
/// @param toVc 目标控制器
+ (void)exitViewController:(UIViewController * _Nullable)currentVc toVC:(Class _Nonnull)toVc;

#pragma mark -

/// 显示AlertView提示框
/// @param title 标题
/// @param msg 消息内容
/// @param firstBtnName 第一个按钮文字(左边)，若为nil则不显示
/// @param firstHandler firstBtn处理回调
/// @param secondBtnName 第二个按钮文字(右边)，若为nil则不显示，若firstBtnName为nil则显示一个按键
/// @param secondHandler secondBtn处理回调
/// @param isShow 是否显示
- (UIAlertController *)zj_showAlertController:(NSString *_Nullable)title message:(NSString *_Nullable)msg firstBtnName:(NSString *_Nonnull)firstBtnName handler:(void (^ __nullable)(UIAlertAction * _Nullable action))firstHandler secondBtnName:(NSString *_Nullable)secondBtnName handler:(void (^ __nullable)(UIAlertAction * _Nullable action))secondHandler isShow:(BOOL)isShow;

@end

NS_ASSUME_NONNULL_END
