//
//  UIImage+ZJExt.h
//  ZJBaseUtils
//
//  Created by eafy on 2020/8/18.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (ZJExt)

/// 取图片某点的颜色
/// @param point 要取的点
- (UIColor *)zj_colorAtPixel:(CGPoint)point;

/// 保存图片到沙盒Documents目录下
/// @param picName 图片名称
/// @param dirName 文件夹名称
- (NSString *)zj_saveToDocumentsWithName:(NSString *)picName dirName:(NSString *)dirName;

/// 保存图片到路径下
/// @param filePath 保存路径
- (BOOL)zj_saveWithPath:(NSString *)filePath;

/// 改变图片颜色（非透明的都会改变）
/// @param color 改变的颜色
- (UIImage *)zj_imageWithColor:(UIColor *)color;

/// 改变图片颜色
/// @param minR 最小范围R值
/// @param maxR 最大范围R值
/// @param minG 最小范围G值
/// @param maxG 最大范围G值
/// @param minB 最小范围B值
/// @param maxB 最大范围B值
- (UIImage *)zj_imageWithMinR:(CGFloat)minR maxR:(CGFloat)maxR minG:(CGFloat)minG maxG:(CGFloat)maxG minB:(CGFloat)minB maxB:(CGFloat)maxB;

/// 缩放图片
/// @param size 要缩放的尺寸
- (UIImage *)zj_scaleToSize:(CGSize)size;

/// 截图部分图像
/// @param mCGRect 截取的范围
- (UIImage *)zj_subImageWithRect:(CGRect)mCGRect;

/// 按给定的方向旋转图片
/// @param orient 要翻转的方向
- (UIImage *)zj_rotate:(UIImageOrientation)orient;

/// 垂直翻转
- (UIImage *)zj_rotateVertical;

/// 水平翻转
- (UIImage *)zj_rotateHorizontal;

/// 将图片旋转弧度radians
/// @param radians 要翻转的弧度
- (UIImage *)zj_rotatedByRadians:(CGFloat)radians;

/// 将图片旋转角度degrees
/// @param degrees 要翻转的角度
- (UIImage *)zj_rotatedByDegrees:(CGFloat)degrees;

#pragma mark - StaticAPI

/// 根据CIImage缩放获取图片
/// @param image CIImage
/// @param size 缩放大小
+ (UIImage *)zj_scaleWithCIImage:(CIImage *)image size:(CGSize)size;

/// 根据颜色返回指定大小的图片
/// @param color 图片颜色
/// @param size 图片大小
+ (UIImage *)zj_imageWithColor:(UIColor *)color size:(CGSize)size;

/// 根据颜色返回图片（1像素）
/// @param color 图片颜色
+ (UIImage *)zj_imageWithColor:(UIColor *)color;

/// 根据rgb数据获取图片
/// @param rgbBuff 图片Buffer
/// @param width 图片的宽
/// @param height 图片的高
+ (UIImage *)zj_imageWithRGB:(char *)rgbBuff width:(NSInteger)width height:(NSInteger)height;

@end

NS_ASSUME_NONNULL_END
