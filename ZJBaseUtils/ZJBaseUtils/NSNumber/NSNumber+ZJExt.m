//
//  NSNumber+ZJExt.m
//  ZJBaseUtils
//
//  Created by eafy on 2021/4/9.
//  Copyright © 2021 ZJ. All rights reserved.
//

#import "NSNumber+ZJExt.h"

@implementation NSNumber (ZJExt)

+ (CGFloat)remainderWithValue:(CGFloat)value divisor:(CGFloat)divisor
{
    while (value >= divisor) {
        value -= divisor;
    }
    
    return value;
}

@end
