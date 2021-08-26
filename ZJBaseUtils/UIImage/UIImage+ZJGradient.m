//
//  UIImage+ZJGradient.m
//  ZJBaseUtils
//
//  Created by eafy on 2020/11/17.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import <ZJBaseUtils/UIImage+ZJGradient.h>

@implementation UIImage (ZJGradient)

+ (UIImage *)zj_gradientWithSize:(CGSize)size colors:(NSArray *)colors percents:(NSArray *)percents type:(ZJIMGGradientType)type
{
    CGFloat *locations = malloc(sizeof(CGFloat) * colors.count);
    NSMutableArray *colorArray = [NSMutableArray array];
    for (int i=0; i<colors.count; i++) {
        UIColor *color = [colors objectAtIndex:i];
        [colorArray addObject:(id)color.CGColor];
        if (i < percents.count) {
            locations[i] = [percents[i] floatValue];
        } else {
            locations[i] = 1.0;
        }
    }
    
    UIGraphicsBeginImageContextWithOptions(size, YES, UIScreen.mainScreen.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGColorSpaceRef colorSpace = CGColorGetColorSpace([[colors lastObject] CGColor]);
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)colorArray, locations);
    CGPoint start;
    CGPoint end;
    switch (type) {
        case ZJIMGGradientTypeFromTopToBottom:
            start = CGPointMake(size.width/2, 0.0);
            end = CGPointMake(size.width/2, size.height);
            break;
        case ZJIMGGradientTypeFromLeftToRight:
            start = CGPointMake(0.0, size.height/2);
            end = CGPointMake(size.width, size.height/2);
            break;
        case ZJIMGGradientTypeFromLeftTopToRightBottom:
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(size.width, size.height);
            break;
        case ZJIMGGradientTypeFromLeftBottomToRightTop:
            start = CGPointMake(0.0, size.height);
            end = CGPointMake(size.width, 0.0);
            break;
        default:
            break;
    }
    
    CGContextDrawLinearGradient(context, gradient, start, end, kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    CGGradientRelease(gradient);
    CGContextRestoreGState(context);
    CGColorSpaceRelease(colorSpace);
    UIGraphicsEndImageContext();
    free(locations);
    
    return image;
}

+ (UIImage *)zj_gradientRadialWithStartPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint startRadius:(CGFloat)startRadius endRadius:(CGFloat)endRadius colors:(NSArray *)colors percents:(NSArray *)percents
{
    CGFloat *locations = malloc(sizeof(CGFloat) * colors.count);
    NSMutableArray *colorArray = [NSMutableArray array];
    for (int i=0; i<colors.count; i++) {
        UIColor *color = [colors objectAtIndex:i];
        [colorArray addObject:(id)color.CGColor];
        if (i < percents.count) {
            locations[i] = [percents[i] floatValue];
        } else {
            locations[i] = 1.0;
        }
    }
    
    CGFloat x1 = endPoint.x - startPoint.x + startRadius + endRadius;
    CGFloat y1 = endPoint.y - startPoint.y + startRadius + endRadius;
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(x1, y1), YES, UIScreen.mainScreen.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGColorSpaceRef colorSpace = CGColorGetColorSpace([[colors lastObject] CGColor]);
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)colorArray, locations);
    
    CGContextDrawRadialGradient(context, gradient, startPoint, startRadius, endPoint, endRadius, kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    CGGradientRelease(gradient);
    CGContextRestoreGState(context);
    CGColorSpaceRelease(colorSpace);
    UIGraphicsEndImageContext();
    free(locations);
    
    return image;
}

+ (UIImage *)zj_gradientRadialWithSize:(CGSize)size radius:(CGFloat)radius colors:(NSArray *)colors percents:(NSArray *)percents
{
    CGFloat *locations = malloc(sizeof(CGFloat) * colors.count);
    NSMutableArray *colorArray = [NSMutableArray array];
    for (int i=0; i<colors.count; i++) {
        UIColor *color = [colors objectAtIndex:i];
        [colorArray addObject:(id)color.CGColor];
        if (i < percents.count) {
            locations[i] = [percents[i] floatValue];
        } else {
            locations[i] = 1.0;
        }
    }
    
    UIGraphicsBeginImageContextWithOptions(size, YES, UIScreen.mainScreen.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGColorSpaceRef colorSpace = CGColorGetColorSpace([[colors lastObject] CGColor]);
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)colorArray, locations);
    
    CGContextDrawRadialGradient(context, gradient, CGPointMake(size.width/2, size.height/2), 0, CGPointMake(size.width/2, size.height/2), radius, kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    CGGradientRelease(gradient);
    CGContextRestoreGState(context);
    CGColorSpaceRelease(colorSpace);
    UIGraphicsEndImageContext();
    free(locations);
    
    return image;
}

@end
