//
//  NSUserDefaults+ZJExt.h
//  ZJBaseUtils
//
//  Created by sean on 2023/4/26.
//  Copyright © 2023 ZJ. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSUserDefaults (ZJExt)

/// 设置Group ID
/// - Parameter groupId: groupId，若不设置则按照group.主App的BlundeID
+ (void)setGroupIdForUserDefaults:(NSString *)groupId;

/// 设置组件的归档值
/// - Parameters:
///   - value: 值
///   - key: Key
+ (void)setWidgetValue:(nullable id)value forKey:(nullable NSString *)key;

/// 设置组件的归档字典(递增式)
/// - Parameter dic: 数据字典
+ (void)setWidgetDicValue:(nullable NSDictionary *)dic;

/// 移除组件的归档的数据
/// - Parameter key: Key
+ (void)removeWidgetValueForKey:(nullable NSString *)key;

/// 移除组件的归档的多个数据
/// - Parameter keys: Key列表
+ (void)removeWidgetValuesForKeys:(nullable NSArray *)keys;

/// 移除组件的所有的归档数据
+ (void)removeWidgetAllValue;

/// 获取组件的归档的值
/// - Parameter key: Key
+ (nullable id)widgetValueForKey:(nullable NSString *)key;

@end

NS_ASSUME_NONNULL_END