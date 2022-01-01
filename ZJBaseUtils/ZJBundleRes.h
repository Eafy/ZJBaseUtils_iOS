//
//  ZJBundleRes.h
//  ZJBaseUtils
//
//  Created by eafy on 2020/12/18.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZJBundleRes : NSObject

/// 获取资源包
/// @param bundleName 资源包名称
+ (NSBundle *)bundleWithBundleName:(NSString *)bundleName;

/// 获取bundle包内默认路径
/// @param imageName 图片名称
+ (nullable NSString *)imageNamePath:(NSString * _Nullable)imageName;

/// 获取bundle包内默认图片
/// @param imageName 图片名称
+ (nullable UIImage *)imageNamed:(NSString * _Nullable)imageName;

/// 获取bundle包内默认路径
/// @param bundleName bundle名称
/// @param imageName 图片名称
+ (nullable NSString *)imageNamedPathWithBundle:(NSString *)bundleName imageName:(NSString * _Nullable)imageName;

/// 获取bundle包内默认图片
/// @param bundleName bundle名称
/// @param imageName 图片名称
+ (nullable UIImage *)imageNamedWithBundle:(NSString *)bundleName imageName:(NSString * _Nullable)imageName;


@end

NS_ASSUME_NONNULL_END
