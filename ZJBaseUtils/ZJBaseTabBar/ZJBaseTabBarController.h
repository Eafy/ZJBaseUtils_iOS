//
//  ZJBaseTabBarController.h
//  ZJBaseUtils
//
//  Created by eafy on 2020/11/13.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZJBaseTarbarItem.h"
#import "ZJBaseTabBar.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZJBaseTabBarController : UITabBarController

@property (nonatomic, strong) ZJBaseTabBar *customTabBar;

/// 配置
@property(nonatomic, strong) ZJBaseTBConfig * config;

- (void)addSubViewItem:(ZJBaseTarbarItem * _Nullable)item;

- (void)addSubViewItems:(NSArray<ZJBaseTarbarItem *> * _Nullable)array;


@end

NS_ASSUME_NONNULL_END
