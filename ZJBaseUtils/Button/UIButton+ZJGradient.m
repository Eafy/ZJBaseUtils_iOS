//
//  UIButton+ZJGradient.m
//  ZJBaseUtils
//
//  Created by eafy on 2020/11/17.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import "UIButton+ZJGradient.h"

@implementation UIButton (ZJGradient)

- (void)zj_gradientWithSize:(CGSize)size colors:(NSArray<UIColor *> *)colors percents:(NSArray *)percents type:(ZJIMGGradientType)type
{
    UIImage *backImage = [UIImage zj_gradientWithSize:size colors:colors percents:percents type:type];
    [self setBackgroundImage:backImage forState:UIControlStateNormal];
}

- (void)zj_gradientWithType:(ZJIMGGradientType)type colors:(NSArray<UIColor *> *_Nonnull)colors percents:(NSArray *_Nonnull)percents
{
    UIImage *backImage = [UIImage zj_gradientWithSize:self.bounds.size colors:colors percents:percents type:type];
    [self setBackgroundImage:backImage forState:UIControlStateNormal];
}

@end
