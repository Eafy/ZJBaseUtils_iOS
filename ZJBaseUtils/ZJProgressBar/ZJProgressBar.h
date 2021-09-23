//
//  ZJProgressBar.h
//  ZJBaseUtils
//
//  Created by eafy on 2021/1/29.
//  Copyright © 2021 ZJ. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, ZJProgressBarStyle) {
    ZJProgressBarRound,     //圆形
    ZJProgressBarHorizontal //水平
};

@interface ZJProgressBar : UIView

/// 样式
@property (nonatomic,assign) ZJProgressBarStyle style;
/// 是否是顺时针，默认YES
@property (nonatomic,assign) BOOL isClockwise;
/// 圆形进度条起始位置（弧度，相对顶点位置）
@property (nonatomic,assign) CGFloat startAngle;
/// 动画时长，默认0.1秒（0表示无动画）
@property (nonatomic,assign) CGFloat animationDuration;

/// 进度条颜色，默认0x3D7DFF
@property (nonatomic,strong) UIColor *color;
/// 进度条背景颜色，默认0xE8ECF1
@property (nonatomic,strong) UIColor *bgColor;
/// 进度值(0~1.0)
@property (nonatomic,assign) CGFloat progress;
/// 进度条宽度，默认6
@property (nonatomic,assign) CGFloat progressWidth;


/// 是否显示进度标签(默认隐藏)
@property (nonatomic,assign) BOOL isShowProgressLabel;
/// 是否自动更新标签，默认YES，仅当已显示才更新
@property (nonatomic,assign) BOOL isAutoUpdateLB;
/// 进度条标签文本（懒加载）
@property (nonatomic,strong) UILabel *progressLB;

@end

NS_ASSUME_NONNULL_END
