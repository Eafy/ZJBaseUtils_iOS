//
//  ZJSheetAction.h
//  ZJBaseUtils
//
//  Created by eafy on 2020/12/14.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, ZJSheetActionStyle) {
    ZJSheetActionStyleDefault = 0,      //默认单标题Action
    ZJSheetActionStyleDetail,   //带详情的Action
    ZJSheetActionStyleCancel,       //取消Action
};

@interface ZJSheetAction : UIButton

/// Action样式
@property (nonatomic,assign) ZJSheetActionStyle style;

@property (nonatomic,copy) void (^ _Nullable handler)(ZJSheetAction *action);

/// 标题
@property (nonatomic,copy) NSString *title;
/// 标题颜色
@property (nonatomic,strong) UIColor *titleColor;
/// 标题字体
@property (nonatomic,strong) UIFont *titleFont;

/// 详情
@property (nonatomic,copy) NSString * _Nullable detailTitle;
/// 详情颜色
@property (nonatomic,strong) UIColor *detailTitleColor;
/// 详情字体
@property (nonatomic,strong) UIFont *detailTitleFont;

/// 高度，默认48，带详情64
@property (nonatomic,assign) CGFloat height;


/// 根据样式创建Action
/// @param title 标题
/// @param style 样式
/// @param handler 回调
+ (instancetype)actionWithTitle:(NSString * _Nullable)title style:(ZJSheetActionStyle)style handler:(void (^ __nullable)(ZJSheetAction *action))handler;

/// 创建默认样式
/// @param title 标题
/// @param handler 回调
+ (instancetype)actionDefaultWithTitle:(nullable NSString *)title handler:(void (^ __nullable)(ZJSheetAction *action))handler;

/// 创建详情样式
/// @param title 标题
/// @param detail 详情
/// @param handler 回调
+ (instancetype)actionDetailWithTitle:(nullable NSString *)title detail:(NSString *)detail handler:(void (^ __nullable)(ZJSheetAction *action))handler;

/// 创建取消样式
/// @param title 标题
/// @param handler 回调
+ (instancetype)actionCancellWithTitle:(nullable NSString *)title handler:(void (^ __nullable)(ZJSheetAction *action))handler;


@end

NS_ASSUME_NONNULL_END
