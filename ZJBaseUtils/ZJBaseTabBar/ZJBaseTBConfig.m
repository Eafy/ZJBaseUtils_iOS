//
//  ZJBaseTBConfig.m
//  ZJBaseUtils
//
//  Created by eafy on 2020/11/14.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import "ZJBaseTBConfig.h"
#import "ZJBaseTabBarController.h"
#import "ZJBaseTabBarButton.h"
#import "UIColor+ZJExt.h"
#import "UIView+ZJFrame.h"
#import "ZJLocalizationTool.h"

@implementation ZJBaseTBConfig

+ (instancetype)defaultConfig
{
    ZJBaseTBConfig *config = [[ZJBaseTBConfig alloc] init];
    if (config) {
        config.isClearTopLine = YES;
        config.topLineColor = [UIColor lightGrayColor];
        config.backgroundColor = [UIColor whiteColor];
    }
    return config;
}

#pragma mark - 

- (void)setBadgeTextColor:(UIColor *)badgeTextColor {
    _badgeTextColor = badgeTextColor;
    NSMutableArray *arrM = [self getTabBarButtons];
    for (ZJBaseTabBarButton *btn in arrM) {
        btn.badge.badgeLB.textColor = badgeTextColor;
    }
}

- (void)setBadgeBackgroundColor:(UIColor *)badgeBackgroundColor {
    _badgeBackgroundColor = badgeBackgroundColor;
    NSMutableArray *arrM = [self getTabBarButtons];
    for (ZJBaseTabBarButton *btn in arrM) {
        btn.badge.badgeLB.backgroundColor = badgeBackgroundColor;
    }
}

- (void)setBadgeSize:(CGSize)badgeSize {
    _badgeSize = badgeSize;
    NSMutableArray *arrM = [self getTabBarButtons];
    for (ZJBaseTabBarButton *btn in arrM) {
        btn.badge.badgeLB.zj_size = badgeSize;
    }
}

- (void)setBadgeOffset:(CGPoint)badgeOffset {
    _badgeOffset = badgeOffset;
    NSMutableArray *arrM = [self getTabBarButtons];
    for (ZJBaseTabBarButton *btn in arrM) {
        btn.badge.badgeLB.zj_left += badgeOffset.x;
        btn.badge.badgeLB.zj_top += badgeOffset.y;
    }
}

- (void)setBadgeRadius:(CGFloat)badgeRadius {
    _badgeRadius = badgeRadius;
    NSMutableArray *arrM = [self getTabBarButtons];
    for (ZJBaseTabBarButton *btn in arrM) {
        btn.badge.badgeLB.layer.cornerRadius = badgeRadius;
    }
}

- (void)badgeRadius:(CGFloat)radius atIndex:(NSInteger)index {
    ZJBaseTabBarButton *tabBarButton = [self getTabBarButtonAtIndex:index];
    tabBarButton.badge.badgeLB.layer.cornerRadius = radius;
}


- (void)showPointBadgeAtIndex:(NSInteger)index{
    ZJBaseTabBarButton *tabBarButton = [self getTabBarButtonAtIndex:index];
    tabBarButton.badge.hidden = NO;
    tabBarButton.badge.type = ZJBTBBadgeValueTypePoint;
}

- (void)showNewBadgeAtIndex:(NSInteger)index {
    ZJBaseTabBarButton *tabBarButton = [self getTabBarButtonAtIndex:index];
    tabBarButton.badge.hidden = NO;
    tabBarButton.badge.badgeLB.text = @"new".localized;
    tabBarButton.badge.type = ZJBTBBadgeValueTypeNew;
}

- (void)showNumberBadgeValue:(NSString *)badgeValue AtIndex:(NSInteger)index {
    ZJBaseTabBarButton *tabBarButton = [self getTabBarButtonAtIndex:index];
    tabBarButton.badge.hidden = NO;
    tabBarButton.badge.badgeLB.text = badgeValue;
    tabBarButton.badge.type = ZJBTBBadgeValueTypeNumber;
}

- (void)hideBadgeAtIndex:(NSInteger)index {
    [self getTabBarButtonAtIndex:index].badge.hidden = YES;
}

- (ZJBaseTabBarButton *)getTabBarButtonAtIndex:(NSInteger)index {
    NSArray *subViews = self.tabBarController.JM_TabBar.subviews;
    for (int i = 0; i < subViews.count; i++) {
        UIView *tabBarButton = subViews[i];
        if ([tabBarButton isKindOfClass:[ZJBaseTabBarButton class]] && i == index) {
            ZJBaseTabBarButton *tabBarBtn = (ZJBaseTabBarButton *)tabBarButton;
            return tabBarBtn;
        }
    }
    return nil;
}

- (NSMutableArray *)getTabBarButtons {
    NSArray *subViews = self.tabBarController.JM_TabBar.subviews;
    NSMutableArray *tempArr = [NSMutableArray array];
    for (int i = 0; i < subViews.count; i++) {
        UIView *tabBarButton = subViews[i];
        if ([tabBarButton isKindOfClass:[ZJBaseTabBarButton class]]) {
            ZJBaseTabBarButton *tabBarBtn = (ZJBaseTabBarButton *)tabBarButton;
            [tempArr addObject:tabBarBtn];
        }
    }
    return tempArr;
}

#pragma mark -



@end
