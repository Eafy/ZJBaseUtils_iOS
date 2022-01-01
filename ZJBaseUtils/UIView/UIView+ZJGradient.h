//
//  UIView+ZJGradient.h
//  ZJBaseUtils
//
//  Created by eafy on 2020/11/29.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, ZJGradientType) {
    ZJGradientTypeFromTopToBottom,            //从上到下
    ZJGradientTypeFromLeftToRight,                //从左到右
    ZJGradientTypeFromLeftTopToRightBottom,       //从左上到右下
    ZJGradientTypeFromLeftBottomToRightTop        //从左下到右上
};

@interface UIView (ZJGradient)

/// 颜色渐变
/// @param colors 渐变颜色的数组
/// @param percents 渐变颜色的占比数组
/// @param opacity 透明度
/// @param type 渐变色的方向
- (void)zj_gradientWithColors:(NSArray<UIColor *> *_Nonnull)colors percents:(NSArray<NSNumber *> *_Nonnull)percents opacity:(CGFloat)opacity type:(ZJGradientType)type;

/// 颜色渐变
/// @param colors 渐变颜色的数组
/// @param percents 渐变颜色的占比数组
/// @param opacity 透明度
/// @param startPoint 渐变起点
/// @param endPoint 渐变终点
- (void)zj_gradientWithColors:(NSArray<UIColor *> *_Nonnull)colors percents:(NSArray<NSNumber *> *_Nonnull)percents opacity:(CGFloat)opacity startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint;

@end

NS_ASSUME_NONNULL_END
