//
//  ZJGpsUtils.h
//  ZJBaseUtils
//
//  Created by eafy on 2023/4/26.
//  Copyright © 2023 ZJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <ZJBaseUtils/ZJSingleton.h>

NS_ASSUME_NONNULL_BEGIN

extern NSString *const kMapCoordTypeBD09ll;
extern NSString *const kMapCoordTypeGCJ02;
extern NSString *const kMapCoordTypeWGS84;

@interface ZJGpsUtils : NSObject
singleton_h()

/// 坐标是否在国内
/// @param latitude 纬度
/// @param longitude 精度
- (BOOL)isInsideChina:(double)latitude longitude:(double)longitude;

/// 清除检测状态
- (void)clearCheckStatus;

/// 关闭状态检测
- (void)closeCheckStatus;

#pragma mark -

/// 坐标是否在国外
/// @param lat 经度
/// @param lon 纬度
+ (BOOL)outOfChina:(double)lat lon:(double)lon;

/// 2点距离
/// @param latLngA 坐标A
/// @param latLngB 坐标B
+ (CGFloat)distance:(CLLocationCoordinate2D)latLngA latLngB:(CLLocationCoordinate2D)latLngB;

/// WGS84 => BD09   地球坐标系 => 百度坐标系
/// @param latLng 待转换坐标
+ (CLLocationCoordinate2D)wgs84_To_BD09ll:(CLLocationCoordinate2D)latLng;

/// WGS84 => GCJ02   地球坐标系 => 火星坐标系
/// @param latLng 待转换坐标
+ (CLLocationCoordinate2D)wgs84_To_GCJ02:(CLLocationCoordinate2D)latLng;

/// GCJ-02 => BD09ll   火星坐标系 => 百度坐标系
/// @param latLng 待转换坐标
+ (CLLocationCoordinate2D)gcj02_To_BD09ll:(CLLocationCoordinate2D)latLng;

/// GCJ02 => WGS84   火星坐标系 => 地球坐标系(粗略)
/// @param latLng 待转换坐标
+ (CLLocationCoordinate2D)gcj02_To_WGS84:(CLLocationCoordinate2D)latLng;

/// BD09ll => WGS84   百度坐标系 => 地球坐标系
/// @param latLng 待转换坐标
+ (CLLocationCoordinate2D)bd09ll_To_WGS84:(CLLocationCoordinate2D)latLng;

/// BD09ll => GCJ-02 百度坐标系 => 火星坐标系
/// @param latLng 待转换坐标
+ (CLLocationCoordinate2D)bd09ll_To_GCJ02:(CLLocationCoordinate2D)latLng;

/// GCJ02 => WGS84   火星坐标系 => 地球坐标系（精确）
/// @param latLng 待转换坐标
+ (CLLocationCoordinate2D)gcj02_To_WGS84_Exactly:(CLLocationCoordinate2D)latLng;

@end

NS_ASSUME_NONNULL_END
