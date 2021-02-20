//
//  ZJNotifyHUD.h
//  ZJUXKit
//
//  Created by eafy on 2020/10/15.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, ZJNotifyHUDAnimation) {
    ZJNotifyHUDAnimationFade,           //透明动画
    ZJNotifyHUDAnimationZoomOut,        //缩放（大到小）+透明
    ZJNotifyHUDAnimationZoomIn,         //缩放（小到到）+透明
    ZJNotifyHUDAnimationPopDownToUp,    //POP向下显示，向上消失
    ZJNotifyHUDAnimationPopDownToDown,  //POP向下显示，向下消失
    ZJNotifyHUDAnimationPopUpToDown,    //POP向上显示，向下消失
    ZJNotifyHUDAnimationPopUpToUp,      //POP向上显示，向上消失
    ZJNotifyHUDAnimationPopBottom,      //pop底部固定，固定Tabbar高度显示，可设置偏移
};

typedef NS_ENUM(NSInteger, ZJNotifyHUDRightViewStyle) {
    ZJNotifyHUDRightViewStyleNone,       //无右键
    ZJNotifyHUDRightViewStyleButton,    //右键按钮，需要设置回调才生效
};

@protocol ZJNotifyHUDDelegate;

@interface ZJNotifyHUD : UIView

+ (instancetype _Nonnull)shared;

/// 默认配置
- (void)defaultConfig;

/// 代理
@property (nonatomic,weak) id<ZJNotifyHUDDelegate> delegate;

/// 显示动画
@property (nonatomic,assign) ZJNotifyHUDAnimation animationType;

/// 右边操作按键样式，默认无，其他默认带遮罩
@property (nonatomic,assign) ZJNotifyHUDRightViewStyle rightViewStyle;

/// 左侧头视图（这个是全局配置，单独显示需要置空，优先使用单设）
@property (nonatomic,strong) UIImage * _Nullable iconImage;
/// 显示文字字体大小，默认：常规16
@property (nonatomic,strong) UIFont * _Nullable font;
/// 显示文字颜色，默认白色
@property (nonatomic,strong) UIColor * _Nullable titleColor;
/// 文字行间距，暂时无效
@property (nonatomic,assign) CGFloat textSpace;

/// 圆角，默认4
@property (nonatomic,assign) CGFloat cornerRadius;
/// 上下空余空间，默认6
@property (nonatomic,assign) CGFloat marginUpDown;
/// 左右空余空间，默认12
@property (nonatomic,assign) CGFloat marginLeftRight;

/// 右边操作按钮，默认懒加载且会自动设置frame
@property (nonatomic,strong) UIButton *rightOperationBtn;
/// 右边操作按钮点击回调，每次显示都需要调用，内部会置空
@property (nonatomic,copy) void (^ _Nullable tapRightBtnUpInsideCompletion)(UIButton *btn);

/// 显示消息通知HUD
/// @param iconName 头视图图片名称
/// @param title 标题
/// @param duration 显示时长
/// @param isMark 是否加遮罩
/// @param yOffset 相对中心Y的偏移
- (void)showHubWithIconName:(NSString * _Nullable)iconName title:(NSString *)title duration:(NSTimeInterval)duration mark:(BOOL)isMark yOffset:(CGFloat)yOffset;

- (void)show;

/// 移除（带动画）
- (void)hide;

/// 移除（不带动画）
- (void)dismiss;

#pragma mark - 默认样式

/// 警告
+ (instancetype)caveatWithTitle:(NSString *)title duration:(NSTimeInterval)duration;
/// 显示警告（带icon）
+ (instancetype)showCaveatWithTitle:(NSString *)title duration:(NSTimeInterval)duration;

/// 警示
+ (instancetype)warningWithTitle:(NSString *)title duration:(NSTimeInterval)duration;
/// 显示警示（带icon）
+ (instancetype)showWarningWithTitle:(NSString *)title duration:(NSTimeInterval)duration;

/// 成功
+ (instancetype)successWithTitle:(NSString *)title duration:(NSTimeInterval)duration;
/// 显示成功（带icon）
+ (instancetype)showSuccessWithTitle:(NSString *)title duration:(NSTimeInterval)duration;

/// 显示默认样式及配置的消息通知HUD
/// @param iconName 头视图图片名称
/// @param title 标题
/// @param duration 显示时长
/// @param isMark 是否加遮罩
/// @param yOffset 相对中心Y的偏移
+ (void)defaultHubWithIconName:(NSString * _Nullable)iconName title:(NSString *)title duration:(NSTimeInterval)duration mark:(BOOL)isMark yOffset:(CGFloat)yOffset;

@end

@protocol ZJNotifyHUDDelegate <NSObject>
@optional

- (void)hudWasHidden:(ZJNotifyHUD *)hud;

@end

NS_ASSUME_NONNULL_END
