//
//  ZJModel.h
//  ZJBaseUtils
//
//  Created by eafy on 2020/9/26.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    ZJModelTypeGeneral,     //普通的，包含Set和Get功能
    ZJModelTypeDisable,     //禁用Set和Get功能
    ZJModelTypeGet,         //禁用Set功能
    ZJModelTypeSet,         //禁用Get功能
    ZJModelTypePairs,       //键值对
} ZJModelType;

@interface ZJModel : NSObject

/// 模型类型
+ (ZJModelType)modelType;

/// 字段转Model
/// @param dic 数据字典
+ (instancetype)initWithDic:(NSDictionary * _Nonnull)dic;

#pragma mark -

/// Model转字典
- (NSMutableDictionary *)toDictionary;

@end

NS_ASSUME_NONNULL_END
