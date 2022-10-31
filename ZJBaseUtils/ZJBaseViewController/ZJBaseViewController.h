//
//  ZJBaseViewController.h
//  ZJBaseUtils
//
//  Created by eafy on 2020/9/14.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZJBaseViewController : UIViewController

/// 页面是否可见，即在Top
@property (nonatomic,assign) BOOL isVisible;
/// 是否开启左侧边栏右滑返回，默认开启
@property (nonatomic,assign) BOOL isLeftSlideEnable;
/// 背景视图
@property (readonly) UIImageView *backgroundImgView;
/// 设置背景图片
@property (nonatomic,copy) NSString * _Nullable backgroundImgName;
/// 背景颜色
@property (nonatomic,strong) UIColor *backgroundColor;
/// 显示底部导航栏当Push的时候（系统默认显示时，且设置为YES才生效）
@property (nonatomic,assign) BOOL showBottomBarWhenPushed;

#pragma mark - 导航栏

/// 是否隐藏导航栏
@property (nonatomic,assign) BOOL isHideNavBar;
/// 导航栏背景颜色
@property (nonatomic,strong) UIColor *barTintColor;
/// 导航栏标题颜色，首次需要设置
@property (nonatomic,strong) UIColor *barTitleColor;
/// 导航栏标题字体，首次需要设置
@property (nonatomic,strong) UIFont *barTitleFont;

#pragma mark - 导航栏自定义

/// 是否显示自定义导航栏视图，当isHideNavBar为YES时生效
@property (nonatomic,assign) BOOL isShowNavBarView;
/// 是否显示自定义导航栏背景视图；
@property (nonatomic,assign) BOOL isShowNavBarBgView;
/// 自定义导航栏背景视图
@property (nonatomic,strong) UIImageView *navBarBgView;
/// 自定义导航栏的主题标签
@property (nonatomic,strong) UILabel *navBarTitleLB;

#pragma mark - 导航栏按键

/// 导航栏左键按钮
@property (nonatomic,strong) UIButton * _Nullable navLeftBtn;
/// 导航栏左键副按钮(靠中)
@property (nonatomic,strong) UIButton * _Nullable navLeftSubBtn;
/// 导航栏右键按钮
@property (nonatomic,strong) UIButton * _Nullable navRightBtn;
/// 导航栏右键副按钮(靠中)
@property (nonatomic,strong) UIButton * _Nullable navRightSubBtn;
/// 左辅助按钮是否显示上一级标题，默认NO；
@property (nonatomic,assign) BOOL isNavLeftSubTitle;
/// 页面退出返回给上层控制器的数据
@property (nonatomic,strong) id _Nullable returnBeforeData;
/// 导航栏右侧点击进入下一个控制器
@property (nonatomic,strong) UIViewController * _Nullable nextViewController;
/// 返回之前需要执行的Block
@property (nonatomic,copy) void (^ _Nullable returnBeforeOption)(id _Nullable data);
/// 返回之后需要执行的Block
@property (nonatomic,copy) void (^ _Nullable returnAfterOption)(void);
/// 右按按钮响应
- (void)navRightBtnAction;
/// 右辅助按钮响应
- (void)navRightSubBtnAction;
/// 左按钮响应
- (void)navLeftBtnAction;
/// 左辅助按钮响应
- (void)navLeftSubBtnAction;

#pragma mark - 强制横竖屏切换

/// 横竖屏切换
/// #需要在- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window接口返回指定方向
/// @param orientation 方向
- (void)interfaceOrientation:(UIInterfaceOrientation)orientation errorHandler:(nullable void (^)(NSError *error))errorHandler;

/// 屏幕方向（当设置之后才生效）
- (UIInterfaceOrientation)interfaceOrientation;

@end

NS_ASSUME_NONNULL_END
