//
//  NSObject+JMExt.h
//  JMBaseUtils
//
//  Created by lzj<lizhijian_21@163.com> on 2020/8/12.
//  Copyright © 2020 Jimi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (JMExt)

/// 获取类的属性列表
- (NSArray *)jm_propertyList;

/// 成员类的变量列表
- (NSArray *)jm_ivarList;

/// 对象方法列表
- (NSArray *)jm_instanceMethodList;

/// 类协议字段
- (NSDictionary *)jm_protocolMap;

/// 交换类实例方法
/// @param oldMethod 旧方法
/// @param newMethod 新方法
- (void)jm_replaceMethod:(SEL)oldMethod newMethod:(SEL)newMethod;

#pragma mark - StaticAPI

/// 获取静态类的属性列表
+ (NSArray *)jm_propertyList;

/// 格式化之后的属性列表
+ (NSArray *)jm_propertyFormatList;

/// 成员变量列表
+ (NSArray *)jm_ivarList;

/// 类方法列表
+ (NSArray *)jm_classMethodList;

/// 协议字段
+ (NSDictionary *)jm_protocolMap;

/// 交换类方法
/// @param oldMethod 旧方法
/// @param newMethod 新方法
+ (void)jm_replaceMethod:(SEL)oldMethod newMethod:(SEL)newMethod;

/// 添加方法
/// @param methodSEL 添加调用的方法名
/// @param methodIMP 具体实现的方法名
+ (void)jm_addMethod:(SEL)methodSEL methodIMP:(SEL)methodIMP;

@end

NS_ASSUME_NONNULL_END
