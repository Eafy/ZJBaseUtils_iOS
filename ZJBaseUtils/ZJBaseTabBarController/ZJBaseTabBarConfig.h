//
//  ZJBaseTabBarConfig.h
//  ZJBaseUtils
//
//  Created by eafy on 2020/11/14.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ZJBaseUtils/ZJBaseTabBarTopLineConfig.h>

NS_ASSUME_NONNULL_BEGIN

/// 布局类型
typedef NS_ENUM(NSInteger, ZJBTBConfigLayoutType) {
    ZJBTBConfigLayoutTypeNormal,    //默认布局 图片在上 文字在下
    ZJBTBConfigLayoutTypeImage,     //只有图片 (图片居中)
};

/// 点击动画类型
typedef NS_ENUM(NSInteger, ZJBTBConfigAnimType) {
    ZJBTBConfigAnimTypeNormal,          //无动画
    ZJBTBConfigAnimTypeCustom,          //自定义动画
    ZJBTBConfigAnimTypeRotationY,       //Y轴旋转
    ZJBTBConfigAnimTypeBoundsMin,       //缩小还原动画
    ZJBTBConfigAnimTypeBoundsMax,       //放大还原动画
    ZJBTBConfigAnimTypeEnlarge,         //放大动画
    ZJBTBConfigAnimTypeWaterRipple,     //水波纹效果
    ZJBTBConfigAnimTypeWaterRippleBoundsScale,//水波纹效果 + 放大缩小再还原动画
};

/// 凸起效果
typedef NS_ENUM(NSInteger, ZJBTBConfigSelectEffectType) {
    ZJBTBConfigSelectEffectTypeNormal,          //无效果
    ZJBTBConfigSelectEffectTypeRaised,          //凸起
};

@interface ZJBaseTabBarConfig : NSObject

/// 布局类型
@property (nonatomic, assign) ZJBTBConfigLayoutType layoutType;
/// 动画类型
@property (nonatomic, assign) ZJBTBConfigAnimType animType;
/// 凸起效果类型
@property (nonatomic, assign) ZJBTBConfigSelectEffectType effectType;

/// tabBar顶部线条样式配置
@property (nonatomic, strong) ZJBaseTabBarTopLineConfig *topLineConfig;

/// TabBar的背景颜色，默认白色
@property (nonatomic, strong) UIColor *backgroundColor;

/// 标题的默认颜色 ，默认：blackColor
@property (nonatomic, strong) UIColor *norTitleColor;
/// 标题的选中颜色 ，默认： grayColor
@property (nonatomic, strong) UIColor *selTitleColor;
/// 图片的size ，默认 ：(24*24)
@property (nonatomic, assign) CGSize imageSize;
/// 标题未选中文字大小 ，默认：12.f，常规
@property (nonatomic, strong) UIFont *nolTitleFont;
/// 标题选中文字大小 ，默认：12.f，粗体
@property (nonatomic, strong) UIFont *selTitleFont;
/// 标题的偏移值 (标题距离底部的距离 默认 2.f)
@property (nonatomic, assign) CGFloat titleOffset;
/// 图片的偏移值 (图片距离顶部的距离 默认 4.f)
@property (nonatomic, assign) CGFloat imageOffset;

#pragma mark - 动画参数

/// 自定义动画
@property (nonatomic, strong) CAAnimationGroup *customAnimation;
/// 自定义Layer层动画，默认会添加CAShapeLayer
@property (nonatomic, strong) CAAnimationGroup *customLayerAnimation;
/// 动画时长，默认0.3
@property (nonatomic, assign) CGFloat animTyDuration;
/// 图片缩放时的大小 ，默认 ：1.30
@property (nonatomic, assign) CGFloat imageScaleRatio;
/// 自定义Layer动画（水波纹动画可再次设置）
@property (nonatomic, strong) UIColor *animTyCustomLayerColor;
/// 自定义Layer大小，默认图片底部到顶部+10（水波纹动画可再次设置）
@property (nonatomic, assign) CGSize animTyCustomLayerSize;

/// ZJBTBConfigAnimTypeCenterRaised模式图片大小，默认 ：(40*40)
@property (nonatomic, assign) CGSize centerImageSize;
/// ZJBTBConfigAnimTypeCenterRaised模式图片偏移，默认 ：-20
@property (nonatomic, assign) CGFloat centerImageOffset;

@end

NS_ASSUME_NONNULL_END
