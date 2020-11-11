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

/// 是否开启左侧边栏右滑返回，默认开启
@property (nonatomic,assign) BOOL isLeftSidesliEnable;
/// 下一个控制器
@property (nonatomic,strong) UIViewController * _Nullable nextViewController;

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
/// 右侧按钮
@property (nonatomic,strong) UIButton * _Nullable navRightBtn;
/// 坐厕按钮
@property (nonatomic,strong) UIButton * _Nullable navLeftBtn;
/// 返回之前需要执行的Block
@property (nonatomic,copy) void(^ _Nullable returnBeforeBlock)(void);
/// 返回之后需要执行的Block(模态有效)
@property (nonatomic,copy) void(^ _Nullable returnAfterBlock)(void);

/*自定义导航栏*/
/// 是否显示自定义导航栏视图，当isHideNavBar为YES时生效
@property (nonatomic,assign) BOOL isShowNavBarView;
/// 是否显示自定义导航栏背景视图；
@property (nonatomic,assign) BOOL isShowNavBarBgView;
/// 自定义导航栏背景视图
@property (nonatomic,strong) UIView *navBarBgView;
/// 自定义导航栏的主题标签
@property (nonatomic,strong) UILabel *navBarTitleLB;

#pragma mark - 私有数据
@property (nonatomic,strong) ZJBaseTVPrivateData *privateData;  //Item或上一个界面透传过来的数据

#pragma mark - TableView

/// 加载数据，需要重载
- (NSArray<ZJSettingItemGroup *> *)setupDatas;

/// 刷新数据
- (void)reloadData;

/// 右键响应
- (void)navRightBtnAction;

/// 左键响应
- (void)navLeftBtnAction;

@end

NS_ASSUME_NONNULL_END
