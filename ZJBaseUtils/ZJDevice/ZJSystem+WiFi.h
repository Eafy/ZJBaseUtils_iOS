//
//  ZJSystem+WiFi.h
//  ZJBaseUtils
//
//  Created by eafy on 2020/11/18.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import <ZJBaseUtils/ZJSystem.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZJSystem (WiFi)

/// 获取WiFi名称
+ (NSString *)fetchSSIDInfo;

/// 获取本机IP
+ (NSString *)localIP;

+ (NSString *)gatewayIPFromWiFi;

@end

NS_ASSUME_NONNULL_END
