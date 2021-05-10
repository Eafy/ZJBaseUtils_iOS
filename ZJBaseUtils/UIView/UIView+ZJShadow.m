//
//  UIView+ZJShadow.m
//  ZJBaseUtils
//
//  Created by eafy on 2020/12/9.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import "UIView+ZJShadow.h"

@implementation UIView (ZJShadow)

- (void)zj_shadowWithOpacity:(float)shadowOpacity shadowRadius:(CGFloat)shadowRadius andCornerRadius:(CGFloat)cornerRadius
{
    self.layer.cornerRadius = cornerRadius;
    
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOpacity = shadowOpacity; //阴影透明度，默认0
    self.layer.shadowRadius = shadowRadius;    ////阴影半径，默认3
    self.layer.shadowOffset = CGSizeMake(0, 0);    //阴影偏移量。有值是向下向右偏移。
    
    self.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:self.layer.cornerRadius].CGPath;
}

@end
