//
//  ZJBaseTabBar.h
//  ZJBaseUtils
//
//  Created by eafy on 2020/11/13.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ZJBaseUtils/ZJBaseTarbarItem.h>

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

/// 更新句柄信息
/// @param item 句柄数据
/// @param index 索引号
- (void)updateItem:(ZJBaseTarbarItem * _Nullable)item atIndex:(NSUInteger)index;

/// 更新普通(未选中)的标题和图片信息
/// @param index 索引号
/// @param title 标题，nil表示不设置
/// @param imgName 图片名称，nil表示不设置
- (void)updateNormalAtIndex:(NSUInteger)index title:(NSString *)title imgName:(NSString *)imgName;

/// 更新选中的标题和图片信息
/// @param index 索引号
/// @param title 标题，nil表示不设置
/// @param imgName 图片名称，nil表示不设置
- (void)updateSelectedAtIndex:(NSUInteger)index title:(NSString *)title imgName:(NSString *)imgName;

/// 添加自定义按钮
/// @param btn 自定义按钮
/// @param btnClickBlock 点击回调
- (void)addCustomBtn:(UIButton *)btn clickedBlock:(ZJBTBCustomBtnBlock)btnClickBlock;

/// 按钮集合
- (NSArray *)tabBarButtonArray;

@end

NS_ASSUME_NONNULL_END
