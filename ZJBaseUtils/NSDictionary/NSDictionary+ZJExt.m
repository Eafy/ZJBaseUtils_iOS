//
//  NSDictionary+ZJExt.m
//  ZJBaseUtils
//
//  Created by eafy on 2020/8/16.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import <ZJBaseUtils/NSDictionary+ZJExt.h>

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

- (id)zj_isValueWithKey:(NSString *)key
{
    id obj = [self objectForKey:key];
    if (obj) {
        if (![obj isEqual:[NSNull class]]) {
            return obj;
        }
    }
    
    return nil;
}

@end

@implementation NSMutableDictionary (ZJExt)

+ (instancetype)dictionaryWithDic:(NSDictionary *)dic {
    if (dic) {
        return [NSMutableDictionary dictionaryWithDictionary:dic];
    }
    return [NSMutableDictionary dictionary];
}

- (void)addEntriesFromDic:(NSDictionary *)dic {
    if (dic) {
        [self addEntriesFromDictionary:dic];
    }
}

@end
