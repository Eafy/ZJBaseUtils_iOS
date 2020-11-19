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

@interface ZJBaseNavigationController ()

@end

@implementation ZJBaseNavigationController

+ (void)handleJumpWithNavigationController:(UINavigationController *)navCtl viewController:(UIViewController *)viewCtl
{
    //判断是否是基础导航控制器
    if ([navCtl isKindOfClass:[ZJBaseNavigationController class]]) {
        ZJBaseNavigationController *nav = (ZJBaseNavigationController *)navCtl;    //目标控制器
        
        //判断是否是基础视图控制器、基础表单控制器
        if ([viewCtl isKindOfClass:[ZJBaseViewController class]] ||
            [viewCtl isKindOfClass:[ZJBaseTableViewController class]]) {
            ZJBaseViewController *vc = (ZJBaseViewController *)viewCtl;    //目标控制器
            
            if (nav.navBackImgName) {
                UIImage *img = [vc.navLeftBtn imageForState:UIControlStateNormal];
                if (!img) {
                    [vc.navLeftBtn setImage:[UIImage imageNamed:nav.navBackImgName] forState:UIControlStateNormal];
                }
            }
            
            if (nav.backgroundColor) vc.view.backgroundColor = nav.backgroundColor;
            if (nav.barTintColor) vc.barTintColor = nav.barTintColor;
            if (nav.barTitleColor) vc.barTitleColor = nav.barTitleColor;
            if (nav.barTitleFont) vc.barTitleFont = nav.barTitleFont;
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
    [super pushViewController:viewController animated:animated];
    if (self.hideNavBarArray && [self.hideNavBarArray containsObject:[self class]]) {
        if ([viewController respondsToSelector:@selector(isHideNavBar)]) {
            [self setNavigationBarHidden:((ZJBaseViewController *)viewController).isHideNavBar animated:YES];
        }
    }
}

@end
