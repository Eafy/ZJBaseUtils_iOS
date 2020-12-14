//
//  UIView+ZJExt.m
//  ZJBaseUtils
//
//  Created by eafy on 2020/8/18.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import "UIView+ZJExt.h"

@implementation UIView (ZJExt)

- (UIImage *)zj_toImage
{
    if (!self) nil;
    UIGraphicsBeginImageContext(self.bounds.size);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (void)zj_dottedLineWithStartPoint:(CGPoint)sPoint endPoint:(CGPoint)ePoint color:(UIColor *_Nonnull )color size:(CGSize)size space:(CGFloat)space
{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:self.bounds];
    [shapeLayer setPosition:self.center];
    [shapeLayer setFillColor:[[UIColor clearColor] CGColor]];
    [shapeLayer setStrokeColor:[color CGColor]];
    [shapeLayer setLineWidth:size.height];
    [shapeLayer setLineJoin:kCALineJoinRound];
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithFloat:size.width],[NSNumber numberWithFloat:space],nil]];

    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, sPoint.x, sPoint.y);
    CGPathAddLineToPoint(path, NULL, ePoint.x, ePoint.y);
    
    [shapeLayer setPath:path];
    CGPathRelease(path);
    
    [[self layer] addSublayer:shapeLayer];
}

- (void)zj_borderWithWidth:(CGFloat)width cornerRadii:(CGSize)cornerRadii rectCorner:(UIRectCorner)rectCorner length:(CGFloat)length space:(CGFloat)space strokeColor:(UIColor *)strokeColor
{
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:rectCorner cornerRadii:cornerRadii];
    CAShapeLayer *borderLayer = [CAShapeLayer layer];
    borderLayer.frame = self.bounds;
    borderLayer.path = bezierPath.CGPath;
    borderLayer.fillColor = [UIColor clearColor].CGColor;
    [borderLayer setLineWidth:width];
    if (space > 0 && length > 0) {
        [borderLayer setLineJoin:kCALineJoinRound];
        [borderLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithFloat:length],[NSNumber numberWithFloat:space],nil]];
    }
    borderLayer.strokeColor = strokeColor.CGColor;
    [self.layer addSublayer:borderLayer];
}

- (void)zj_borderWithWidth:(CGFloat)width color:(UIColor *)color
{
    self.layer.borderColor = color.CGColor;
    self.layer.borderWidth = width;
    self.layer.masksToBounds = YES;
}

#pragma mark - 

- (void)zj_cornerWithRadii:(CGSize)cornerRadii rectCorner:(UIRectCorner)corners
{
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:cornerRadii];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = bezierPath.CGPath;
    self.layer.mask = maskLayer;
}

- (CAShapeLayer *)zj_cornerWithTopLeftRadius:(CGFloat)topLeftRadius rightUpRadius:(CGFloat)rightUpRadius rightDownRadius:(CGFloat)rightDownRadius leftDownRadius:(CGFloat)leftDownRadius
{
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    
    //笔画停留位置点
    CGPoint leftUpPoint = CGPointMake(0, topLeftRadius);
    CGPoint rightUpPoint = CGPointMake(width-topLeftRadius-rightUpRadius, 0);
    CGPoint rightDownPoint = CGPointMake(width, height-rightUpRadius-rightDownRadius);
    CGPoint leftDownPoint = CGPointMake(width-rightDownRadius-leftDownRadius, height);
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    for (int i=0; i<4; i++) {
        CGPoint center = CGPointMake(0, 0);
        CGFloat startAngle = 0;
        CGFloat endAngle = 0;
        
        CGFloat radius = topLeftRadius;
        if (i == 0) {
            center.x = radius;
            center.y = radius;
            startAngle = M_PI;
            endAngle = M_PI * 1.5;
            [bezierPath moveToPoint:CGPointZero];
            [bezierPath moveToPoint:leftUpPoint];   //移动笔画到对应位置
            [bezierPath addArcWithCenter:center radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES];   //画弧线
        } else if (i == 1) {
            radius = rightUpRadius;
            center.x = width - radius;
            center.y = radius;
            startAngle = M_PI * 1.5;
            endAngle = 0;
            [bezierPath addLineToPoint:rightUpPoint];   //画线条
            [bezierPath addArcWithCenter:center radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES];
        } else if (i == 2) {
            radius = rightDownRadius;
            center.x = width - radius;
            center.y = height - radius;
            startAngle = 0;
            endAngle = M_PI * 0.5;
            [bezierPath addLineToPoint:rightDownPoint];
            [bezierPath addArcWithCenter:center radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES];
        } else if (i == 3) {
            radius = leftDownRadius;
            center.x = radius;
            center.y = height - radius;
            startAngle = M_PI * 0.5;
            endAngle = M_PI;
            [bezierPath addLineToPoint:leftDownPoint];
            [bezierPath addArcWithCenter:center radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES];
            [bezierPath addLineToPoint:leftUpPoint];
            [bezierPath closePath]; //结束画线
        }
    }
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = bezierPath.CGPath;
    self.layer.mask = maskLayer;
    
    return maskLayer;
}

- (void)zj_cornerWithRadius:(CGFloat)radius
{
    [self zj_cornerWithRadii:CGSizeMake(radius, radius) rectCorner:UIRectCornerAllCorners];
}

@end
