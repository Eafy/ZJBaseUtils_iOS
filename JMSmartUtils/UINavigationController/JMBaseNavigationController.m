//
//  JMBaseNavigationController.m
//  JMSmartUtils
//
//  Created by 李治健 on 2020/9/16.
//  Copyright © 2020 Jimi. All rights reserved.
//

#import "JMBaseNavigationController.h"
#import "JMBaseViewController.h"

@interface JMBaseNavigationController ()

@end

@implementation JMBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.modalPresentationStyle = UIModalPresentationFullScreen;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [super pushViewController:viewController animated:animated];
    if (self.hideNavBarArray && [self.hideNavBarArray containsObject:[self class]]) {
        if ([viewController respondsToSelector:@selector(getIsHideNavBar)]) {
            [self setNavigationBarHidden:((JMBaseViewController *)viewController).isHideNavBar animated:YES];
        }
    }
}

@end
