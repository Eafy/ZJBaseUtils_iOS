//
//  UIImageView+ZJExt.m
//  ZJBaseUtils
//
//  Created by eafy on 2020/9/14.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import <ZJBaseUtils/UIImageView+ZJExt.h>
#import <ZJBaseUtils/UIImage+ZJExt.h>

@implementation UIImageView (ZJExt)

+ (UIImageView *)zj_imageWithName:(NSString *)imageName center:(CGPoint)point scale:(CGFloat)scale
{
    if (scale <= 0) {
        scale = 1.0f;
    }
    UIImage *image = [UIImage imageNamed:imageName];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(point.x-image.size.width*scale/2.0f, point.y-image.size.height*scale/2.0f, image.size.width*scale, image.size.height*scale)];
    imageView.image = image;
    
    return imageView;
}

+ (UIImageView *)zj_imageWithName:(NSString *)imageName leftCenterPoint:(CGPoint)point scale:(CGFloat)scale
{
    if (scale <= 0) {
        scale = 1.0f;
    }
    UIImage *image = [UIImage imageNamed:imageName];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(point.x, point.y-image.size.height*scale/2.0f, image.size.width*scale, image.size.height*scale)];
    imageView.image = image;
    
    return imageView;
}

+ (UIImageView *)zj_imageWithName:(NSString *)imageName rightCenterPoint:(CGPoint)point scale:(CGFloat)scale
{
    if (scale <= 0) {
        scale = 1.0f;
    }
    UIImage *image = [UIImage imageNamed:imageName];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(point.x-image.size.width*scale, point.y-image.size.height*scale/2.0f, image.size.width*scale, image.size.height*scale)];
    imageView.image = image;
    
    return imageView;
}

+ (UIImageView *)zj_imageWithName:(NSString *)imageName topCenterPoint:(CGPoint)point scale:(CGFloat)scale
{
    if (scale <= 0) {
        scale = 1.0f;
    }
    UIImage *image = [UIImage imageNamed:imageName];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(point.x-image.size.width*scale/2.0f, point.y, image.size.width*scale, image.size.height*scale)];
    imageView.image = image;
    
    return imageView;
}

+ (UIImageView *)zj_imageWithName:(NSString *)imageName bottomCenterPoint:(CGPoint)point scale:(CGFloat)scale
{
    if (scale <= 0) {
        scale = 1.0f;
    }
    UIImage *image = [UIImage imageNamed:imageName];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(point.x-image.size.width*scale/2.0f, point.y-image.size.height*scale, image.size.width*scale, image.size.height*scale)];
    imageView.image = image;
    
    return imageView;
}

+ (UIImageView *)zj_imageWithName:(NSString *)imageName topLeftPoint:(CGPoint)point scale:(CGFloat)scale
{
    if (scale <= 0) {
        scale = 1.0f;
    }
    
    UIImage *image = [UIImage imageNamed:imageName];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(point.x, point.y, image.size.width*scale, image.size.height*scale)];
    imageView.image = [image zj_scaleToSize:CGSizeMake(imageView.bounds.size.width, imageView.bounds.size.height)];
    
    return imageView;
}

+ (UIImageView *)zj_imageWithName:(NSString *)imageName bottomLeftPoint:(CGPoint)point scale:(CGFloat)scale
{
    if (scale <= 0) {
        scale = 1.0f;
    }
    
    UIImage *image = [UIImage imageNamed:imageName];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(point.x, point.y-image.size.height*scale, image.size.width*scale, image.size.height*scale)];
    imageView.image = image;
    
    return imageView;
}

+ (UIImageView *)zj_imageWithName:(NSString *)imageName topRightPoint:(CGPoint)point scale:(CGFloat)scale
{
    if (scale <= 0) {
        scale = 1.0f;
    }
    
    UIImage *image = [UIImage imageNamed:imageName];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(point.x-image.size.width*scale, point.y, image.size.width*scale, image.size.height*scale)];
    imageView.image = image;
    
    return imageView;
}

@end
