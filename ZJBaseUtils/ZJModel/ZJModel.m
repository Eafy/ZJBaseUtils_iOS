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

@implementation ZJModel

- (NSDictionary *)toDictionary
{
    unsigned int count = 0;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    Ivar *ivars = class_copyIvarList([self class], nil);
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    for (int i = 0; i < count; i++) {
        objc_property_t property = properties[i];
        NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        
        id propertyValue = [self valueForKey:propertyName];
        if (!propertyValue) {
            continue;
        } else if ([propertyValue isKindOfClass:[NSDictionary class]]) {
            propertyValue = [NSDictionary dictionaryWithDictionary:propertyValue];
        } else if ([propertyValue isKindOfClass:[NSArray class]]) {
            propertyValue = [NSArray arrayWithArray:propertyValue];
//        } else if ([propertyValue isKindOfClass:[ZJModel class]]) {
        } else if ([[propertyValue class] respondsToSelector:@selector(initWithDic:)]) {
            propertyValue = [propertyValue toDictionary];
        }
        
        [dict setObject:propertyValue forKey:propertyName];
    }
    
    return [dict copy];
}

+ (instancetype)initWithDic:(NSDictionary *)dic
{
   id model = [[self alloc] init];
     
   unsigned int count = 0;
   objc_property_t *properties = class_copyPropertyList(self, &count);
   Ivar *ivars = class_copyIvarList(self, nil);

   for (int i = 0; i < count; i ++) {
       objc_property_t property = properties[i];
       NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property)  encoding:NSUTF8StringEncoding];
    
       id propertyValue = [dic objectForKey:propertyName];
       if (propertyValue) {
           NSString *dataType = [NSString stringWithCString:ivar_getTypeEncoding(ivars[i]) encoding:NSUTF8StringEncoding];
           if (dataType.length > 3) {
               dataType = [dataType substringWithRange:NSMakeRange(2, dataType.length - 3)];
               Class cls = objc_getClass([dataType UTF8String]);
               if ([cls respondsToSelector:@selector(initWithDic:)]) {
                   propertyValue = [cls initWithDic:propertyValue];
               }
           }
           
           [model setValue:propertyValue forKey:propertyName];
       }
   }
    
   return model;
}

@end
