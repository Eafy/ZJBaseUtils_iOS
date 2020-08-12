//
//  NSData+ZJExt.m
//  ZJBaseUtils
//
//  Created by eafy on 2020/8/12.
//  Copyright © 2020 ZJ<lizhijian_21@163.com>. All rights reserved.
//

#import "NSData+ZJExt.h"

@implementation NSData (ZJExt)

- (NSString *)toHexString
{
    const unsigned char *bytes = [self bytes];
    if (!bytes) return @"";
    
    NSMutableString *string = [NSMutableString string];
    for (int i=0; i<self.length; i++) {
        [string appendFormat:@"%02X", bytes[i]];
    }
    return string;
}

@end
