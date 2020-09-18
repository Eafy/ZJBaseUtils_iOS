//
//  NSString+JMIMGExt.m
//  JMSmartUtils
//
//  Created by 李治健 on 2020/9/15.
//  Copyright © 2020 Jimi. All rights reserved.
//

#import "NSString+JMIMGExt.h"

@implementation NSString (JMIMGExt)

- (UIImage *)jm_toImage
{
    if (self) {
        return [UIImage imageNamed:self];
    }
    
    return nil;
}

@end
