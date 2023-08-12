//
//  NSUserDefaults+ZJExt.h
//  ZJBaseUtils
//
//  Created by eafy on 2023/4/26.
//  Copyright © 2023 ZJ. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 关键词搜索类型
typedef enum : NSUInteger {
    UserDefaultsKeySearchTypeEqual = 0,     //相等
    UserDefaultsKeySearchTypePrefix,        //前缀
    UserDefaultsKeySearchTypeSuffix,        //后缀
    UserDefaultsKeySearchTypeContains,      //包含
} UserDefaultsKeySearchType;

@interface NSUserDefaults (ZJExt)

/// 移除Key包含包含关键词的存档（NSUserDefaults归档）
/// - Parameters:
///   - key: 关键词
///   - type: 搜索类型，0：全部相等，1：前缀，2：后置，3：包含
- (BOOL)removeMagicKey:(NSString *)key type:(UserDefaultsKeySearchType)type;
    
#pragma mark -

/// 设置Group ID
/// - Parameter groupId: groupId，若不设置则按照group.主App的BlundeID
+ (void)zj_setGroupIdForUserDefaults:(NSString *)groupId;

/// 设置组件的归档值
/// - Parameters:
///   - value: 值
///   - key: Key
+ (void)zj_setWidgetValue:(nullable id)value forKey:(nullable NSString *)key;

/// 设置组件的归档字典(递增式)
/// - Parameter dic: 数据字典
+ (void)zj_setWidgetDicValue:(nullable NSDictionary *)dic;

/// 移除组件的归档的数据
/// - Parameter key: Key
+ (void)zj_removeWidgetValueForKey:(nullable NSString *)key;

/// 移除组件的归档的多个数据
/// - Parameter keys: Key列表
+ (void)zj_removeWidgetValuesForKeys:(nullable NSArray *)keys;

/// 移除组件的所有的归档数据
+ (void)zj_removeWidgetAllValue;

/// 获取组件的归档的值
/// - Parameter key: Key
+ (nullable id)zj_widgetValueForKey:(nullable NSString *)key;

@end

NS_ASSUME_NONNULL_END
