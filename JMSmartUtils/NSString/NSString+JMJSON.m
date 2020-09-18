//
//  NSString+JMJSON.m
//  JMBaseUtils
//
//  Created by lzj<lizhijian_21@163.com> on 2020/8/16.
//  Copyright © 2020 Jimi. All rights reserved.
//

#import "NSString+JMJSON.h"

@implementation NSString (JMJSON)

- (id)jm_toJsonObj
{
    if (!self) return nil;
    
    NSData* data = [self dataUsingEncoding:NSUTF8StringEncoding];
    __autoreleasing NSError* error = nil;
    id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    if (error != nil)
        return nil;
    return result;
}

@end
