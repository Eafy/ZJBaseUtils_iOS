//
//  ZJBaseViewController.h
//  ZJBaseUtils
//
//  Created by eafy on 2020/9/14.
//  Copyright © 2020 ZJ<lizhijian_21@163.com>. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^ZJBaseViewCtlReturnBeforeCompletion)(void);
typedef void (^ZJBaseViewCtlReturnAfterCompletion)(void);

@interface ZJBaseViewController : UIViewController

@property (nonatomic,assign) BOOL isLeftSidesliEnable;    //是否开启左侧边栏右滑返回，默认开启
@property (nonatomic,strong) UIViewController * _Nullable nextViewController;

@property (nonatomic,assign) BOOL isHideNavBar;     //是否隐藏导航栏
@property (nonatomic,strong) UIColor *barTintColor;     //导航栏背景颜色
@property (nonatomic,strong) UIColor *barTitleColor;    //导航栏标题颜色，首次需要设置
@property (nonatomic,strong) UIFont *barTitleFont;  //导航栏标题字体，首次需要设置

@property (nonatomic,strong) UIButton * _Nullable navRightBtn;
@property (nonatomic,strong) UIButton * _Nullable navLeftBtn;
@property (nonatomic,copy) ZJBaseViewCtlReturnBeforeCompletion _Nullable returnBeforeBlock;      //返回之前需要执行的Block
@property (nonatomic,copy) ZJBaseViewCtlReturnAfterCompletion _Nullable returnAfterBlock;        //返回之后需要执行的Block(模态有效)

@property (nonatomic,assign) BOOL isShowNavBarView;     //是否显示自定义导航栏视图，当isHideNavBar为YES时生效
@property (nonatomic,strong) UILabel *navBarTitleLB;

@end

NS_ASSUME_NONNULL_END
