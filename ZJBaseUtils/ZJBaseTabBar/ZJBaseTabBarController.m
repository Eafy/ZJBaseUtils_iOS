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

@interface ZJBaseTabBarController () <ZJBaseTabBarDelegate>

@end

@implementation ZJBaseTabBarController

- (ZJBaseTabBar *)customTabBar
{
    if (!_customTabBar) {
        _customTabBar = [[ZJBaseTabBar alloc] init];
        _customTabBar.delegate = self;
    }
    return _customTabBar;
}

- (ZJBaseTBConfig *)config
{
    return self.customTabBar.config;
}

- (void)setConfig:(ZJBaseTBConfig *)config
{
    self.customTabBar.config = config;
}

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

#pragma mark - ZJBaseTabBarDelegate

- (void)didTabBarSelectedFrom:(NSUInteger)fromIndex to:(NSUInteger)toIndex {
    self.selectedIndex = toIndex;
}


@end
