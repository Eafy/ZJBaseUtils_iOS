//
//  NSString+ZJIMGExt.m
//  ZJBaseUtils
//
//  Created by eafy on 2020/9/15.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import <ZJBaseUtils/NSString+ZJIMGExt.h>

@implementation NSString (ZJIMGExt)

- (UIImage *)zj_toImage
{
    if (self) {
        return [UIImage imageNamed:self];
    }
    
    return nil;
}

@end
