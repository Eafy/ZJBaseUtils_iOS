//
//  ZJModel.m
//  ZJBaseUtils
//
//  Created by eafy on 2020/9/26.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import <ZJBaseUtils/ZJModel.h>
#import <ZJBaseUtils/NSObject+ZJExt.h>
#import <objc/runtime.h>
#import <ZJBaseUtils/ZJModelPairs.h>

@implementation ZJModel

+ (ZJModelType)modelType
{
    return ZJModelTypeGeneral;
}

+ (instancetype)initWithDic:(NSDictionary *)dic
{
    id model = [[self alloc] init];
    
    unsigned int count = 0;
    objc_property_t *properties = class_copyPropertyList(self, &count);
    Ivar *ivars = class_copyIvarList(self, nil);
    if (!properties || !ivars) return model;
    
    for (int i = 0; i < count; i ++) {
        objc_property_t property = properties[i];
        NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property)  encoding:NSUTF8StringEncoding];
        NSString *typeName = [NSString stringWithUTF8String:ivar_getTypeEncoding(ivars[i])];
        
        id propertyValue = [dic objectForKey:propertyName];
        if (propertyValue) {
            if (typeName.length > 3) {
                typeName = [typeName substringWithRange:NSMakeRange(2, typeName.length - 3)];
                Class cls = objc_getClass([typeName UTF8String]);
                if (cls && [cls respondsToSelector:@selector(modelType)]) {     //自定义Model类型
                    ZJModelType type = [cls modelType];
                    if (type == ZJModelTypeDisable || type == ZJModelTypeGet) {
                        continue;
                    } else if (type == ZJModelTypePairs) {
                        propertyValue = [cls initWithName:propertyName withValue:propertyValue];
                    } else if ([propertyValue isKindOfClass:[NSDictionary class]]) {
                        propertyValue = [cls initWithDic:propertyValue];
                    }
                }
            }
            
            [model setValue:propertyValue forKey:propertyName];
        }
    }
    free(properties);
    free(ivars);
    
    return model;
}


#pragma mark -

- (NSMutableDictionary *)toDictionary
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    Class superCls = [ZJModel class];
    
    unsigned int count = 0;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    Ivar *ivars = class_copyIvarList([self class], &count);
    if (!properties || !ivars) return dict;
    
    for (int i = 0; i < count; i++) {
        objc_property_t property = properties[i];
        NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        NSString *typeName = [NSString stringWithUTF8String:ivar_getTypeEncoding(ivars[i])];
        
        id propertyValue = [self valueForKey:propertyName];
        if (!propertyValue) {
            continue;
        }
        if (typeName.length > 3) {
            typeName = [typeName substringWithRange:NSMakeRange(2, typeName.length - 3)];
            Class cls = objc_getClass([typeName UTF8String]);
            if (cls && [cls respondsToSelector:@selector(modelType)]) {     //自定义Model类型
                ZJModelType type = [cls modelType];
                if (type == ZJModelTypeDisable || type == ZJModelTypeSet) {
                    continue;
                } else {
                    if ([propertyValue isKindOfClass:superCls]) {
                        propertyValue = [propertyValue toDictionary];
                        if (!propertyValue) {
                            continue;
                        }
                    }
                }
            }
        }
        
        [dict setObject:propertyValue forKey:propertyName];
    }
    
    free(properties);
    free(ivars);
    
    return dict;
}

@end
