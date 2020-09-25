//
//  UIView+ZJExt.m
//  ZJBaseUtils
//
//  Created by eafy on 2020/8/18.
//  Copyright © 2020 ZJ<lizhijian_21@163.com>. All rights reserved.
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
