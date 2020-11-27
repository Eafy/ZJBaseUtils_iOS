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

@property (nonatomic,assign) BOOL isLeftSidesliEnable;    //是否开启左侧边栏右滑返回，默认开启
@property (nonatomic,strong) UIViewController * _Nullable nextViewController;

@property (nonatomic,assign) BOOL isHideNavBar;     //是否隐藏导航栏
@property (nonatomic,strong) UIColor *barTintColor;     //导航栏背景颜色
@property (nonatomic,strong) UIColor *barTitleColor;    //导航栏标题颜色，首次需要设置
@property (nonatomic,strong) UIFont *barTitleFont;  //导航栏标题字体，首次需要设置

@property (nonatomic,strong) UIButton * _Nullable navRightBtn;
@property (nonatomic,strong) UIButton * _Nullable navLeftBtn;
/// 返回之前需要执行的Block
@property (nonatomic,copy) void (^ _Nullable returnBeforeOption)(void);
/// 返回之后需要执行的Block(模态有效)
@property (nonatomic,copy) void (^ _Nullable returnAfterOption)(void);

//自定义导航栏
@property (nonatomic,assign) BOOL isShowNavBarView;     //是否显示自定义导航栏视图，当isHideNavBar为YES时生效
@property (nonatomic,assign) BOOL isShowNavBarBgView;    //是否显示自定义导航栏背景视图；
@property (nonatomic,strong) UIView *navBarBgView;          //自定义导航栏背景视图
@property (nonatomic,strong) UILabel *navBarTitleLB;        //自定义导航栏的主题标签

/// 设置背景图片
@property (nonatomic,copy) NSString *backgroundImgName;
/// 背景颜色
@property (nonatomic,strong) UIColor *backgroundColor;

/// 右键响应
- (void)navRightBtnAction;

/// 左键响应
- (void)navLeftBtnAction;

@end

NS_ASSUME_NONNULL_END
