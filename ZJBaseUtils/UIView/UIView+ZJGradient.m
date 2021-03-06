//
//  UIView+ZJGradient.m
//  ZJBaseUtils
//
//  Created by eafy on 2020/11/29.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import "UIView+ZJGradient.h"

@implementation UIView (ZJGradient)

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
            start = CGPointMake(0.5, 0.0);
            end = CGPointMake(0.5, 1);
            break;
        case ZJGradientTypeFromLeftToRight:
            start = CGPointMake(0.0, 0.5);
            end = CGPointMake(1, 0.5);
            break;
        case ZJGradientTypeFromLeftTopToRightBottom:
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(1, 1);
            break;
        case ZJGradientTypeFromLeftBottomToRightTop:
            start = CGPointMake(0.0, 1);
            end = CGPointMake(1, 0.0);
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
