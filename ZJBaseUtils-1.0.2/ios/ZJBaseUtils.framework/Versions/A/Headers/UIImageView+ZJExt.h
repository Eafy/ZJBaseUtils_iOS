//
//  UIImageView+ZJExt.h
//  ZJBaseUtils
//
//  Created by eafy on 2020/9/14.
//  Copyright © 2020 ZJ<lizhijian_21@163.com>. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (ZJExt)

/// 将图片缩放之后在主View的point位置为准显示
/// @param imageName 图片名称
/// @param point 中心基准点
/// @param scale 缩放比例
+ (UIImageView *)zj_imageWithName:(NSString *)imageName center:(CGPoint)point scale:(CGFloat)scale;

/// 将图片缩放之后在主View的point位置为准显示
/// @param imageName 图片名称
/// @param point 左中心基准点
/// @param scale 缩放比例
+ (UIImageView *)zj_imageWithName:(NSString *)imageName leftCenterPoint:(CGPoint)point scale:(CGFloat)scale;

/// 将图片缩放之后在主View的point位置为准显示
/// @param imageName 图片名称
/// @param point 右中心基准点
/// @param scale 缩放比例
+ (UIImageView *)zj_imageWithName:(NSString *)imageName rightCenterPoint:(CGPoint)point scale:(CGFloat)scale;

/// 将图片缩放之后在主View的point位置为准显示
/// @param imageName 图片名称
/// @param point 顶部中心基准点
/// @param scale 缩放比例
+ (UIImageView *)zj_imageWithName:(NSString *)imageName topCenterPoint:(CGPoint)point scale:(CGFloat)scale;

/// 将图片缩放之后在主View的point位置为准显示
/// @param imageName 图片名称
/// @param point 底部中心基准点
/// @param scale 缩放比例
+ (UIImageView *)zj_imageWithName:(NSString *)imageName bottomCenterPoint:(CGPoint)point scale:(CGFloat)scale;

/// 将图片缩放之后在主View的point位置为准显示
/// @param imageName 图片名称
/// @param point 顶部左边基准点
/// @param scale 缩放比例
+ (UIImageView *)zj_imageWithName:(NSString *)imageName topLeftPoint:(CGPoint)point scale:(CGFloat)scale;

/// 将图片缩放之后在主View的point位置为准显示
/// @param imageName 图片名称
/// @param point 底部左边基准点
/// @param scale 缩放比例
+ (UIImageView *)zj_imageWithName:(NSString *)imageName bottomLeftPoint:(CGPoint)point scale:(CGFloat)scale;

/// 将图片缩放之后在主View的point位置为准显示
/// @param imageName 图片名称
/// @param point 顶部右边基准点
/// @param scale 缩放比例
+ (UIImageView *)zj_imageWithName:(NSString *)imageName topRightPoint:(CGPoint)point scale:(CGFloat)scale;

#pragma mark -

/// 添加自动旋转动画
- (CABasicAnimation *)zj_addLoopRotateAnimation;

/// 删除自动旋转动画
- (void)zj_removeLoopRotateAnimation;

@end

NS_ASSUME_NONNULL_END
