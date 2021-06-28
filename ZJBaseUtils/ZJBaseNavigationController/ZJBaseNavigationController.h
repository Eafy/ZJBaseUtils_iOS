//
//  ZJBaseNavigationController.h
//  ZJBaseUtils
//
//  Created by eafy on 2020/9/16.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZJBaseNavigationController : UINavigationController

/// 哪些控制器列表隐藏导航栏
@property (nonatomic,assign) NSArray<Class> *hideNavBarArray;

/// 设置背景图片
@property (nonatomic,copy) NSString * _Nullable backgroundImgName;
/// 子控制器的背景颜色
@property (nonatomic,strong) UIColor *backgroundColor;

/// 返回按钮名称
@property (nonatomic,strong) NSString *navBackImgName;

/// 是否显示返回按钮标题，默认NO
@property (nonatomic,assign) BOOL isShowNavBackTitle;

//系统导航栏
@property (nonatomic,strong) UIColor *barTintColor;     //导航栏背景颜色
@property (nonatomic,strong) UIColor *barTitleColor;    //导航栏标题颜色，首次需要设置
@property (nonatomic,strong) UIFont *barTitleFont;  //导航栏标题字体，首次需要设置
/// 左辅助按钮是否显示上一级标题，默认nil；
@property (nonatomic,strong) NSNumber *isNavLeftSubTitle;

#pragma mark - 内部使用接口

+ (void)handleJumpWithNavigationController:(UINavigationController *)navCtl viewController:(UIViewController *)viewCtl;

@end

NS_ASSUME_NONNULL_END
