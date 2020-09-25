//
//  UIImageView+ZJExt.m
//  ZJBaseUtils
//
//  Created by eafy on 2020/9/14.
//  Copyright © 2020 ZJ<lizhijian_21@163.com>. All rights reserved.
//

#import "UIImageView+ZJExt.h"
#import "UIImage+ZJExt.h"

NSString *const kJMImageView360RotateTransform = @"kZJImageView360RotateTransform";

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

#pragma mark -

- (CABasicAnimation *)zj_addLoopRotateAnimation
{
    CABasicAnimation *animation = [self.layer animationForKey:kJMImageView360RotateTransform];
    if (!animation) {
        animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        animation.toValue = [NSNumber numberWithFloat:M_PI * 2.0];
        animation.duration = 1.0;
        animation.cumulative = YES;
        animation.repeatCount = ULLONG_MAX;
        
//        CGRect imageRrect = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
//        UIGraphicsBeginImageContext(imageRrect.size);
//        [self.image drawInRect:CGRectMake(1, 1, self.frame.size.width-2, self.frame.size.height-2)];
//        self.image = UIGraphicsGetImageFromCurrentImageContext();
//        UIGraphicsEndImageContext();
        [self.layer addAnimation:animation forKey:kJMImageView360RotateTransform];
    }
    
    return animation;
}

- (void)zj_removeLoopRotateAnimation
{
    [self.layer removeAnimationForKey:kJMImageView360RotateTransform];
}

@end
