//
//  ZJBaseTabBarController.m
//  ZJBaseUtils
//
//  Created by eafy on 2020/11/13.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import "ZJBaseTabBarController.h"
#import "ZJBaseTabBar.h"
#import "ZJBaseTabBarButton.h"
#import "ZJLocalizationTool.h"

@interface ZJBaseTabBarController () <ZJBaseTabBarDelegate>

@end

@implementation ZJBaseTabBarController
@synthesize config = _config;

- (ZJBaseTabBar *)customTabBar
{
    if (!_customTabBar) {
        _customTabBar = [[ZJBaseTabBar alloc] init];
        _customTabBar.delegate = self;
        _customTabBar.config = self.config;
    }
    return _customTabBar;
}

- (ZJBaseTabBarConfig *)config
{
    if (!_config) {
        _config = [[ZJBaseTabBarConfig alloc] init];
    }
    return _config;
}

- (void)setConfig:(ZJBaseTabBarConfig *)config
{
    _config = config;
    self.customTabBar.config = config;
}

- (void)updateConfig
{
    self.customTabBar.config = self.customTabBar.config;
}

#pragma mark -

- (void)addSubViewItem:(ZJBaseTarbarItem *)item
{
    if (item && item.viewController) {
        [self addChildViewController:item.viewController];
        [self.customTabBar addItem:item];
    }
}

- (void)addSubViewItems:(NSArray<ZJBaseTarbarItem *> *)array
{
    if (!array) return;
    for (ZJBaseTarbarItem *item in array) {
        [self addSubViewItem:item];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setValue:self.customTabBar forKey:@"tabBar"];
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex
{
    super.selectedIndex = selectedIndex;
    self.customTabBar.selectedIndex = selectedIndex;
}

#pragma mark -

- (void)showBadgePointAtIndex:(NSUInteger)index
{
    if (index < [self.customTabBar tabBarButtonArray].count) return;
    
    ZJBaseTabBarButton *btn = [[self.customTabBar tabBarButtonArray] objectAtIndex:index];
    btn.badge.hidden = NO;
    btn.badge.type = ZJBTBBadgeStyleTypePoint;
}

- (void)hideBadgeAtIndex:(NSInteger)index
{
    if (index < [self.customTabBar tabBarButtonArray].count) return;
    
    ZJBaseTabBarButton *btn = [[self.customTabBar tabBarButtonArray] objectAtIndex:index];
    btn.badge.hidden = YES;
}

- (void)showBadgeNewAtIndex:(NSInteger)index
{
    if (index < [self.customTabBar tabBarButtonArray].count) return;
    
    ZJBaseTabBarButton *btn = [[self.customTabBar tabBarButtonArray] objectAtIndex:index];
    btn.badge.hidden = NO;
    btn.badge.badgeLB.text = @"new".localized;
    btn.badge.type = ZJBTBBadgeStyleTypeNew;
}

- (void)showBadgeNumberValue:(NSString *)badgeValue atIndex:(NSInteger)index
{
    if (index < [self.customTabBar tabBarButtonArray].count) return;
    
    ZJBaseTabBarButton *btn = [[self.customTabBar tabBarButtonArray] objectAtIndex:index];
    btn.badge.hidden = NO;
    btn.badge.badgeLB.text = badgeValue;
    btn.badge.type = ZJBTBBadgeStyleTypeNumber;
}

#pragma mark - ZJBaseTabBarDelegate

- (void)didTabBarSelectedFrom:(NSUInteger)fromIndex to:(NSUInteger)toIndex {
    self.selectedIndex = toIndex;
}


@end
