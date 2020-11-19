//
//  ZJBaseViewController+P.m
//  ZJBaseUtils
//
//  Created by eafy on 2020/11/19.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import "ZJBaseViewController+Present.h"
#import "ZJBaseNavigationController.h"

@implementation ZJBaseViewController (Present)

- (void)presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion
{
    if ([viewControllerToPresent isKindOfClass:[UINavigationController class]]) {
        UINavigationController *nav = (UINavigationController *)viewControllerToPresent;
        [ZJBaseNavigationController handleJumpWithNavigationController:nav viewController:nav.topViewController];
    }
    
    [super presentViewController:viewControllerToPresent animated:flag completion:completion];
}

@end
