//
//  ZJBaseNavigationController.m
//  ZJBaseUtils
//
//  Created by eafy on 2020/9/16.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import "ZJBaseNavigationController.h"
#import "ZJBaseViewController.h"
#import "ZJBaseTableViewController.h"
#import "ZJBaseTabBarController.h"

@interface ZJBaseNavigationController ()

@end

@implementation ZJBaseNavigationController

+ (void)handleJumpWithNavigationController:(UINavigationController *)navCtl viewController:(UIViewController *)viewCtl
{
    // 判断是否是基础导航控制器
    if ([navCtl isKindOfClass:[ZJBaseNavigationController class]]) {
        ZJBaseNavigationController *nav = (ZJBaseNavigationController *)navCtl;
        
        // 判断是否是基础视图控制器、基础表单控制器
        if ([viewCtl isKindOfClass:[ZJBaseViewController class]] ||
            [viewCtl isKindOfClass:[ZJBaseTableViewController class]] ||
            [viewCtl isKindOfClass:[ZJBaseTabBarController class]]) {
            ZJBaseViewController *vc = (ZJBaseViewController *)viewCtl;    //目标控制器
            
            if (!vc.hidesBottomBarWhenPushed && !vc.showBottomBarWhenPushed && navCtl.topViewController && navCtl.viewControllers.count == 1) {
                vc.hidesBottomBarWhenPushed = YES;
            }
            
            if (nav.navBackImgName) {
                UIImage *img = [vc.navLeftBtn imageForState:UIControlStateNormal];
                if (!img) {
                    [vc.navLeftBtn setImage:[UIImage imageNamed:nav.navBackImgName] forState:UIControlStateNormal];
                }
            }
            
            if (nav.backgroundImgName) vc.backgroundImgName = nav.backgroundImgName;
            if (nav.backgroundColor) vc.backgroundColor = nav.backgroundColor;
            if (nav.barTintColor) vc.barTintColor = nav.barTintColor;
            if (nav.barTitleColor) vc.barTitleColor = nav.barTitleColor;
            if (nav.barTitleFont) vc.barTitleFont = nav.barTitleFont;
            if (nav.isNavLeftSubTitle) vc.isNavLeftSubTitle = [nav.isNavLeftSubTitle boolValue];
        }
    }
}

#pragma mark -

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.modalPresentationStyle = UIModalPresentationFullScreen;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [ZJBaseNavigationController handleJumpWithNavigationController:self viewController:viewController];
    
    [super pushViewController:viewController animated:animated];
    if (self.hideNavBarArray && [self.hideNavBarArray containsObject:[self class]]) {
        if ([viewController respondsToSelector:@selector(isHideNavBar)]) {
            [self setNavigationBarHidden:((ZJBaseViewController *)viewController).isHideNavBar animated:YES];
        }
    }
}

- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    _backgroundColor = backgroundColor;
    if (self.viewControllers.count == 1) {
        ZJBaseViewController *viewCtl = self.viewControllers[0];
        if ([viewCtl isKindOfClass:[ZJBaseViewController class]] ||
        [viewCtl isKindOfClass:[ZJBaseTableViewController class]]) {
            viewCtl.backgroundColor = backgroundColor;
        }
    }
}

- (void)setBackgroundImgName:(NSString *)backgroundImgName
{
    _backgroundImgName = backgroundImgName;
    if (self.viewControllers.count == 1) {
        ZJBaseViewController *viewCtl = self.viewControllers[0];
        if ([viewCtl isKindOfClass:[ZJBaseViewController class]] ||
        [viewCtl isKindOfClass:[ZJBaseTableViewController class]]) {
            viewCtl.backgroundImgName = backgroundImgName;
        }
    } else if (_backgroundImgView && (!backgroundImgName || backgroundImgName.length == 0)) {
        [_backgroundImgView removeFromSuperview];
        _backgroundImgView = nil
    }
}

@end
