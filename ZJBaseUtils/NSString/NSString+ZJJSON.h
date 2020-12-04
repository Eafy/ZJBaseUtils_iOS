//
//  NSString+ZJJSON.h
//  ZJBaseUtils
//
//  Created by eafy on 2020/8/16.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (ZJJSON)

/// 将字符串转成NSArray或NSDictionary对象
- (id)zj_toJsonObj;

/// 转字典
- (NSDictionary * _Nullable)zj_toDictionary;

/// 转数组
- (NSArray * _Nullable)zj_toArray;

@end

NS_ASSUME_NONNULL_END
