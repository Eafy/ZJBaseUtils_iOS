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
       _topLineConfig = [[ZJBaseTabBarTopLineConfig alloc] init];
       
       _backgroundColor = [UIColor whiteColor];
       _norTitleColor = [UIColor grayColor];
       _selTitleColor = [UIColor blackColor];
       _imageSize = CGSizeMake(26, 26);
       _titleFont = 12.f;
       _titleOffset = 2.f;
       _imageOffset = 2.f;
       
       _imageScaleRatio = 1.30f;
       _centerImageSize = CGSizeMake(40.0, 40.0);
       _centerImageOffset = -20.0f;
       
       _effectType = ZJBTBConfigSelectEffectTypeNormal;
   }
   return self;
}

@end
