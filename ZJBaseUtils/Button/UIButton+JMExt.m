//
//  UIButton.m
//  JMSmartUtils
//
//  Created by 李治健 on 2020/9/14.
//  Copyright © 2020 Jimi. All rights reserved.
//

#import "UIButton+JMExt.h"
#import "UIView+ZJFrame.h"

@implementation UIButton (JMExt)

- (void)jm_layoutWithEdgeInsetsStyle:(JMButtonEdgeInsetsStyle)style imageTitleSpace:(CGFloat)space;
{
    // 1. 得到imageView和titleLabel的宽、高
    CGFloat imageWith = self.imageView.frame.size.width;
    CGFloat imageHeight = self.imageView.frame.size.height;
 
    CGFloat labelWidth = 0.0;
    CGFloat labelHeight = 0.0;
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
        // 由于iOS8中titleLabel的size为0，用下面的这种设置
        labelWidth = self.titleLabel.intrinsicContentSize.width;
        labelHeight = self.titleLabel.intrinsicContentSize.height;
    } else {
        labelWidth = self.titleLabel.frame.size.width;
        labelHeight = self.titleLabel.frame.size.height;
    }
 
    // 2. 声明全局的imageEdgeInsets和labelEdgeInsets
    UIEdgeInsets imageEdgeInsets = UIEdgeInsetsZero;
    UIEdgeInsets labelEdgeInsets = UIEdgeInsetsZero;
 
    // 3. 根据style和space得到imageEdgeInsets和labelEdgeInsets的值
    switch (style) {
        case JMButtonEdgeInsetsStyleTop:
        {
            imageEdgeInsets = UIEdgeInsetsMake(-labelHeight-space/2.0, 0, 0, -labelWidth);
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith, -imageHeight-space/2.0, 0);
        }
            break;
        case JMButtonEdgeInsetsStyleLeft:
        {
            imageEdgeInsets = UIEdgeInsetsMake(0, -space/2.0, 0, space/2.0);
            labelEdgeInsets = UIEdgeInsetsMake(0, space/2.0, 0, -space/2.0);
        }
            break;
        case JMButtonEdgeInsetsStyleBottom:
        {
            imageEdgeInsets = UIEdgeInsetsMake(0, 0, -labelHeight-space/2.0, -labelWidth);
            labelEdgeInsets = UIEdgeInsetsMake(-imageHeight-space/2.0, -imageWith, 0, 0);
        }
            break;
        case JMButtonEdgeInsetsStyleRight:
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

- (void)jm_layoutWithEdgeInsets:(CGPoint)imgPoint labelPoint:(CGPoint)labelPoint
{
    CGFloat imageTop = -(self.imageView.zj_top - imgPoint.y);
    CGFloat imageLeft = -(self.imageView.zj_left - imgPoint.x);
    self.imageEdgeInsets = UIEdgeInsetsMake(imageTop, imageLeft, -imageTop, -imageLeft);

    CGFloat labelTop = -(self.titleLabel.zj_top - labelPoint.y);
    CGFloat labelLeft = -(self.titleLabel.zj_left - labelPoint.x);
    self.titleEdgeInsets = UIEdgeInsetsMake(labelTop, labelLeft, -labelTop, -labelLeft);
}

@end
