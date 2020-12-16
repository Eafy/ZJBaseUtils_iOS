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
@property (nonatomic,assign) BOOL isLeftSidesliEnable;
/// 导航栏右侧点击进入下一个控制器
@property (nonatomic,strong) UIViewController * _Nullable nextViewController;

@property (nonatomic,assign) BOOL isHideNavBar;     //是否隐藏导航栏
@property (nonatomic,strong) UIColor *barTintColor;     //导航栏背景颜色
@property (nonatomic,strong) UIColor *barTitleColor;    //导航栏标题颜色，首次需要设置
@property (nonatomic,strong) UIFont *barTitleFont;  //导航栏标题字体，首次需要设置

/// 导航栏右键按钮
@property (nonatomic,strong) UIButton * _Nullable navRightBtn;
/// 导航栏左键按钮
@property (nonatomic,strong) UIButton * _Nullable navLeftBtn;
/// 页面退出返回给上层控制器的数据
@property (nonatomic,strong) id _Nullable returnBeforeData;
/// 返回之前需要执行的Block
@property (nonatomic,copy) void (^ _Nullable returnBeforeOption)(id _Nullable data);
/// 返回之后需要执行的Block
@property (nonatomic,copy) void (^ _Nullable returnAfterOption)(void);
/// 右键响应
- (void)navRightBtnAction;
/// 左键响应
- (void)navLeftBtnAction;

//自定义导航栏
@property (nonatomic,assign) BOOL isShowNavBarView;     //是否显示自定义导航栏视图，当isHideNavBar为YES时生效
@property (nonatomic,assign) BOOL isShowNavBarBgView;    //是否显示自定义导航栏背景视图；
@property (nonatomic,strong) UIImageView *navBarBgView;          //自定义导航栏背景视图
@property (nonatomic,strong) UILabel *navBarTitleLB;        //自定义导航栏的主题标签

/// 设置背景图片
@property (nonatomic,copy) NSString *backgroundImgName;
/// 背景颜色
@property (nonatomic,strong) UIColor *backgroundColor;

@end

NS_ASSUME_NONNULL_END
