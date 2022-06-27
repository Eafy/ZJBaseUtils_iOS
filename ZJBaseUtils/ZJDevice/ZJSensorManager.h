//
//  ZJSensorManager.h
//  ZJBaseUtils
//
//  Created by eafy on 2022/6/23.
//  Copyright © 2022 ZJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ZJBaseUtils/ZJSingleton.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZJSensorManager : NSObject
singleton_h();

/// 开启距离传感器
/// @param handler 回调
- (void)startProximity:(void (^ __nullable)(BOOL enable))handler;

/// 停止距离传感器
- (void)stopProximity;

/// 开始电话接听监控
/// @param handler 回调，type：0，挂断，1：来电或拨号，2：接通
- (void)startCallMonitor:(void (^ __nullable)(NSInteger type))handler;

/// 停止电话接听监控
- (void)stopCallMonitor;

@end

NS_ASSUME_NONNULL_END
