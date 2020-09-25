//
//  ZJSettingSwitchItem.m
//  ZJBaseUtils
//
//  Created by eafy on 2020/9/14.
//  Copyright © 2020 ZJ<lizhijian_21@163.com>. All rights reserved.
//
#import "ZJSettingSwitchItem.h"

@implementation ZJSettingSwitchItem

- (instancetype)initWithIcon:(NSString *)icon title:(NSString *)title
{
    if (self = [super initWithIcon:icon title:title]) {
        _switchBtnEnable = YES;
    }
    
    return self;
}

- (instancetype)initWithIcon:(NSString *)icon title:(NSString *)title destClass:(Class)destVc
{
    if (self = [super initWithIcon:icon title:title destClass:destVc]) {
        _switchBtnEnable = YES;
    }
    
    return self;
}

@end
