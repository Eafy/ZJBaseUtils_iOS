//
//  UIImage+ZJGradient.h
//  ZJBaseUtils
//
//  Created by eafy on 2020/11/17.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, ZJIMGGradientType) {
    ZJIMGGradientTypeFromTopToBottom,            //从上到下
    ZJIMGGradientTypeFromLeftToRight,                //从左到右
    ZJIMGGradientTypeFromLeftTopToRightBottom,       //从左上到右下
    ZJIMGGradientTypeFromLeftBottomToRightTop        //从左下到右上
};

@interface UIImage (ZJGradient)

/// 生成渐变色的图片
/// @param size 要生成的图片的大小
/// @param colors 渐变颜色的数组
/// @param percents 渐变颜色的占比数组
/// @param type 渐变色的方向
+ (UIImage *)zj_gradientWithSize:(CGSize)size colors:(NSArray<UIColor *> *_Nonnull)colors percents:(NSArray *_Nonnull)percents type:(ZJIMGGradientType)type;

/// 生成双环圆形型渐变色图片
/// @param startPoint  起始点圆点
/// @param endPoint 结束圆点
/// @param startRadius 起始弧度
/// @param endRadius 结束弧度
/// @param colors 渐变颜色的数组
/// @param percents 渐变颜色的占比数组
+ (UIImage *)zj_gradientRadialWithStartPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint startRadius:(CGFloat)startRadius endRadius:(CGFloat)endRadius colors:(NSArray *)colors percents:(NSArray *)percents;

/// 生成圆形型渐变色图片
/// @param size 大小
/// @param radius 弧度
/// @param colors 渐变颜色的数组
/// @param percents 渐变颜色的占比数组
+ (UIImage *)zj_gradientRadialWithSize:(CGSize)size radius:(CGFloat)radius colors:(NSArray *)colors percents:(NSArray *)percents;

@end

NS_ASSUME_NONNULL_END
