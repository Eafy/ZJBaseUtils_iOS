//
//  NSData+ZJExt.m
//  ZJBaseUtils
//
//  Created by eafy on 2020/8/12.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import "NSData+ZJExt.h"

@implementation NSData (ZJExt)

- (NSString *)zj_base64String
{
    NSData *data = [self base64EncodedDataWithOptions:0];
    NSString *ret = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return ret;
}

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
