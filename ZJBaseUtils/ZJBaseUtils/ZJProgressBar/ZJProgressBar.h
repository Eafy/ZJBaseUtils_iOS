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
    ZJProgressBarRound,     //原型
    ZJProgressBarHorizontal //水平
};

@interface ZJProgressBar : UIView

/// 样式
@property (nonatomic,assign) ZJProgressBarStyle style;

/// 进度条颜色
@property (nonatomic,strong) UIColor *color;
/// 进度条背景颜色
@property (nonatomic,strong) UIColor *bgColor;
/// 进度值(0~1.0)
@property (nonatomic,assign) CGFloat progress;
/// 进度条宽度
@property (nonatomic,assign) CGFloat width;
/// 是否显示进度标签(默认隐藏)
@property (nonatomic,assign) BOOL isShowProgressLabel;
@property (nonatomic,strong) UILabel *progressLB;

@end

NS_ASSUME_NONNULL_END
