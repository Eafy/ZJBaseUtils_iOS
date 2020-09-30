//
//  UIView+ZJFrame.m
//  ZJBaseUtils
//
//  Created by eafy on 2020/8/18.
//  Copyright © 2020 ZJ<lizhijian_21@163.com>. All rights reserved.
//

#import "UIView+ZJFrame.h"

@implementation UIView (ZJFrame)

- (CGFloat)zj_width {
    return self.frame.size.width;
}

- (void)setZj_width:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)zj_height {
    return self.frame.size.height;
}

- (void)setZj_height:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)zj_left {
    return self.frame.origin.x;
}

- (void)setZj_left:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)zj_top {
    return self.frame.origin.y;
}

- (void)setZj_top:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)zj_right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setZj_right:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)zj_bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setZj_bottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)zj_centerX {
    return self.center.x;
}

- (void)setZj_centerX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)zj_centerY {
    return self.center.y;
}

- (void)setZj_centerY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}

- (CGPoint)zj_centerXY {
    return self.center;
}

- (void)setZj_centerXY:(CGPoint)centerXY {
    self.center = centerXY;
}

- (CGPoint)zj_origin {
    return self.frame.origin;
}

- (void)setZj_origin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGSize)zj_size {
    return self.frame.size;
}

- (void)setZj_size:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGPoint)zj_bottomRight {
    CGFloat x = self.frame.origin.x + self.frame.size.width;
    CGFloat y = self.frame.origin.y + self.frame.size.height;
    return CGPointMake(x, y);
}

- (CGPoint)zj_bottomLeft {
    CGFloat x = self.frame.origin.x;
    CGFloat y = self.frame.origin.y + self.frame.size.height;
    return CGPointMake(x, y);
}

- (CGPoint)zj_topRight {
    CGFloat x = self.frame.origin.x + self.frame.size.width;
    CGFloat y = self.frame.origin.y;
    return CGPointMake(x, y);
}

@end
