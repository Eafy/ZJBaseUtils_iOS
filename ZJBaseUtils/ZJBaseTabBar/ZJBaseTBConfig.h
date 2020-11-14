//
//  ZJBaseTBConfig.h
//  ZJBaseUtils
//
//  Created by eafy on 2020/11/14.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIColor+ZJExt.h"

@class ZJBaseTabBarController;

/// 布局类型
typedef NS_ENUM(NSInteger, ZJBTBConfigLayoutType) {
    ZJBTBConfigLayoutTypeNormal,    //默认布局 图片在上 文字在下
    ZJBTBConfigLayoutTypeImage,     //只有图片 (图片居中)
};

/// 点击动画类型
typedef NS_ENUM(NSInteger, ZJBTBConfigAnimType) {
    ZJBTBConfigAnimTypeNormal,          //无动画
    ZJBTBConfigAnimTypeRotationY,       //Y轴旋转
    ZJBTBConfigAnimTypeBoundsMin,       //缩小
    ZJBTBConfigAnimTypeBoundsMax,       //放大
    ZJBTBConfigAnimTypeScale,           //缩放动画
};

NS_ASSUME_NONNULL_BEGIN

@interface ZJBaseTBConfig : NSObject

/// 默认配置
+ (instancetype)defaultConfig;

#pragma mark - 基本配置

/// 点击动画类型
@property (nonatomic, assign) ZJBTBConfigAnimType tabBarAnimType;
/// 是否清除tabBar顶部线条颜色，默认YES
@property (nonatomic, assign) BOOL isClearTopLine;
/// TabBar顶部线条颜色，默认亮灰色
@property (nonatomic, strong) UIColor *topLineColor;
/// TabBar的背景颜色，默认白色
@property (nonatomic, strong) UIColor *backgroundColor;

/** tabBarController */
@property (nonatomic, strong) ZJBaseTabBarController *tabBarController;

/**
 对单个进行圆角设置
 @param radius 圆角值
 @param index 下标
 */
- (void)badgeRadius:(CGFloat)radius atIndex:(NSInteger)index;


/**
 显示圆点badgevalue  (以下关于badgeValue的操作可以在app全局操作)  使用方法 [[JMConfig config] showPointBadgeValue: AtIndex: ]
 @param index 显示的下标
 */
- (void)showPointBadgeAtIndex:(NSInteger)index;

/**
 显示newBadgeValue (以下关于badgeValue的操作可以在app全局操作)
 @param index 下标
 */
- (void)showNewBadgeAtIndex:(NSInteger)index;

/**
 显示带数值的下标  (注意: 此方法可以全局重复调用)
 @param badgeValue 数值
 @param index 下标
 */
- (void)showNumberBadgeValue:(NSString *)badgeValue AtIndex:(NSInteger)index;

/**
 隐藏下标的badgeValue

 @param index 下标
 */
- (void)hideBadgeAtIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
