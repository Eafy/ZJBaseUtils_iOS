//
//  ZJSettingCenterLableItem.m
//  ZJBaseUtils
//
//  Created by eafy on 2020/9/14.
//  Copyright © 2020 ZJ<lizhijian_21@163.com>. All rights reserved.
//

#import "ZJSettingCenterLableItem.h"
#import "UIColor+ZJExt.h"

@implementation ZJSettingCenterLableItem

- (instancetype)initWithIcon:(NSString *)icon title:(NSString *)title destClass:(Class)destVc
{
    if (self = [super initWithIcon:icon title:title destClass:destVc]) {
        _titleColor = ZJColorFromRGB(0xF02359);
        _titleFont = [UIFont boldSystemFontOfSize:16.0f];
    }
    return self;
}

@end
