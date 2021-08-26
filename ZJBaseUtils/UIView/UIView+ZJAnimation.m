//
//  UIView+ZJAnimation.m
//  ZJBaseUtils
//
//  Created by eafy on 2020/12/22.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import <ZJBaseUtils/UIView+ZJAnimation.h>

NSString *const kZJView360RotateTransform = @"kZJView360RotateTransform";

@implementation UIView (ZJAnimation)

- (CABasicAnimation *)zj_addLoopRotateAnimation
{
    CABasicAnimation *animation = [self.layer animationForKey:kZJView360RotateTransform];
    if (!animation) {
        animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        animation.toValue = [NSNumber numberWithFloat:M_PI * 2.0];
        animation.duration = 1.0;
        animation.cumulative = YES;
        animation.repeatCount = ULLONG_MAX;
        
        [self.layer addAnimation:animation forKey:kZJView360RotateTransform];
    }
    
    return animation;
}

- (void)zj_removeLoopRotateAnimation
{
    [self.layer removeAnimationForKey:kZJView360RotateTransform];
}


@end
