//
//  UIColor+ZJExt.m
//  ZJBaseUtils
//
//  Created by eafy on 2020/8/16.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import <ZJBaseUtils/UIColor+ZJExt.h>

UIColor *ZJColor(NSInteger r, NSInteger g, NSInteger b) {
    return [UIColor zj_color:r g:g b:b];
}

UIColor *ZJColorWithAlpha(NSInteger r, NSInteger g, NSInteger b, CGFloat a) {
    return [UIColor zj_color:r g:g b:b a:a];
}

UIColor *ZJColorFromRGB(NSInteger rgb) {
    return [UIColor zj_color:rgb];
}

UIColor *ZJColorFromRgbWithAlpha(NSInteger rgb, CGFloat alpha) {
    return [UIColor zj_color:rgb a:alpha];
}

UIColor *ZJColorFromHex(NSString *str) {
    return [UIColor zj_colorWithHexString:str];
}
UIColor *ZJColorFromAHex(NSString *str) {
    return [UIColor zj_colorWithAHexString:str];
}

UIColor *ZJColorRandom() {
    return [UIColor zj_colorRandom];
}

@implementation UIColor (ZJExt)

+ (UIColor *)zj_colorWithHexString:(NSString *)hexString isAHex:(BOOL)isAHex
{
    //去除空格
    NSString *cString = [[hexString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    //把开头截取
    if ([cString hasPrefix:@"0x"]) cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    //6位或8位(带透明度)
    if ([cString length] < 6) {
        return nil;
    }
    //取出透明度、红、绿、蓝
    unsigned int a, r, g, b;
    NSRange range;
    range.location = 0;
    range.length = 2;
    if (cString.length == 8) {
        //r
        range.location = isAHex ? 6 : 0;
        NSString *rString = [cString substringWithRange:range];
        //g
        range.location = 2;
        NSString *gString = [cString substringWithRange:range];
        //b
        range.location = 4;
        NSString *bString = [cString substringWithRange:range];
        //a
        range.location = isAHex ? 0 : 6;
        NSString *aString = [cString substringWithRange:range];

        [[NSScanner scannerWithString:aString] scanHexInt:&a];
        [[NSScanner scannerWithString:rString] scanHexInt:&r];
        [[NSScanner scannerWithString:gString] scanHexInt:&g];
        [[NSScanner scannerWithString:bString] scanHexInt:&b];

        return [UIColor colorWithRed:(r / 255.0f) green:(g / 255.0f) blue:(b / 255.0f) alpha:(a / 255.0f)];
    } else {
        //r
        NSString *rString = [cString substringWithRange:range];
        //g
        range.location = 2;
        NSString *gString = [cString substringWithRange:range];
        //b
        range.location = 4;
        NSString *bString = [cString substringWithRange:range];

        [[NSScanner scannerWithString:rString] scanHexInt:&r];
        [[NSScanner scannerWithString:gString] scanHexInt:&g];
        [[NSScanner scannerWithString:bString] scanHexInt:&b];

        return [UIColor colorWithRed:(r / 255.0f) green:(g / 255.0f) blue:(b / 255.0f) alpha:1.0];
    }
}

+ (UIColor *)zj_colorWithHexString:(NSString *)hexString
{
    return [self zj_colorWithHexString:hexString isAHex:NO];
}

+ (UIColor *)zj_colorWithAHexString:(NSString *)hexString
{
    return [self zj_colorWithHexString:hexString isAHex:YES];
}

+ (UIColor *)zj_color:(NSInteger)r g:(NSInteger)g b:(NSInteger)b {
    return [[UIColor alloc] initWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0];
}

+ (UIColor *)zj_color:(NSInteger)r g:(NSInteger)g b:(NSInteger)b a:(CGFloat)a {
    return [[UIColor alloc] initWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a];
}

+ (UIColor *)zj_color:(NSInteger)rgb {
    return [UIColor colorWithRed:((float)((rgb & 0xFF0000) >> 16))/255.0 green:((float)((rgb & 0xFF00) >> 8))/255.0 blue:((float)(rgb & 0xFF))/255.0 alpha:1.0];
}

+ (UIColor *)zj_color:(NSInteger)rgb a:(CGFloat)a {
    return [UIColor colorWithRed:((float)((rgb & 0xFF0000) >> 16))/255.0 green:((float)((rgb & 0xFF00) >> 8))/255.0 blue:((float)(rgb & 0xFF))/255.0 alpha:a];
}

+ (UIColor *)zj_colorRandom {
    return [self zj_color:arc4random_uniform(256) g:arc4random_uniform(256) b:arc4random_uniform(256)];
}

#pragma mark -

- (NSInteger)zj_toHexNumber
{
    CGFloat r = 0, g = 0, b = 0;
    [self getRed:&r green:&g blue:&b alpha:nil];
    NSString *colorStr = [NSString stringWithFormat:@"%02X%02X%02X",(int)(r*255.0),(int)(g*255.0),(int)(b*255.0)];
    NSScanner* scanner = [NSScanner scannerWithString:colorStr];
    NSNumber *hexNSNumber;
    uint hexValue;
    if ([scanner scanHexInt:&hexValue])
        hexNSNumber = [NSNumber numberWithInt:hexValue];
    return [hexNSNumber integerValue];
}

- (UIColor *)zj_colorWithIntensity:(CGFloat)intensity
{
    CGFloat red, green, blue, alpha;
    if ([self getRed:&red green:&green blue:&blue alpha:&alpha]) {
        red = red * intensity;
        green = green * intensity;
        blue = blue * intensity;
        UIColor *newColor = [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
        return (newColor);
    }
    else
        return (nil);
}

@end
