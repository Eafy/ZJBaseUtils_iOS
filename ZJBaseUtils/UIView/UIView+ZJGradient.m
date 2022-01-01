//
//  UIView+ZJGradient.m
//  ZJBaseUtils
//
//  Created by eafy on 2020/11/29.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import <ZJBaseUtils/UIView+ZJGradient.h>

@implementation UIView (ZJGradient)

- (void)zj_gradientWithColors:(NSArray<UIColor *> *_Nonnull)colors percents:(NSArray<NSNumber *> *_Nonnull)percents opacity:(CGFloat)opacity type:(ZJGradientType)type
{
    CGPoint start = CGPointZero;
    CGPoint end = CGPointZero;
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

    [self zj_gradientWithColors:colors percents:percents opacity:opacity startPoint:start endPoint:end];
}

- (void)zj_gradientWithColors:(NSArray<UIColor *> *_Nonnull)colors percents:(NSArray<NSNumber *> *_Nonnull)percents opacity:(CGFloat)opacity startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint
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
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = colorArray;
    gradientLayer.locations = percents;
    gradientLayer.startPoint = startPoint;
    gradientLayer.endPoint = endPoint;
    gradientLayer.frame = self.bounds;
    gradientLayer.opacity = opacity;
    
    [self.layer addSublayer:gradientLayer];
}

@end
