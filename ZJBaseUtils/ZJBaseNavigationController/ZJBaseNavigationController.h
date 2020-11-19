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

@property (nonatomic, assign) NSArray<Class> *hideNavBarArray;

/// 子控制器的背景颜色
@property (nonatomic, strong) UIColor *backgroundColor;

/// 返回按钮名称
@property (nonatomic, strong) NSString *navBackImgName;

/// 是否显示返回按钮标题，默认NO
@property (nonatomic, assign) BOOL isShowNavBackTitle;

#pragma mark - 内部使用接口

+ (void)handleJumpWithNavigationController:(UINavigationController *)navCtl viewController:(UIViewController *)viewCtl;

@end

NS_ASSUME_NONNULL_END
