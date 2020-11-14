//
//  CAAnimation+ZJExt.h
//  ZJBaseUtils
//
//  Created by eafy on 2020/11/14.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

NS_ASSUME_NONNULL_BEGIN

@interface CAAnimation (ZJExt)

/// 抖动动画
/// @param repeatTimes 重复次数
+ (CAKeyframeAnimation *)zj_shakeAnimationWithRepeatTimes:(CGFloat)repeatTimes;

/// 透明过渡动画
/// @param duration  持续时间
+ (CABasicAnimation *)zj_opacityAnimatioinWithDurationTimes:(CGFloat)duration;

/// 缩放动画
+ (CABasicAnimation *)zj_scaleAnimation;

/// 旋转Y轴
/// @param value 旋转角度
+ (CABasicAnimation *)zj_rotationYAnimation:(CGFloat)value;

/// 旋转bounds
/// @param point 方向值
+ (CABasicAnimation *)zj_boundsAnimation:(CGPoint)point;

@end

NS_ASSUME_NONNULL_END
