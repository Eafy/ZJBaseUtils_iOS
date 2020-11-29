//
//  UIView+ZJExt.h
//  ZJBaseUtils
//
//  Created by eafy on 2020/8/18.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (ZJExt)

/// 转成图片
- (UIImage *)zj_toImage;

/// 画虚直线
/// @param sPoint 起始点
/// @param ePoint 终点
/// @param color 虚线颜色
/// @param width 一个虚线的宽
/// @param space 虚线间的空隙大小
- (void)zj_dottedLineWithStartPoint:(CGPoint)sPoint endPoint:(CGPoint)ePoint color:(UIColor *_Nonnull )color width:(CGFloat)width space:(CGFloat)space;

/// 画虚/实线边框（非离屏渲染，需要已layout）
/// @param width 宽度
/// @param cornerRadii 角度大小
/// @param rectCorner 边框
/// @param length 一条实线的长度
/// 
/// @param space 虚线的间距，0时为实线
/// @param strokeColor 线的颜色
- (void)zj_borderWithWidth:(CGFloat)width cornerRadii:(CGSize)cornerRadii rectCorner:(UIRectCorner)rectCorner length:(CGFloat)length space:(CGFloat)space strokeColor:(UIColor * _Nonnull)strokeColor;

/// 画实线边框（离屏）
/// @param width 宽度
/// @param color 颜色
- (void)zj_borderWithWidth:(CGFloat)width color:(UIColor * _Nonnull)color;

#pragma mark - 切圆角

/// 画圆角（非离屏渲染，需要具体的Frame）
/// @param cornerRadii 圆角大小
/// @param corners 哪个角
- (void)zj_cornerWithRadii:(CGSize)cornerRadii rectCorner:(UIRectCorner)corners;

/// 画四个不同的圆角（非离屏渲染，需要已layout）
/// @param topLeftRadius 左上角弧度
/// @param rightUpRadius 右上角弧度
/// @param rightDownRadius 右下角弧度
/// @param leftDownRadius 左下角弧度
- (CAShapeLayer *)zj_cornerWithTopLeftRadius:(CGFloat)topLeftRadius rightUpRadius:(CGFloat)rightUpRadius rightDownRadius:(CGFloat)rightDownRadius leftDownRadius:(CGFloat)leftDownRadius;

/// 画所有圆角（非离屏渲染，需要已layout）
/// @param radius 弧度
- (void)zj_cornerWithRadius:(CGFloat)radius;

#pragma mark - 阴影

- (void)zj_shadowWithOpacity:(float)shadowOpacity shadowRadius:(CGFloat)shadowRadius andCornerRadius:(CGFloat)cornerRadius;

@end

NS_ASSUME_NONNULL_END
