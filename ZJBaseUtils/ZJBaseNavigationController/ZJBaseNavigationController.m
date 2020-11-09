//
//  ZJBaseNavigationController.m
//  ZJBaseUtils
//
//  Created by eafy on 2020/9/16.
//  Copyright © 2020 ZJ<lizhijian_21@163.com>. All rights reserved.
//

#import "ZJBaseNavigationController.h"
#import "ZJBaseViewController.h"

@interface ZJBaseNavigationController ()

@end

@implementation ZJBaseNavigationController

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
