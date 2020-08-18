//
//  ZJSystem.h
//  ZJBaseUtils
//
//  Created by eafy on 2020/8/18.
//  Copyright © 2020 ZJ<lizhijian_21@163.com>. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

extern CGFloat ZJSysVersion(void);

@interface ZJSystem : NSObject

/// 获取系统UUID
+ (NSString *)getUUID;

/// 获取指定长度的UUID
/// @param length UUID长度，最大64位
+ (NSString *)getUUID:(NSInteger)length;

/// 移除UUID记录
+ (void)removeUUID;

@end

NS_ASSUME_NONNULL_END
