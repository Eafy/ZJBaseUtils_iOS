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

- (NSDictionary *)zj_toDictionary
{
    if (!self) return nil;
    
    id result = [self zj_toJsonObj];
    if (result && [result isKindOfClass:[NSDictionary class]]) {
        return result;
    }
    
    return nil;
}

- (NSArray *)zj_toArray
{
    if (!self) return nil;
    
    id result = [self zj_toJsonObj];
    if (result && [result isKindOfClass:[NSArray class]]) {
        return result;
    }
    
    return nil;
}

@end
