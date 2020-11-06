//
//  ZJModelPairs.h
//  ZJBaseUtils
//
//  Created by eafy on 2020/10/16.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import <ZJBaseUtils/ZJModel.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZJModelPairs : ZJModel

/// 名称
@property (nonatomic,strong) NSString *name;
/// 值
@property (nonatomic,strong) id value;

/// 修改属性对应的名称(用来修改Get时候不想要属性名称时使用)
/// @param name 属性名称
/// @param value 属性值
+ (instancetype)initWithName:(NSString * _Nullable)name withValue:(id _Nullable)value;

@end

NS_ASSUME_NONNULL_END
