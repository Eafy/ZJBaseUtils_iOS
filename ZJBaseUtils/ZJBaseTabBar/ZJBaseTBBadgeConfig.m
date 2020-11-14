//
//  ZJBaseTBBadgeConfig.m
//  ZJBaseUtils
//
//  Created by eafy on 2020/11/14.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import "ZJBaseTBBadgeConfig.h"
#import "UIColor+ZJExt.h"

@implementation ZJBaseTBBadgeConfig

- (instancetype)init
{
    if (self = [super init]) {
        _badgeTextColor = [UIColor blackColor];
        _badgeBackgroundColor = [UIColor zj_colorWithHexString:@"#FF4040"];
    }
    return self;
}

@end
