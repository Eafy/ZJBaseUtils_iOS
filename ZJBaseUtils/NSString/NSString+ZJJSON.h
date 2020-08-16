//
//  NSString+ZJJSON.h
//  ZJBaseUtils
//
//  Created by eafy on 2020/8/16.
//  Copyright © 2020 ZJ<lizhijian_21@163.com>. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (ZJJSON)

/// 将字符串转成NSArray或NSDictionary对象
- (id)zj_toJsonObj;

@end

NS_ASSUME_NONNULL_END
