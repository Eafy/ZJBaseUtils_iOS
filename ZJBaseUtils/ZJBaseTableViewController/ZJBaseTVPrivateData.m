//
//  ZJBaseTVPrivateData.m
//  ZJBaseUtils
//
//  Created by eafy on 2020/11/11.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import <ZJBaseUtils/ZJBaseTVPrivateData.h>
#import <objc/runtime.h>

@implementation ZJBaseTVPrivateData

- (id)copyWithZone:(struct _NSZone *)zone {
    Class class = [self class];
    ZJBaseTVPrivateData *obj = [[class allocWithZone:zone] init];
    while (class != [NSObject class]) {
        unsigned int count;
        Ivar *ivar = class_copyIvarList(class, &count);
        for (int i = 0; i < count; i++) {
            Ivar iv = ivar[i];
            const char *name = ivar_getName(iv);
            NSString *strName = [NSString stringWithUTF8String:name];
            NSString *typeName = [NSString stringWithUTF8String:ivar_getTypeEncoding(iv)];
            if ([typeName isEqualToString:@"*"]) {
                obj.pData = self.pData;
            } else {
                id value = [[self valueForKey:strName] copy];
                [obj setValue:value forKey:strName];
            }
        }
        free(ivar);
        
        class = class_getSuperclass(class);
    }
    return obj;
}

- (id)mutableCopyWithZone:(struct _NSZone *)zone {
    return [self copyWithZone:zone];
}

#pragma mark - 

- (ZJBaseTVConfig *)config
{
    if (!_config) {
        _config = [[ZJBaseTVConfig alloc] init];
    }
    return _config;
}

@end
