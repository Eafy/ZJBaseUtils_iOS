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
/// @param w 一个虚线的宽
/// @param s 虚线间的空隙大小
- (void)zj_drawDashLineWithStartPoint:(CGPoint)sPoint endPoint:(CGPoint)ePoint color:(UIColor *)color w:(CGFloat)w s:(CGFloat)s;

/// 画圆角
/// @param cornerRadii 圆角大小
/// @param corners 哪个角
- (void)zj_drawCircularWithCornerRadii:(CGSize)cornerRadii rectCorner:(UIRectCorner)corners;

/// 画虚/实线边框
/// @param width 宽度
/// @param cornerRadii 角度大小
/// @param rectCorner 边框
/// @param length 一条实线的长度
/// @param space 虚线的间距，0时为实线
/// @param strokeColor 线的颜色
- (void)zj_drawBorderWithWidth:(CGFloat)width cornerRadii:(CGSize)cornerRadii rectCorner:(UIRectCorner)rectCorner length:(CGFloat)length space:(CGFloat)space strokeColor:(UIColor *)strokeColor;

@end

NS_ASSUME_NONNULL_END
