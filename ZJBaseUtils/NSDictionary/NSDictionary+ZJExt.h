//
//  NSDictionary+ZJExt.h
//  ZJBaseUtils
//
//  Created by eafy on 2020/8/16.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (ZJExt)

/// 转换为Json字符串
- (NSString *)zj_toJsonString;

/// 判断Key是否在字典中为空
/// @param key key值
- (id)zj_isValueWithKey:(NSString *)key;

@end

@interface NSMutableDictionary (ZJExt)

/// 生成NSMutableDictionary对象
/// @param dic 可为空
+ (instancetype)dictionaryWithDic:(NSDictionary * _Nullable)dic;

/// 添加字典
/// @param dic 字段数据，可为空
- (void)addEntriesFromDic:(NSDictionary * _Nullable)dic;

@end

NS_ASSUME_NONNULL_END
