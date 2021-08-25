//
//  NSObject+ZJExt.h
//  ZJBaseUtils
//
//  Created by eafy on 2020/8/12.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (ZJExt)

/// 获取类的属性列表
- (NSArray *)zj_propertyList;

/// 成员类的变量列表
- (NSArray *)zj_ivarList;

/// 对象方法列表
- (NSArray *)zj_instanceMethodList;

/// 类协议字段
- (NSDictionary *)zj_protocolMap;

/// 交换类实例方法
/// @param oldMethod 旧方法
/// @param newMethod 新方法
- (void)zj_replaceMethod:(SEL)oldMethod newMethod:(SEL)newMethod;

#pragma mark - StaticAPI

/// 查找类
/// @param className 类名
+ (Class)findClass:(NSString *)className;

/// 获取类的属性列表
+ (NSArray *)zj_propertyList;

/// 格式化之后的属性列表
+ (NSArray *)zj_propertyFormatList;

/// 成员变量列表
+ (NSArray *)zj_ivarList;

/// 类方法列表
+ (NSArray *)zj_classMethodList;

/// 协议字段
+ (NSDictionary *)zj_protocolMap;

/// 交换类方法
/// @param oldMethod 旧方法
/// @param newMethod 新方法
+ (void)zj_replaceMethod:(SEL)oldMethod newMethod:(SEL)newMethod;

/// 添加方法
/// @param methodSEL 添加调用的方法名
/// @param methodIMP 具体实现的方法名
+ (void)zj_addMethod:(SEL)methodSEL methodIMP:(SEL)methodIMP;

@end

NS_ASSUME_NONNULL_END
