//
//  ZJBaseTabBar.h
//  ZJBaseUtils
//
//  Created by eafy on 2020/11/13.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZJBaseTarbarItem.h"

NS_ASSUME_NONNULL_BEGIN

typedef void (^ZJBTBCustomBtnBlock) (UIButton * _Nonnull btn, NSInteger index);

@protocol ZJBaseTabBarDelegate <NSObject>

// 将选中回调
/// @param fromIndex 之前选中的Index
/// @param toIndex 现在选中的Index
/// @return YES：执行，NO：不执行选中
- (BOOL)willTabBarSelectedFrom:(NSUInteger)fromIndex to:(NSUInteger)toIndex;

/// 选中回调
/// @param fromIndex 之前选中的Index
/// @param toIndex 现在选中的Index
- (void)didTabBarSelectedFrom:(NSUInteger)fromIndex to:(NSUInteger)toIndex;

@end

@interface ZJBaseTabBar : UITabBar

/// 选中代理
@property(nonatomic, weak) id _Nullable delegate;

/// 选中第几个
@property (nonatomic, assign) NSUInteger selectedIndex;

/// 全局参数配置
@property (nonatomic, strong) ZJBaseTabBarConfig *config;

/// 自定义背景视图
@property (nonatomic, strong) UIView *backgroundView;

/// 添加句柄
/// @param item 句柄参数
- (void)addItem:(ZJBaseTarbarItem * _Nullable)item;

/// 添加自定义按钮
/// @param btn 自定义按钮
/// @param index 插入第几个位置
/// @param btnClickBlock 点击回调
- (void)addCustomBtn:(UIButton *)btn atIndex:(NSInteger)index clickedBlock:(ZJBTBCustomBtnBlock)btnClickBlock;

/// 按钮集合
- (NSArray *)tabBarButtonArray;

@end

NS_ASSUME_NONNULL_END
