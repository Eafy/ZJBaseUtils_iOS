//
//  ZJBaseTabBarController.h
//  ZJBaseUtils
//
//  Created by eafy on 2020/11/13.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZJBaseTabBar.h"
#import "ZJBaseTBBadge.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZJBaseTabBarController : UITabBarController

#pragma mark - UIViewController·导航及通用设置

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

//自定义导航栏
@property (nonatomic,assign) BOOL isShowNavBarView;     //是否显示自定义导航栏视图，当isHideNavBar为YES时生效
@property (nonatomic,assign) BOOL isShowNavBarBgView;    //是否显示自定义导航栏背景视图；
@property (nonatomic,strong) UIImageView *navBarBgView;          //自定义导航栏背景视图
@property (nonatomic,strong) UILabel *navBarTitleLB;        //自定义导航栏的主题标签

/// 设置背景图片
@property (nonatomic,copy) NSString *backgroundImgName;
/// 背景颜色
@property (nonatomic,strong) UIColor *backgroundColor;

#pragma mark - UITabBarController·配置

/// 自定义Tabbar，仅提供修改参数
@property (nonatomic, strong) ZJBaseTabBar *customTabBar;

/// 全局参数配置（必须要在加载之前配置）
@property (nonatomic, strong) ZJBaseTabBarConfig *config;

/// 更新了config的内部参数，必须刷新
- (void)updateConfig;

#pragma mark - 

/// 添加单个句柄
/// @param item 视图句柄
- (void)addSubViewItem:(ZJBaseTarbarItem * _Nullable)item;

/// 添加句柄数组
/// @param array 视图句柄数组
- (void)addSubViewItems:(NSArray<ZJBaseTarbarItem *> * _Nullable)array;

#pragma mark -

/// 获取提示点对象
/// @param index 索引号
- (ZJBaseTBBadge *)badgeAtIndex:(NSInteger)index;

/// 隐藏标注
/// @param index 索引号
- (void)hideBadgeAtIndex:(NSInteger)index;

/// 显示点标注
/// @param index 索引号
- (void)showBadgePointAtIndex:(NSUInteger)index;

/// 显示New字符串标组
/// @param index  索引号
- (void)showBadgeNewAtIndex:(NSInteger)index;

/// 显示自定义字符串标组
/// @param badgeValue 标志值
/// @param index  索引号
- (void)showBadgeNumberValue:(NSString *)badgeValue atIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
