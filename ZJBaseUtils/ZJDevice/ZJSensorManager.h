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
- (void)startProximity:(void (^ __nullable)(BOOL enable))handler;

/// 停止距离传感器
- (void)stopProximity;

@end

NS_ASSUME_NONNULL_END
