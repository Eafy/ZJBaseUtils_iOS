//
//  UIImage+JMExt.h
//  JMBaseUtils
//
//  Created by lzj<lizhijian_21@163.com> on 2020/8/18.
//  Copyright © 2020 Jimi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (JMExt)

/// 取图片某点的颜色
/// @param point 要取的点
- (UIColor *)jm_colorAtPixel:(CGPoint)point;

/// 保存图片到沙盒Documents目录下
/// @param picName 图片名称
/// @param dirName 文件夹名称
- (NSString *)jm_saveToDocumentsWithName:(NSString *)picName dirName:(NSString *)dirName;

/// 保存图片到路径下
/// @param filePath 保存路径
- (BOOL)jm_saveWithPath:(NSString *)filePath;

/// 改变图片颜色
/// @param color 改变的颜色
- (UIImage *)jm_imageWithColor:(UIColor *)color;

/// 缩放图片
/// @param size 要缩放的尺寸
- (UIImage *)jm_scaleToSize:(CGSize)size;

/// 截图部分图像
/// @param mCGRect 截取的范围
- (UIImage*)jm_subImageWithRect:(CGRect)mCGRect;

/// 按给定的方向旋转图片
/// @param orient 要翻转的方向
- (UIImage*)jm_rotate:(UIImageOrientation)orient;

/// 垂直翻转
- (UIImage *)jm_rotateVertical;

/// 水平翻转
- (UIImage *)jm_rotateHorizontal;

/// 将图片旋转弧度radians
/// @param radians 要翻转的弧度
- (UIImage *)jm_rotatedByRadians:(CGFloat)radians;

/// 将图片旋转角度degrees
/// @param degrees 要翻转的角度
- (UIImage *)jm_rotatedByDegrees:(CGFloat)degrees;

#pragma mark - StaticAPI

/// 根据颜色返回指定大小的图片
/// @param color 图片颜色
/// @param size 图片大小
+ (UIImage *)jm_imageWithColor:(UIColor *)color size:(CGSize)size;

/// 根据颜色返回图片（1像素）
/// @param color 图片颜色
+ (UIImage *)jm_imageWithColor:(UIColor *)color;

/// 根据rgb数据获取图片
/// @param rgbBuff 图片Buffer
/// @param width 图片的宽
/// @param height 图片的高
+ (UIImage *)jm_imageWithRGB:(char *)rgbBuff width:(NSInteger)width height:(NSInteger)height;

@end

NS_ASSUME_NONNULL_END
