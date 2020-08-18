//
//  UIViewController+ZJExt.m
//  ZJBaseUtils
//
//  Created by eafy on 2020/8/18.
//  Copyright © 2020 ZJ<lizhijian_21@163.com>. All rights reserved.
//

#import "UIViewController+ZJExt.h"

@implementation UIViewController (ZJExt)

+ (UIViewController *)zj_currentViewController:(UIViewController *)rootVC
{
    if ([rootVC isKindOfClass:[UINavigationController class]]) {
        return [self zj_currentViewController:((UINavigationController *)rootVC).visibleViewController];
    } else if ([rootVC isKindOfClass:[UITabBarController class]]) {
        return [self zj_currentViewController:((UITabBarController *)rootVC).selectedViewController];
    } else if (rootVC.presentedViewController) {
        return [self zj_currentViewController:rootVC.presentedViewController];
    }

    return rootVC;
}

+ (UIViewController *)zj_currentViewController
{
    return [self zj_currentViewController:[UIApplication sharedApplication].windows.firstObject.rootViewController];
}

+ (UIViewController *)zj_findPresentedViewController:(UIViewController *)destVc
{
    BOOL isFind = NO;
    NSInteger searchCount = 0;
    UIViewController *presentedVC = nil;
    UIViewController *rootVC = [UIApplication sharedApplication].delegate.window.rootViewController;
    do {
        searchCount ++;
        if ([rootVC isKindOfClass:[UINavigationController class]]) {
            UINavigationController *nav = (UINavigationController *)rootVC;
            for (UIViewController *vc in nav.viewControllers) {
                if (vc == destVc) {
                    isFind = YES;
                    break;
                }
                presentedVC = vc;
            }
            
            if (!isFind) {
                UIViewController *vc = [nav.viewControllers lastObject];
                rootVC = vc.presentedViewController;
                presentedVC = vc;
            }
        } else if ([rootVC isKindOfClass:[UITabBarController class]]) {
            UITabBarController *tabVC = (UITabBarController *)rootVC;
            rootVC = [tabVC.viewControllers objectAtIndex:tabVC.selectedIndex];
            if (rootVC == destVc) {
                isFind = YES;
                break;
            }
            presentedVC = tabVC;
        }
    } while (!isFind && rootVC != nil && searchCount < 128);
    
    return isFind?presentedVC:nil;
}

+ (void)exitViewController:(Class _Nonnull)destVc
{
    NSInteger searchCount = 0;
    UIViewController *vc = [UIViewController zj_currentViewController];

    do {
        if (!vc || [vc isKindOfClass:destVc]) {
            break;
        } else {
            searchCount ++;
            UIViewController *vcTemp = nil;
            if ([vc isKindOfClass:[UINavigationController class]]) {
                vcTemp = [self zj_findPresentedViewController:vc];
                [vc dismissViewControllerAnimated:NO completion:nil];
            } else if ([vc isKindOfClass:[UIViewController class]]) {
                vcTemp = [[vc.navigationController viewControllers] objectAtIndex:0];
                if (vcTemp == vc) {
                    vcTemp = [self zj_findPresentedViewController:vc];
                    [vc dismissViewControllerAnimated:NO completion:nil];
                } else {
                    [vc.navigationController popToRootViewControllerAnimated:NO];
                }
                
                vc = vcTemp;
            }
        }
    } while (vc && searchCount < 128);
}

+ (void)exitViewController:(UIViewController * _Nullable)currentVc toVC:(Class _Nonnull)toVc
{
    NSInteger searchCount = 0;
    UIViewController *vc = currentVc;
    
    do {
        if (!vc || [vc isKindOfClass:toVc]) {
            break;
        } else {
            searchCount ++;
            UIViewController *vcTemp = nil;
            if ([vc isKindOfClass:[UINavigationController class]]) {
                vcTemp = [self zj_findPresentedViewController:vc];
                [vc dismissViewControllerAnimated:NO completion:nil];
            } else if ([vc isKindOfClass:[UIViewController class]]) {
                vcTemp = [[vc.navigationController viewControllers] objectAtIndex:0];
                if (vcTemp == vc) {
                    vcTemp = [self zj_findPresentedViewController:vc];
                    [vc dismissViewControllerAnimated:NO completion:nil];
                } else {
                    [vc.navigationController popToRootViewControllerAnimated:NO];
                }
                
                vc = vcTemp;
            }
        }
    } while (vc && searchCount < 128);
}

@end
