//
//  NSString+ZJIMGExt.m
//  ZJBaseUtils
//
//  Created by eafy on 2020/9/15.
//  Copyright © 2020 ZJ<lizhijian_21@163.com>. All rights reserved.
//

#import "NSString+ZJIMGExt.h"

@implementation NSString (ZJIMGExt)

- (UIImage *)zj_toImage
{
    if (self) {
        return [UIImage imageNamed:self];
    }
    
    return nil;
}

@end
