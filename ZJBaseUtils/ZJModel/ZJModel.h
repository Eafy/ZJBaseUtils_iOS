//
//  ZJModel.h
//  ZJBaseUtils
//
//  Created by eafy on 2020/9/26.
//  Copyright © 2020 ZJ<lizhijian_21@163.com>. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZJModel : NSObject

/// Model转字典
- (NSMutableDictionary *)toDictionary;

/// 字段转Model
/// @param dic 数据字典
+ (instancetype)initWithDic:(NSDictionary *)dic;

/// 名称和值转Model(此方法用来名称和key不对应的情况)
/// @param name 属性名称
/// @param value 属性值
+ (instancetype)initWithName:(NSString *)name value:(id)value;

@end

NS_ASSUME_NONNULL_END
