//
//  CAAnimation+ZJExt.m
//  ZJBaseUtils
//
//  Created by eafy on 2020/11/14.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import "CAAnimation+ZJExt.h"
#import <UIKit/UIKit.h>

#define Angle2Radian(angle) ((angle) / 180.0 * M_PI)

@implementation CAAnimation (ZJExt)

+ (CAKeyframeAnimation *)zj_shakeAnimationWithRepeatTimes:(CGFloat)repeatTimes
{
    CAKeyframeAnimation *animatioin = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation"];
    animatioin.values = @[@(Angle2Radian(-15)),@(Angle2Radian(-10)),@(Angle2Radian(-7)),
                     @(Angle2Radian(-5)),@(Angle2Radian(0)),@(Angle2Radian(5)),
                     @(Angle2Radian(-7)),@(Angle2Radian(10)),@(Angle2Radian(15))];
    animatioin.repeatCount = repeatTimes;
    return animatioin;
}

+ (CABasicAnimation *)zj_opacityAnimatioinWithDurationTimes:(CGFloat)duration
{
    CABasicAnimation *animatioin = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animatioin.fromValue = [NSNumber numberWithFloat:1.0f];
    animatioin.toValue = [NSNumber numberWithFloat:0.3f];
    animatioin.repeatCount = 3;
    animatioin.duration = duration;
    animatioin.autoreverses = YES;
    return animatioin;
}

+ (CABasicAnimation *)zj_scaleAnimation:(CGFloat)ratio
{
    CABasicAnimation *animatioin = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animatioin.toValue = [NSNumber numberWithFloat:ratio];
    animatioin.duration = 0.3f;
    animatioin.repeatCount = 3;
    animatioin.autoreverses = YES;
    return animatioin;
}

+ (CABasicAnimation *)zj_rotationYAnimation:(CGFloat)value
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
    animation.toValue = [NSNumber numberWithFloat:Angle2Radian(value)];
    return animation;
}

+ (CABasicAnimation *)zj_rotationZAnimation:(CGFloat)value
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.toValue = [NSNumber numberWithFloat:Angle2Radian(value)];
    return animation;
}

+ (CABasicAnimation *)zj_boundsAnimation:(CGPoint)point
{
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"bounds.size"];
    anim.toValue = [NSValue valueWithCGPoint:point];
    return anim;
}

@end
