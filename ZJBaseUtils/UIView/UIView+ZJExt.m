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

- (void)zj_drawDashLineWithStartPoint:(CGPoint)sPoint endPoint:(CGPoint)ePoint color:(UIColor *)color w:(CGFloat)w s:(CGFloat)s
{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:self.bounds];
    [shapeLayer setPosition:self.center];
    [shapeLayer setFillColor:[[UIColor clearColor] CGColor]];
    // 设置虚线颜色为blackColor [shapeLayer setStrokeColor:[[UIColor blackColor] CGColor]];
    [shapeLayer setStrokeColor:[color CGColor]];
    // 3.0f设置虚线的宽度
    [shapeLayer setLineWidth:w];
    [shapeLayer setLineJoin:kCALineJoinRound];
    // 3=线的宽度 1=每条线的间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithFloat:w],[NSNumber numberWithFloat:s],nil]];
    // Setup the path
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, sPoint.x, sPoint.y);
    CGPathAddLineToPoint(path, NULL, ePoint.x, ePoint.y);
    
    [shapeLayer setPath:path];
    CGPathRelease(path);
    
    [[self layer] addSublayer:shapeLayer];
}

- (void)zj_drawCircularWithCornerRadii:(CGSize)cornerRadii rectCorner:(UIRectCorner)corners
{
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:cornerRadii];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = bezierPath.CGPath;
    self.layer.mask = maskLayer;
}

- (void)zj_drawCircularWithTopLeftRadius:(CGFloat)topLeftRadius rightUpRadius:(CGFloat)rightUpRadius rightDownRadius:(CGFloat)rightDownRadius leftDownRadius:(CGFloat)leftDownRadius
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
}

- (void)zj_cornerRadius:(CGFloat)radius
{
    [self zj_drawCircularWithCornerRadii:CGSizeMake(radius, radius) rectCorner:UIRectCornerAllCorners];
}

- (void)zj_drawBorderWithWidth:(CGFloat)width cornerRadii:(CGSize)cornerRadii rectCorner:(UIRectCorner)rectCorner length:(CGFloat)length space:(CGFloat)space strokeColor:(UIColor *)strokeColor
{
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:rectCorner cornerRadii:cornerRadii];
    CAShapeLayer *borderLayer = [CAShapeLayer layer];
    borderLayer.frame = self.bounds;
    borderLayer.path = bezierPath.CGPath;
    borderLayer.fillColor = [UIColor clearColor].CGColor;
    [borderLayer setLineWidth:width];
    if (space > 0) {
        [borderLayer setLineJoin:kCALineJoinRound];
        [borderLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithFloat:length],[NSNumber numberWithFloat:space],nil]];
    }
    borderLayer.strokeColor = strokeColor.CGColor;
    [self.layer addSublayer:borderLayer];
}

@end
