//
//  ZJModel.m
//  ZJBaseUtils
//
//  Created by eafy on 2020/9/26.
//  Copyright © 2020 ZJ<lizhijian_21@163.com>. All rights reserved.
//

#import "ZJModel.h"
#import "NSObject+ZJExt.h"
#import <objc/runtime.h>
#import "ZJModelFilter.h"
#import "ZJModelFilterGet.h"
#import "ZJModelFilterSet.h"

@implementation ZJModel

- (NSMutableDictionary *)toDictionary
{
    unsigned int count = 0;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    Ivar *ivar = class_copyIvarList([self class], &count);
    
    NSString *filterName = [NSString stringWithFormat:@"@\"%s\"", class_getName([ZJModelFilter class])];
    NSString *filterGetName = [NSString stringWithFormat:@"@\"%s\"", class_getName([ZJModelFilterGet class])];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    for (int i = 0; i < count; i++) {
        objc_property_t property = properties[i];
        NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        NSString *typeName = [NSString stringWithUTF8String:ivar_getTypeEncoding(ivar[i])];
        
        id propertyValue = [self valueForKey:propertyName];
        if (!propertyValue || [typeName isEqualToString:filterName] || [typeName isEqualToString:filterGetName]) {
            continue;
        } else if ([propertyValue isKindOfClass:[NSDictionary class]]) {
            propertyValue = [NSDictionary dictionaryWithDictionary:propertyValue];
        } else if ([propertyValue isKindOfClass:[NSArray class]]) {
            propertyValue = [NSArray arrayWithArray:propertyValue];
        } else if ([[propertyValue class] respondsToSelector:@selector(initWithDic:)]) {
            propertyValue = [propertyValue toDictionary];
            if (!propertyValue) {
                continue;
            }
        }
        
        [dict setObject:propertyValue forKey:propertyName];
    }
    if (properties) {
        free(properties);
    }
    if (ivar) {
        free(ivar);
    }
    
    return dict;
}

+ (instancetype)initWithDic:(NSDictionary *)dic
{
    id model = [[self alloc] init];
    
    unsigned int count = 0;
    objc_property_t *properties = class_copyPropertyList(self, &count);
    Ivar *ivars = class_copyIvarList(self, nil);
    
    NSString *filterName = [NSString stringWithFormat:@"@\"%s\"", class_getName([ZJModelFilter class])];
    NSString *filterGetName = [NSString stringWithFormat:@"@\"%s\"", class_getName([ZJModelFilterSet class])];
    
    for (int i = 0; i < count; i ++) {
        objc_property_t property = properties[i];
        NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property)  encoding:NSUTF8StringEncoding];
        
        id propertyValue = [dic objectForKey:propertyName];
        if (propertyValue) {
            NSString *typeName = [NSString stringWithCString:ivar_getTypeEncoding(ivars[i]) encoding:NSUTF8StringEncoding];
            if ([typeName isEqualToString:filterName] || [typeName isEqualToString:filterGetName]) {
                continue;
            }
            
            if (typeName.length > 3) {
                typeName = [typeName substringWithRange:NSMakeRange(2, typeName.length - 3)];
                Class cls = objc_getClass([typeName UTF8String]);
                if ([propertyValue isKindOfClass:[NSDictionary class]]) {
                    if ([cls respondsToSelector:@selector(initWithDic:)]) {
                        propertyValue = [cls initWithDic:propertyValue];
                    }
                } else {
                    if ([cls respondsToSelector:@selector(initWithName:value:)]) {
                        propertyValue = [cls initWithName:propertyName value:propertyValue];
                    }
                }
            }
            
            [model setValue:propertyValue forKey:propertyName];
        }
    }
    
    if (properties) {
        free(properties);
    }
    if (ivars) {
        free(ivars);
    }
    
    return model;
}

+ (instancetype)initWithName:(NSString *)name value:(NSArray *)value
{
    id model = [[self alloc] init];
    return model;
}

@end
