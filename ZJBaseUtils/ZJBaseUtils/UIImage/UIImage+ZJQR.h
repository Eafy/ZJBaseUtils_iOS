//
//  UIImage+ZJQR.h
//  ZJBaseUtils
//
//  Created by eafy on 2020/11/19.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (ZJQR)

/// 生成二维码图片
/// @param qrString 二维码字符串
+ (UIImage *)zj_imageWithQRCodeString:(NSString *)qrString;

/// 生成带颜色的二维码图片
/// @param qrString 二维码字符串
/// @param color 颜色值
+ (UIImage *)zj_imageWithQRCodeString:(NSString *)qrString color:(UIColor *)color;

@end

NS_ASSUME_NONNULL_END
