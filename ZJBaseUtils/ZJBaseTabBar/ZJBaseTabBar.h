//
//  ZJBaseTabBar.h
//  ZJBaseUtils
//
//  Created by eafy on 2020/11/13.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZJBaseTarbarItem.h"
#import "ZJBaseTBConfig.h"

NS_ASSUME_NONNULL_BEGIN

typedef void (^ZJBTBCustomBtnBlock) (UIButton * _Nonnull btn, NSInteger index);

@protocol ZJBaseTabBarDelegate <NSObject>

/// 选中回调
/// @param fromIndex 之前选中的Index
/// @param toIndex 现在选中的Index
- (void)didTabBarSelectedFrom:(NSUInteger)fromIndex to:(NSUInteger)toIndex;

@end

@interface ZJBaseTabBar : UITabBar

/// 选中代理
@property(nonatomic, weak) id _Nullable delegate;

/// 配置
@property(nonatomic, strong) ZJBaseTBConfig *config;

/// 选中第几个
@property (nonatomic, assign) NSUInteger selectedIndex;

/// 添加句柄
/// @param item 句柄参数
- (void)addItem:(ZJBaseTarbarItem * _Nullable)item;

/// 添加自定义按钮
/// @param btn 自定义按钮
/// @param index 插入第几个位置
/// @param btnClickBlock 点击回调
- (void)addCustomBtn:(UIButton *)btn atIndex:(NSInteger)index clickedBlock:(ZJBTBCustomBtnBlock)btnClickBlock;

@end

NS_ASSUME_NONNULL_END
