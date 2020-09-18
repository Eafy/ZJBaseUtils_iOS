//
//  NSDictionary+JMExt.h
//  JMBaseUtils
//
//  Created by lzj<lizhijian_21@163.com> on 2020/8/16.
//  Copyright © 2020 Jimi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (JMExt)

/// 转换为Json字符串
- (NSString *)jm_toJsonString;

@end

NS_ASSUME_NONNULL_END
