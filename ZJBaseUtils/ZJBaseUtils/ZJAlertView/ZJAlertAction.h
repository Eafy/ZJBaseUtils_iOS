//
//  ZJAlertAction.h
//  ZJBaseUtils
//
//  Created by eafy on 2020/12/10.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZJAlertAction : UIButton

/// 样式
/// Default：（0x3D7DFF，中黑16）
/// Cancel：（0x5A6482，常规16）
/// Destructive：（0xF45C5C，常规16）
@property (nonatomic,assign) UIAlertActionStyle style;

/// 标题
@property (nonatomic,copy) NSString *title;
/// 标题颜色
@property (nonatomic,strong) UIColor * titleColor;
/// 标题字体
@property (nonatomic,strong) UIFont *titleFont;

@property (nonatomic,copy) void (^ _Nullable handler)(ZJAlertAction *action);

/// 快速创建一个按钮样式（默认样式）
+ (instancetype)action;

/// 创建AlertAction样式
/// @param title 标题
/// @param style 按钮样式
/// @param handler 回调
+ (instancetype)actionWithTitle:(NSString * _Nullable)title style:(UIAlertActionStyle)style handler:(void (^ __nullable)(ZJAlertAction *action))handler;

/// 默认样式
/// @param title 标题
/// @param handler 回调
+ (instancetype)actionDefaultWithTitle:(NSString * _Nullable)title handler:(void (^ _Nullable)(ZJAlertAction *action))handler;

/// 取消样式
/// @param title 标题
/// @param handler 回调
+ (instancetype)actionCancelWithTitle:(NSString * _Nullable)title handler:(void (^ _Nullable)(ZJAlertAction *action))handler;

/// 警告样式
/// @param title 标题
/// @param handler 回调
+ (instancetype)actionDestructiveWithTitle:(NSString * _Nullable)title handler:(void (^ _Nullable)(ZJAlertAction *action))handler;

@end

NS_ASSUME_NONNULL_END
