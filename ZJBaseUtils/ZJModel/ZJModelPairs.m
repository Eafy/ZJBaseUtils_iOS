//
//  ZJModelPairs.m
//  ZJBaseUtils
//
//  Created by eafy on 2020/10/16.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import <ZJBaseUtils/ZJModelPairs.h>

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
