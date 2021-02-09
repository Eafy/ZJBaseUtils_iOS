//
//  ZJBaseTVConfig.m
//  ZJBaseUtils
//
//  Created by eafy on 2020/9/14.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import "ZJBaseTVConfig.h"
#import "UIColor+ZJExt.h"
#import <objc/runtime.h>

@interface ZJBaseTVConfig ()

@end

@implementation ZJBaseTVConfig

- (id)copyWithZone:(struct _NSZone *)zone {
    Class class = [self class];
    id obj = [[class allocWithZone:zone] init];
    while (class != [NSObject class]) {
        unsigned int count;
        Ivar *ivar = class_copyIvarList(class, &count);
        for (int i = 0; i < count; i++) {
            Ivar iv = ivar[i];
            const char *name = ivar_getName(iv);
            NSString *strName = [NSString stringWithUTF8String:name];
            id value = [[self valueForKey:strName] copy];
            [obj setValue:value forKey:strName];
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

- (instancetype)init
{
    if (self = [super init]) {
        
        _rowHeight = 56.0f;
        
        _cellTitleColor = ZJColorFromRGB(0x181E28);
        _cellSubTitleColor = ZJColorFromRGB(0x8690A9);
        _cellDetailTitleColor = ZJColorFromRGB(0x5A6482);
        
        _cellTitleFont = [UIFont systemFontOfSize:16.0f];
        _cellSubTitleFont = [UIFont systemFontOfSize:12.0f];
        _cellDetailTitleFont = [UIFont systemFontOfSize:13.0f];
        
        _marginLeft = 15.f;
        _marginRight = 10.f;
        _arrowLeftSpace = 5.f;
        _iconLeftSpace = 0;
        _iconRightSpace = 5.f;
        _arrowLeftSpace = 5.f;
        _arrowRightSpace = 5.f;
        
        _lineHeight = .5f;
    }
    
    return self;
}

@end
