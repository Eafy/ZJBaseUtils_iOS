//
//  ZJAlertView.h
//  ZJBaseUtils
//
//  Created by eafy on 2020/12/10.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZJAlertAction.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, ZJAlertViewStyle) {
    ZJAlertViewStyleDefault = 0,    //普通样式
    ZJAlertViewStyleTextField,       //输入框样式
    
    ZJAlertViewStyleCustom          //自定义样式，即使用自定义的View进行显示
};

typedef NS_ENUM(NSInteger, ZJAlertViewAnimationStyle) {
    ZJAlertViewStyleAnimation1 = 0,
    ZJAlertViewStyleAnimation2
};

@interface ZJAlertView : UIView

/// 样式，默认普通样式
@property (nonatomic,assign) ZJAlertViewStyle style;
/// 动画样式
@property (nonatomic,assign) ZJAlertViewAnimationStyle animationStyle;
/// 自定义视图
@property (nonatomic,strong) UIView *customView;
/// 点击遮罩层隐藏，默认false
@property (nonatomic,assign) BOOL isTapMaskHide;

/// 标题
@property (nonatomic,copy) NSString * _Nullable title;
/// 消息内容
@property (nonatomic,copy) NSString * _Nullable message;
/// 标题视图图片名称
@property (nonatomic,copy) NSString * _Nullable titleImageName;
/// 关闭按钮图片名称
@property (nonatomic,copy) NSString * _Nullable closeImageName;
/// 是否隐藏关闭按钮
@property (nonatomic,assign) BOOL isHideCloseBtn;

/// 圆角，默认8.0
@property (nonatomic,assign) CGFloat cornerRadius;
/// 背景遮罩透明度，默认透明
@property (nonatomic,assign) CGFloat maskAlpha;
/// 标题颜色：0x181E28
@property (nonatomic,strong) UIColor *titleColor;
/// 标题字体：常规16
@property (nonatomic,strong) UIFont *titleFont;
/// 标题颜色：0x5A6482
@property (nonatomic,strong) UIColor *messageColor;
/// 标题字体：常规14
@property (nonatomic,strong) UIFont *messageFont;

/// 输入框文字
@property (nonatomic,copy) NSString *textFieldText;
/// 输入框样式
@property (nonatomic,assign) UIKeyboardType keyboardType;
/// 输入框文字颜色默认：0x181E28
@property (nonatomic,strong) UIColor *textFieldTextColor;
/// 输入框文字字体：常规16
@property (nonatomic,strong) UIFont *textFieldTextFont;
/// 输入框清除按钮图片
@property (nonatomic,copy) NSString * _Nullable textFieldClearImageName;
/// 输入框站位文字描述
@property (nonatomic,strong) NSAttributedString * _Nullable textFieldAttributedString;
/// 输入框左视图宽度，默认12
@property (nonatomic,assign) CGFloat textFieldLeftViewWidth;
/// 输入框代理
@property (nonatomic,weak) id<UITextFieldDelegate> textFieldDelegate;

#pragma mark -

/// 弹框AlertView（默认样式）
+ (instancetype)alertView;

/// 弹框AlertView
/// @param style 样式
+ (instancetype)alertViewWithStyle:(ZJAlertViewStyle)style;

/// 弹框AlertView（输入样式）
/// @param title 标题
+ (instancetype)alertInputViewWithTitle:(NSString * _Nullable)title;

/// 弹框AlertView（默认样式）
+ (instancetype)alertViewWithTitle:(NSString * _Nullable)title;

/// 弹框AlertView（默认样式）
+ (instancetype)alertViewWithTitle:(NSString * _Nullable)title message:(NSString * _Nullable)message;

/// 添加按钮
/// @param action 按钮
- (void)addAction:(ZJAlertAction *)action;

/// 显示
- (void)show;

/// 移除
- (void)dismiss;

@end

NS_ASSUME_NONNULL_END
