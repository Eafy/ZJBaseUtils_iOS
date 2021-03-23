//
//  ZJBaseTableViewController.h
//  ZJBaseUtils
//
//  Created by eafy on 2020/9/14.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZJSettingTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZJBaseTableViewController : UITableViewController

/// 页面是否可见，即在Top
@property (nonatomic,assign) BOOL isVisible;
/// 是否开启左侧边栏右滑返回，默认开启
@property (nonatomic,assign) BOOL isLeftSidesliEnable;
/// 导航栏右侧点击进入下一个控制器
@property (nonatomic,strong) UIViewController * _Nullable nextViewController;

/// 安全区域设置
@property (nonatomic,assign) UIScrollViewContentInsetAdjustmentBehavior insetAdjustmentBehavior API_AVAILABLE(ios(11.0),tvos(11.0));

/*系统导航栏*/
/// 是否隐藏导航栏
@property (nonatomic,assign) BOOL isHideNavBar;
/// 导航栏背景颜色
@property (nonatomic,strong) UIColor *barTintColor;
/// 导航栏标题颜色，首次需要设置
@property (nonatomic,strong) UIColor *barTitleColor;
/// 导航栏标题字体，首次需要设置
@property (nonatomic,strong) UIFont *barTitleFont;

/*导航栏按钮*/
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

/*自定义导航栏*/
/// 是否显示自定义导航栏视图，当isHideNavBar为YES时生效
@property (nonatomic,assign) BOOL isShowNavBarView;
/// 是否显示自定义导航栏背景视图；
@property (nonatomic,assign) BOOL isShowNavBarBgView;
/// 自定义导航栏背景视图
@property (nonatomic,strong) UIImageView *navBarBgView;
/// 自定义导航栏的主题标签
@property (nonatomic,strong) UILabel *navBarTitleLB;

/// 设置背景图片
@property (nonatomic,copy) NSString *backgroundImgName;
/// 背景颜色
@property (nonatomic,strong) UIColor *backgroundColor;
/// 显示底部导航栏当Push的时候（系统默认显示时，且设置为YES才生效）
@property (nonatomic,assign) BOOL showBottomBarWhenPushed;

#pragma mark -

/// 是否控制器首次加载
@property (readonly) BOOL isFirstDidLoad;

#pragma mark - 私有数据
@property (nonatomic,strong) ZJBaseTVPrivateData *privateData;  //Item或上一个界面透传过来的数据

#pragma mark - TableView

@property (nonatomic,strong,readonly) NSArray * _Nullable datasArray;

/// 加载数据，需要重载
- (NSArray<ZJSettingItemGroup *> *)setupDatas;

/// 加载数据(不刷新源数据)
- (void)reloadData;

/// 更新数据
- (void)updateData;

#pragma mark -

/// 获取Item
/// @param section 第几段
/// @param row 第几行
- (ZJSettingItem * _Nullable)itemWithSection:(NSUInteger)section row:(NSUInteger)row;

/// 获取Cell
/// @param section 第几段
/// @param row 第几行
- (UITableViewCell *)cellWithSection:(NSUInteger)section row:(NSUInteger)row;

@end

NS_ASSUME_NONNULL_END
