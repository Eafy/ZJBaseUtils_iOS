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
/// 标题颜色（样式必须先设置，否则无效）
@property (nonatomic,strong) UIColor * titleColor;
/// 标题字体（样式必须先设置，否则无效）
@property (nonatomic,strong) UIFont *titleFont;

@property (nonatomic,copy) void (^ _Nullable handler)(ZJAlertAction *action);

+ (instancetype)action;

+ (instancetype)actionWithTitle:(NSString * _Nullable)title style:(UIAlertActionStyle)style handler:(void (^ __nullable)(ZJAlertAction *action))handler;

+ (instancetype)actionDefaultWithTitle:(NSString * _Nullable)title handler:(void (^ _Nullable)(ZJAlertAction *action))handler;

+ (instancetype)actionCancelWithTitle:(NSString * _Nullable)title handler:(void (^ _Nullable)(ZJAlertAction *action))handler;

+ (instancetype)actionDestructiveWithTitle:(NSString * _Nullable)title handler:(void (^ _Nullable)(ZJAlertAction *action))handler;

@end

NS_ASSUME_NONNULL_END
