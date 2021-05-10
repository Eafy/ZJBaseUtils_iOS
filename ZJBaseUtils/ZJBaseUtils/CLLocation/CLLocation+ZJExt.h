//
//  CLLocation+ZJExt.h
//  ZJBaseUtils
//
//  Created by eafy on 2021/4/21.
//  Copyright © 2021 ZJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CLLocation (ZJExt)

/// 计算移动后的经纬度
/// @param location 当前经纬度
/// @param radian 方位角（弧度）
/// @param dst 移动距离
+ (CLLocationCoordinate2D)longLatOffset:(CLLocationCoordinate2D)location radian:(CGFloat)radian dst:(CGFloat)dst;

@end

NS_ASSUME_NONNULL_END
