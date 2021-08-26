//
//  ZJBaseTabBarTopLineConfig.m
//  ZJBaseUtils
//
//  Created by eafy on 2020/11/16.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import <ZJBaseUtils/ZJBaseTabBarTopLineConfig.h>

@implementation ZJBaseTabBarTopLineConfig

- (instancetype)init
{
   if (self = [super init]) {
       _type = ZJBTBConfigTopLineTypeShadow;
       _lineWidth = 0.5f;
       _shadowColor = [UIColor lightGrayColor];
       _shadowOpacity = 1.0f;
       _shadowOffset = CGSizeMake(0, -2);
       _shadowRadius = 3.0f;
       _shadowPath = nil;
   }
   return self;
}

@end
