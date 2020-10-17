//
//  ZJModelPairs.m
//  ZJBaseUtils
//
//  Created by 李治健 on 2020/10/16.
//  Copyright © 2020 ZJ<lizhijian_21@163.com>. All rights reserved.
//

#import "ZJModelPairs.h"

@implementation ZJModelPairs

+ (ZJModelType)modelType
{
    return ZJModelTypePairs;
}

+ (instancetype)initWithName:(NSString *)name withValue:(id)value
{
    ZJModelPairs *model = [[self alloc] init];
    model.name = name;
    model.value = value;
    
    return model;
}

@end
