//
//  UIButton+ZJGradient.h
//  ZJBaseUtils
//
//  Created by eafy on 2020/11/17.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ZJBaseUtils/UIImage+ZJGradient.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (ZJGradient)

/// 设置按钮的渐变颜色背景
/// @param size 按钮大小
/// @param colors 渐变颜色的数组
/// @param percents 渐变颜色的占比数组
/// @param type 渐变色的方向
- (void)zj_gradientWithSize:(CGSize)size colors:(NSArray<UIColor *> *_Nonnull)colors percents:(NSArray *_Nonnull)percents type:(ZJIMGGradientType)type;

/// 设置按钮的渐变颜色背景
/// @param type 渐变色的方向
/// @param colors 渐变颜色的占比数组
/// @param percents 渐变色的方向
- (void)zj_gradientWithType:(ZJIMGGradientType)type colors:(NSArray<UIColor *> *_Nonnull)colors percents:(NSArray *_Nonnull)percents;

@end

NS_ASSUME_NONNULL_END
