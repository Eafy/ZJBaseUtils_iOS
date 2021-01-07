//
//  UIImage+ZJQR.m
//  ZJBaseUtils
//
//  Created by eafy on 2020/11/19.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import "UIImage+ZJQR.h"
#import "UIImage+ZJExt.h"

@implementation UIImage (ZJQR)

+ (UIImage *)imageWithQRCodeString:(NSString *)qrString
{
    // 1.实例化二维码滤镜
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    // 2.恢复滤镜的默认属性 (因为滤镜有可能保存上一次的属性)
    [filter setDefaults];
    // 3.将字符串转换成NSdata
    NSData *data = [qrString dataUsingEncoding:NSUTF8StringEncoding];
    // 4.通过KVO设置滤镜, 传入data, 将来滤镜就知道要通过传入的数据生成二维码
    [filter setValue:data forKey:@"inputMessage"];
    // 5.生成二维码
    CIImage *outputImage = [filter outputImage];

    return [UIImage zj_scaleWithCIImage:outputImage size:CGSizeMake(512, 512)];
}

+ (UIImage *)imageWithQRCodeString:(NSString *)qrString color:(UIColor *)color
{
    UIImage *img = [self imageWithQRCodeString:qrString];
    img = [img zj_imageWithMinR:254 maxR:255 minG:254 maxG:255 minB:254 maxB:255];
    img = [img zj_imageWithColor:color];
    
    return img;
}

@end
