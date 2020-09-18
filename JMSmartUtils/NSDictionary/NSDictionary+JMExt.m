//
//  NSDictionary+JMExt.m
//  JMBaseUtils
//
//  Created by lzj<lizhijian_21@163.com> on 2020/8/16.
//  Copyright © 2020 Jimi. All rights reserved.
//

#import "NSDictionary+JMExt.h"

@implementation NSDictionary (JMExt)

- (NSString *)jm_toJsonString
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
