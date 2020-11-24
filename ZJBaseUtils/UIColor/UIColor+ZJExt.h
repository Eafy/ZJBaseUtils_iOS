//
//  UIColor+ZJExt.h
//  ZJBaseUtils
//
//  Created by eafy on 2020/8/16.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIColor.h>

NS_ASSUME_NONNULL_BEGIN

/// RGB单独数值转Color
/// @param r r数值（0~255）
/// @param g g数值（0~255）
/// @param b g数值（0~255）
extern UIColor *ZJColor(NSInteger r, NSInteger g, NSInteger b);
/// RGBA单独数值转Color
/// @param r r数值（0~255）
/// @param g g数值（0~255）
/// @param b b数值（0~255）
/// @param a a数值（0~1.0）
extern UIColor *ZJColorWithAlpha(NSInteger r, NSInteger g, NSInteger b, CGFloat a);
/// RGB整形数值转Color
/// @param rgb rgb数值
extern UIColor *ZJColorFromRGB(NSInteger rgb);
/// RGB整形数带透明度值转Color
/// @param rgb rgb数值
/// @param alpha 透明度（0~1.0）
extern UIColor *ZJColorFromRrgWithAlpha(NSInteger rgb, CGFloat alpha);
/// HEX或HEXA转换为RGB颜色
/// @param str HEX或HEXA字符串
extern UIColor *ZJColorFromHex(NSString *str);
/// AHEX或HEX转换为RGB颜色
/// @param str AHEX或HEX字符串
extern UIColor *ZJColorFromAHex(NSString *str);
/// 产生随机颜色值
extern UIColor *ZJColorRandom(void);

@interface UIColor (ZJExt)

/// 将Hex或HexA字符串类型颜色转换成UIColor
/// @param hexString Hex或HexA字符串颜色，支持：0xFFFFFF、#FFFFFF、FFFFFF，注意，当为8位时后2位表示透明度
+ (UIColor *)zj_colorWithHexString:(NSString *)hexString;

/// 将AHex字符串类型颜色转换成UIColor
/// @param hexString AHex字符串颜色，支持：0xFFFFFF、#FFFFFF、FFFFFF，注意，当为8位时前2位表示透明度
+ (UIColor *)zj_colorWithAHexString:(NSString *)hexString;

/// 将整形RGB数据转换成UIColor
/// @param r 整形R
/// @param g  整形G
/// @param b  整形B
+ (UIColor *)zj_color:(NSInteger)r g:(NSInteger)g b:(NSInteger)b;
+ (UIColor *)zj_color:(NSInteger)r g:(NSInteger)g b:(NSInteger)b a:(CGFloat)a;
+ (UIColor *)zj_color:(NSInteger)rgb;
+ (UIColor *)zj_color:(NSInteger)rgb a:(CGFloat)a;
+ (UIColor *)zj_colorRandom;

#pragma mark - 

/// 将颜色值转为整型
- (NSInteger)zj_toHexNumber;

/// 将颜色按照给出的程度加深或淡化
/// @param intensity 颜色强度
- (UIColor *)zj_colorWithIntensity:(CGFloat)intensity;


@end

NS_ASSUME_NONNULL_END
