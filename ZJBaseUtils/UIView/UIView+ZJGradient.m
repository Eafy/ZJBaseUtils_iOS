//
//  UIView+ZJGradient.m
//  ZJBaseUtils
//
//  Created by eafy on 2020/11/29.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import "UIView+ZJGradient.h"

@implementation UIView (ZJGradient)

/// 颜色渐变
/// @param colors 渐变颜色的数组
/// @param percents 渐变颜色的占比数组
/// @param opacity 透明度
/// @param type 渐变色的方向
- (void)zj_gradientWithColors:(NSArray<UIColor *> *_Nonnull)colors percents:(NSArray<NSNumber *> *_Nonnull)percents opacity:(CGFloat)opacity type:(ZJGradientType)type
{
    
    NSMutableArray *locations = [NSMutableArray array];
    NSMutableArray *colorArray = [NSMutableArray array];
    for (int i=0; i<colors.count; i++) {
        UIColor *color = [colors objectAtIndex:i];
        [colorArray addObject:(id)color.CGColor];
        if (i < percents.count) {
            [locations addObject:percents[i]];
        } else {
            locations[i] = [NSNumber numberWithFloat:1.0];
        }
    }
    
    CGPoint start;
    CGPoint end;
    switch (type) {
        case ZJGradientTypeFromTopToBottom:
            start = CGPointMake(self.bounds.size.width/2, 0.0);
            end = CGPointMake(self.bounds.size.width/2, self.bounds.size.height);
            break;
        case ZJGradientTypeFromLeftToRight:
            start = CGPointMake(0.0, self.bounds.size.height/2);
            end = CGPointMake(self.bounds.size.width, self.bounds.size.height/2);
            break;
        case ZJGradientTypeFromLeftTopToRightBottom:
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(self.bounds.size.width, self.bounds.size.height);
            break;
        case ZJGradientTypeFromLeftBottomToRightTop:
            start = CGPointMake(0.0, self.bounds.size.height);
            end = CGPointMake(self.bounds.size.width, 0.0);
            break;
        default:
            break;
    }
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = colorArray;
    gradientLayer.locations = percents;
    gradientLayer.startPoint = start;
    gradientLayer.endPoint = end;
    gradientLayer.frame = self.bounds;
    gradientLayer.opacity = opacity;
    
    [self.layer addSublayer:gradientLayer];
}

@end
