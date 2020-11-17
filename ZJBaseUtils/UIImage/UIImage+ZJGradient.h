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

@end

NS_ASSUME_NONNULL_END
