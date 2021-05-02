//
//  ZJLabel.h
//  ZJUXKit
//
//  Created by eafy on 2020/7/25.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, ZJLabelStyle) {
    ZJLabelStyleNormal,         //普通样式
    ZJLabelStyleLine = 1 << 1,           //线条框样式
    ZJLabelStyleDottedLine = 1 << 2,     //虚线线条框
    ZJLabelStyleSelectable = 1 << 3,     //可选样式
    ZJLabelStyleCorner = 1 << 4,         //圆角样式
};

@interface ZJLabel : UILabel

+ (instancetype)labelWithStyle:(ZJLabelStyle)style;

/// 样式，默认普通
@property (nonatomic,assign) ZJLabelStyle style;
/// 普通背景颜色，同backgroundColor
@property (nonatomic,strong) UIColor *bgNorColcor;
/// 普通文字颜色，同textColor
@property (nonatomic,strong) UIColor *textNorColcor;

#pragma mark - ZJLabelStyleSelectable

/// 是否已选择，ZJLabelStyleSelect生效
@property (nonatomic,assign) BOOL selected;
/// 选中文字颜色，ZJLabelStyleSelect生效
@property (nonatomic,strong) UIColor *textSelColcor;
/// 选中背景颜色，ZJLabelStyleSelect生效
@property (nonatomic,strong) UIColor *bgSelColcor;
/// 标签选择的回调block
@property (nonatomic,copy) void (^ _Nullable labelSelectBlock)(BOOL isSelected);

/// 边框线条颜色
@property (nonatomic,strong) UIColor *lineColor;

#pragma mark - 渐变色

/// 渐变色开关
@property (nonatomic,assign) BOOL isGradientEnable;
/// 渐变颜色
@property (nonatomic,strong) NSArray<UIColor *> *gradientColors;
/// 渐变百分比
@property (nonatomic,strong) NSArray<NSNumber *> *gradientPercents;

@end

NS_ASSUME_NONNULL_END
