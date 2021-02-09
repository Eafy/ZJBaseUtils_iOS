//
//  ZJSlider.h
//  ZJBaseUtils
//
//  Created by eafy on 2020/7/27.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ZJSliderStyle) {
    ZJSliderStyleSinglePoint,       //单点
    ZJSliderStyleRange,             //区间
    ZJSliderStyleFixedPoint         //固定点
};

NS_ASSUME_NONNULL_BEGIN

@interface ZJSlider : UIControl

- (instancetype)initWithStyle:(ZJSliderStyle)style;

/// 样式
@property (nonatomic, assign) ZJSliderStyle style;

/// 最小值
@property (nonatomic, assign) CGFloat minValue;
/// 最大值
@property (nonatomic, assign) CGFloat maxValue;
/// 区间最小可选择值（单选滑块无效）
@property (nonatomic, assign) CGFloat minRange;

/// 已选最小值（单选为选择值）
@property (nonatomic, assign) CGFloat selectedMinValue;
/// 已选最大值（单选滑块无效）
@property (nonatomic, assign) CGFloat selectedMaxValue;

/// 线条高度，默认6
@property (nonatomic, assign) CGFloat lineHeight;
/// 是否是顶部滑动标签，默认NO
@property (nonatomic, assign) BOOL isShowTopSign;
/// 是否是双侧滑动标签，默认NO
@property (nonatomic, assign) BOOL isShowBothSideSign;
/// 标记文字是否显示整形
@property (nonatomic, assign) BOOL isShowShapingSign;
/// 固定点分段数(段数，非点个数)
@property (nonatomic, assign) NSInteger fixedPointCount;

/// 滑块颜色，默认白色
@property (nonatomic, strong) UIColor *thumbColor;
/// 底部杠杆颜色，默认：0xBCC4D4
@property (nonatomic, strong) UIColor *leverColor;
/// 底部杠杆无效颜色，默认：0xDCE0E8
@property (nonatomic, strong) UIColor *leverDisabledColor;
/// 进度颜色，默认：0x3D7DFF
@property (nonatomic, strong) UIColor *progressColor;
/// 进度无效颜色，默认：0xD6E4FF
@property (nonatomic, strong) UIColor *progressDisabledColor;
/// 进度显示框文字颜色，默认：0x5A6482
@property (nonatomic, strong) UIColor *textColor;
/// 字体，常规16
@property (nonatomic, strong) UIFont *textFont;

@end

NS_ASSUME_NONNULL_END
