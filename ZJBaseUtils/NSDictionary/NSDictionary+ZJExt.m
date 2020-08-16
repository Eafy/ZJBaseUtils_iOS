//
//  NSDictionary+ZJExt.m
//  ZJBaseUtils
//
//  Created by eafy on 2020/8/16.
//  Copyright © 2020 ZJ<lizhijian_21@163.com>. All rights reserved.
//

#import "NSDictionary+ZJExt.h"

@implementation NSDictionary (ZJExt)

- (NSString *)zj_toJsonString
{
    if (!self) return nil;

    NSError* error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:0 error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    if (error != nil)
        return nil;
    return jsonString;
}

@end
