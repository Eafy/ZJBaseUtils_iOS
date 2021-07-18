//
//  UIButton+ZJExt.m
//  ZJBaseUtils
//
//  Created by eafy on 2020/9/14.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import "UIButton+ZJExt.h"
#import "UIView+ZJFrame.h"

@implementation UIButton (ZJExt)

- (void)zj_layoutWithEdgeInsetsStyle:(ZJButtonEdgeInsetsStyle)style imageTitleSpace:(CGFloat)space
{
    // 1. 得到imageView和titleLabel的宽、高
    CGFloat imageWith = self.imageView.frame.size.width;
    CGFloat imageHeight = self.imageView.frame.size.height;
    
    CGFloat labelWidth = self.titleLabel.intrinsicContentSize.width;
    CGFloat labelHeight = self.titleLabel.intrinsicContentSize.height;
    
    // 2. 声明全局的imageEdgeInsets和labelEdgeInsets
    UIEdgeInsets imageEdgeInsets = UIEdgeInsetsZero;
    UIEdgeInsets labelEdgeInsets = UIEdgeInsetsZero;
    
    // 3. 根据style和space得到imageEdgeInsets和labelEdgeInsets的值
    switch (style) {
        case ZJButtonEdgeInsetsStyleTop:
        {
            imageEdgeInsets = UIEdgeInsetsMake(-labelHeight-space/2.0, 0, 0, -labelWidth);
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith, -imageHeight-space/2.0, 0);
        }
            break;
        case ZJButtonEdgeInsetsStyleLeft:
        {
            imageEdgeInsets = UIEdgeInsetsMake(0, -space/2.0, 0, space/2.0);
            labelEdgeInsets = UIEdgeInsetsMake(0, space/2.0, 0, -space/2.0);
        }
            break;
        case ZJButtonEdgeInsetsStyleBottom:
        {
            imageEdgeInsets = UIEdgeInsetsMake(0, 0, -labelHeight-space/2.0, -labelWidth);
            labelEdgeInsets = UIEdgeInsetsMake(-imageHeight-space/2.0, -imageWith, 0, 0);
        }
            break;
        case ZJButtonEdgeInsetsStyleRight:
        {
            imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth+space/2.0, 0, -labelWidth-space/2.0);
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith-space/2.0, 0, imageWith+space/2.0);
        }
            break;
        default:
            break;
    }
    
    self.titleEdgeInsets = labelEdgeInsets;
    self.imageEdgeInsets = imageEdgeInsets;
}

- (void)zj_layoutWithEdgeInsets:(CGPoint)imgPoint labelPoint:(CGPoint)labelPoint
{
    CGFloat imageTop = -(self.imageView.zj_top - imgPoint.y);
    CGFloat imageLeft = -(self.imageView.zj_left - imgPoint.x);
    self.imageEdgeInsets = UIEdgeInsetsMake(imageTop, imageLeft, -imageTop, -imageLeft);

    CGFloat labelTop = -(self.titleLabel.zj_top - labelPoint.y);
    CGFloat labelLeft = -(self.titleLabel.zj_left - labelPoint.x);
    self.titleEdgeInsets = UIEdgeInsetsMake(labelTop, labelLeft, -labelTop, -labelLeft);
}

- (void)zj_layoutClear
{
    self.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    self.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
}

#pragma mark -


@end
