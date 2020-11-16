//
//  ZJBaseTabBarController.h
//  ZJBaseUtils
//
//  Created by eafy on 2020/11/13.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZJBaseTabBar.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZJBaseTabBarController : UITabBarController

/// 自定义Tabbar，仅提供修改参数
@property (nonatomic, strong) ZJBaseTabBar *customTabBar;

/// 全局参数配置（必须要在加载之前配置）
@property (nonatomic, strong) ZJBaseTabBarConfig *config;

/// 更新了config的内部参数，必须刷新
- (void)updateConfig;

#pragma mark - 

/// 添加单个句柄
/// @param item 视图句柄
- (void)addSubViewItem:(ZJBaseTarbarItem * _Nullable)item;

/// 添加句柄数组
/// @param array 视图句柄数组
- (void)addSubViewItems:(NSArray<ZJBaseTarbarItem *> * _Nullable)array;

/// 隐藏标注
/// @param index 索引号
- (void)hideBadgeAtIndex:(NSInteger)index;

/// 显示点标注
/// @param index 索引号
- (void)showBadgePointAtIndex:(NSUInteger)index;

/// 显示New字符串标组
/// @param index  索引号
- (void)showBadgeNewAtIndex:(NSInteger)index;

/// 显示自定义字符串标组
/// @param badgeValue 标志值
/// @param index  索引号
- (void)showBadgeNumberValue:(NSString *)badgeValue atIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
