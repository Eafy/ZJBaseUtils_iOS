//
//  NSString+JMJSON.h
//  JMBaseUtils
//
//  Created by lzj<lizhijian_21@163.com> on 2020/8/16.
//  Copyright © 2020 Jimi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (JMJSON)

/// 将字符串转成NSArray或NSDictionary对象
- (id)jm_toJsonObj;

@end

NS_ASSUME_NONNULL_END
