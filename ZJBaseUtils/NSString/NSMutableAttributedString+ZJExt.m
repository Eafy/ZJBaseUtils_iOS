//
//  NSMutableAttributedString+ZJExt.m
//  ZJBaseUtils
//
//  Created by eafy on 2020/12/15.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import <ZJBaseUtils/NSMutableAttributedString+ZJExt.h>

@implementation NSMutableAttributedString (ZJExt)

- (void)zj_removeSpecialColor
{
    [self removeAttribute:NSForegroundColorAttributeName range:NSMakeRange(0, self.length)];
}

@end
