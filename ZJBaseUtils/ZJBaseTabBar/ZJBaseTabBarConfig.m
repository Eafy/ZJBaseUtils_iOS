//
//  ZJBaseTabBarConfig.m
//  ZJBaseUtils
//
//  Created by eafy on 2020/11/14.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import "ZJBaseTabBarConfig.h"
#import "UIColor+ZJExt.h"

@implementation ZJBaseTabBarConfig

- (instancetype)init
{
   if (self = [super init]) {
       _isClearTopLine = YES;
       _topLineColor = [UIColor lightGrayColor];
       _backgroundColor = [UIColor whiteColor];
       _norTitleColor = [UIColor grayColor];
       _selTitleColor = [UIColor blackColor];
       _imageSize = CGSizeMake(26, 26);
       _titleFont = 12.f;
       _titleOffset = 2.f;
       _imageOffset = 2.f;
       
       _imageScaleRatio = 1.53f;
       _scaleIndex = -1;
   }
   return self;
}

@end
