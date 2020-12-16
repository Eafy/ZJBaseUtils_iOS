//
//  ZJStepsView.h
//  ZJUXKit
//
//  Created by eafy on 2020/8/3.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, ZJStepBarStyle) {
    ZJStepBarStylePoint = 0,      //已选择进度为点
    ZJStepBarStyleImage,          //已选择进度为图形，图像会变成中原
};

@interface ZJStepsView: UIView


- (instancetype)initWithTitleArray:(NSArray *)titleArr;

- (instancetype)initHorizontaWithFrame:(CGRect)frame titleArray:(NSArray *)titleArray;

- (instancetype)initVerticalWithFrame:(CGRect)frame titleArray:(NSArray *)titleArray;

@property (nonatomic,assign) NSInteger index;

/// 最小原宽度，默认8，即大圆16，选中圆环32，3倍缩放
@property (nonatomic,assign) CGFloat circleWidth;
/// 已选择原型的类型
@property (nonatomic,assign) ZJStepBarStyle style;
/// 已选择的进度原中显示的图片，当style==ZJStepBarStyleImage生效
@property (nonatomic,copy) NSString *selectImgName;

/// 小圆颜色，默认：0x8690A8
@property (nonatomic,strong) UIColor *circleNorColor;
/// 大圆颜色，默认：0x3D7DFF
@property (nonatomic,strong) UIColor *circleSelColor;
/// 大圆已选择动画（圆环）颜色，默认：0x3D7DFF，0.1
@property (nonatomic,strong) UIColor *circleAnimColor;

/// 进度条高度，默认2
@property (nonatomic,assign) CGFloat progressLineHeight;
/// 进度条默认颜色，默认：0xBCC4D4
@property (nonatomic,strong) UIColor *progressNorColor;
/// 进度条进度颜色，默认：0x3D7DFF
@property (nonatomic,strong) UIColor *progressSelColor;

/// 标题普通颜色，默认：0xBCC4D4
@property (nonatomic,strong) UIColor *titleNorColor;
/// 标题已选择颜色，默认：0x8690A8
@property (nonatomic,strong) UIColor *titleSelColor;
/// 标题字体，常规14
@property (nonatomic,strong) UIFont *titleFont;
/// 文字与进度条之间的间距，默认30
@property (nonatomic,assign) CGFloat titleTopSpace;
 
@end

NS_ASSUME_NONNULL_END
