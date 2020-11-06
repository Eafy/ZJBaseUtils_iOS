//
//  NSString+ZJJSON.m
//  ZJBaseUtils
//
//  Created by eafy on 2020/8/16.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import "NSString+ZJJSON.h"

@implementation NSString (ZJJSON)

- (id)zj_toJsonObj
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
