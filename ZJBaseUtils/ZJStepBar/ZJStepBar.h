//
//  ZJStepBar.h
//  ZJBaseUtils
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

@interface ZJStepBar: UIView

/// 进度到第几个
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

/// 生成步骤条（默认水平）
/// @param titleArr 标题数组
+ (instancetype)stepBarWithTitleArray:(NSArray *)titleArr;

/// 初始化步骤条（默认水平）
/// @param titleArr 标题数组
- (instancetype)initWithTitleArray:(NSArray *)titleArr;

/// 初始化水平步骤条
/// @param frame frame
/// @param titleArray 标题数组
- (instancetype)initHorizontaWithFrame:(CGRect)frame titleArray:(NSArray *)titleArray;

/// 初始化垂直步骤条
/// @param frame frame
/// @param titleArray 标题数组
- (instancetype)initVerticalWithFrame:(CGRect)frame titleArray:(NSArray *)titleArray;

/// 设置标题数组（仅第一次有效）
/// @param titleArr 标题数组
- (void)setupTitleArray:(NSArray *)titleArr;

/// 选择进度到第几个（选择的同时会更新标题）
/// @param index 索引号
/// @param title 更新标题
- (void)selectIndex:(NSInteger)index withTitle:(NSString *)title;

/// 更新进度的标题（仅更新标题）
/// @param index 索引号
/// @param title 更新标题
- (void)updateIndex:(NSInteger)index title:(NSString *)title;
 
@end

NS_ASSUME_NONNULL_END
