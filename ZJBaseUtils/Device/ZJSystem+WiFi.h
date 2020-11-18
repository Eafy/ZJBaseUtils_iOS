//
//  ZJSystem+WiFi.h
//  ZJBaseUtils
//
//  Created by eafy on 2020/11/18.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import "ZJSystem.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZJSystem (WiFi)

/// 获取WiFi名称
+ (NSString *)fetchSSIDInfo;

/// 获取网关IP
+ (NSString *)gatewayIpForWiFi;

@end

NS_ASSUME_NONNULL_END
