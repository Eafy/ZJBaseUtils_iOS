//
//  UIImage+ZJExt.m
//  ZJBaseUtils
//
//  Created by eafy on 2020/8/18.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import "UIImage+ZJExt.h"
#import "NSFileManager+ZJExt.h"

@implementation UIImage (ZJExt)

- (UIColor *)zj_colorAtPixel:(CGPoint)point
{
    if (!CGRectContainsPoint(CGRectMake(0.0f, 0.0f, self.size.width, self.size.height), point)) {
        return nil;
    }
    
    NSInteger pointX = trunc(point.x);
    NSInteger pointY = trunc(point.y);
    CGImageRef cgImage = self.CGImage;
    NSUInteger width = self.size.width;
    NSUInteger height = self.size.height;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    int bytesPerPixel = 4;
    int bytesPerRow = bytesPerPixel * 1;
    NSUInteger bitsPerComponent = 8;
    unsigned char pixelData[4] = { 0, 0, 0, 0 };
    CGContextRef context = CGBitmapContextCreate(pixelData,
                                                 1,
                                                 1,
                                                 bitsPerComponent,
                                                 bytesPerRow,
                                                 colorSpace,
                                                 kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    CGColorSpaceRelease(colorSpace);
    CGContextSetBlendMode(context, kCGBlendModeCopy);
    
    // Draw the pixel we are interested in onto the bitmap context
    CGContextTranslateCTM(context, -pointX, pointY-(CGFloat)height);
    CGContextDrawImage(context, CGRectMake(0.0f, 0.0f, (CGFloat)width, (CGFloat)height), cgImage);
    CGContextRelease(context);
    
    // Convert color values [0..255] to floats [0.0..1.0]
    CGFloat red   = (CGFloat)pixelData[0] / 255.0f;
    CGFloat green = (CGFloat)pixelData[1] / 255.0f;
    CGFloat blue  = (CGFloat)pixelData[2] / 255.0f;
    CGFloat alpha = (CGFloat)pixelData[3] / 255.0f;
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

- (NSString *)zj_saveToDocumentsWithName:(NSString *)picName dirName:(NSString *)dirName
{
    if (!self || !picName || picName.length == 0) return nil;
    
    NSString *imgName = nil;
    NSString *filePath = nil;
    NSString *documentsPath = [NSFileManager zj_documentsPath];
    if (self) {
        if (picName.length>4 && [[picName substringWithRange:NSMakeRange(picName.length-4, 4)] isEqualToString:@".jpg"]) {
            imgName = [NSString stringWithFormat:@"%@", picName];
        } else {
            imgName = [NSString stringWithFormat:@"%@.jpg", picName];
        }
        
        if (dirName && dirName.length > 0) {
            if ([dirName characterAtIndex:0] != '/') {
                dirName = [NSString stringWithFormat:@"/%@", dirName];
            }
            
            if ([dirName characterAtIndex:(dirName.length - 1)] != '/') {
                dirName = [NSString stringWithFormat:@"%@/", dirName];
            }
            
            
            NSString *dirPath = [documentsPath stringByAppendingString:dirName];
            if (![[NSFileManager defaultManager] fileExistsAtPath:dirPath]) {
                [[NSFileManager defaultManager] createDirectoryAtPath:dirPath withIntermediateDirectories:YES attributes:nil error:nil];
            }
            
            filePath = [NSString stringWithFormat:@"%@%@", dirPath, imgName];
            if ([self zj_saveWithPath:filePath]) {
                return filePath;
            }
        } else {
            filePath = [documentsPath stringByAppendingPathComponent:imgName];

            if ([self zj_saveWithPath:filePath]) {
                return filePath;
            }
        }
    }
    
    return nil;
}

- (BOOL)zj_saveWithPath:(NSString *)filePath
{
    if (self) {
        NSData *imgData = UIImageJPEGRepresentation(self, 1.0f);
        if (imgData.length != 0) {
            return [imgData writeToFile:filePath atomically:YES];
        }
    }
    
    return NO;
}

- (UIImage *)zj_imageWithColor:(UIColor *)color
{
    if (!self) return nil;
    
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0, self.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextClipToMask(context, rect, self.CGImage);
    [color setFill];
    CGContextFillRect(context, rect);
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (UIImage *)zj_imageWithMinR:(CGFloat)minR maxR:(CGFloat)maxR minG:(CGFloat)minG maxG:(CGFloat)maxG minB:(CGFloat)minB maxB:(CGFloat)maxB {
    const CGFloat maskingColors[6] = {minR, maxR, minG, maxG, minB, maxB};
    CGImageRef ref = CGImageCreateWithMaskingColors(self.CGImage, maskingColors);
    return [UIImage imageWithCGImage:ref];
}

- (UIImage *)zj_scaleToSize:(CGSize)size
{
    if (!self) return nil;
    return [UIImage zj_scaleWithCIImage:self.CIImage size:size];
}

- (UIImage*)zj_subImageWithRect:(CGRect)mCGRect
{
    if (!self) return nil;
    /*如若centerBool为Yes则是由中心点取mCGRect范围的图片*/
    float imgwidth = self.size.width;
    float imgheight = self.size.height;
    float viewwidth = mCGRect.size.width;
    float viewheight = mCGRect.size.height;
    CGRect rect;
    if (viewheight < viewwidth) {
        if (imgwidth <= imgheight) {
            rect = CGRectMake(0, 0, imgwidth, imgwidth*viewheight/viewwidth);
        } else {
            float width = viewwidth*imgheight/viewheight;
            float x = (imgwidth - width)/2 ;
            if (x > 0) {
                rect = CGRectMake(x, 0, width, imgheight);
            }else {
                rect = CGRectMake(0, 0, imgwidth, imgwidth*viewheight/viewwidth);
            }
        }
    } else {
        if (imgwidth <= imgheight) {
            float height = viewheight*imgwidth/viewwidth;
            if (height < imgheight) {
                rect = CGRectMake(0, 0, imgwidth, height);
            }else {
                rect = CGRectMake(0, 0, viewwidth*imgheight/viewheight, imgheight);
            }
        } else {
            float width = viewwidth*imgheight/viewheight;
            if (width < imgwidth) {
                float x = (imgwidth - width)/2 ;
                rect = CGRectMake(x, 0, width, imgheight);
            }else {
                rect = CGRectMake(0, 0, imgwidth, imgheight);
            }
        }
    }
    
    CGImageRef subImageRef = CGImageCreateWithImageInRect(self.CGImage, rect);
    CGRect smallBounds = CGRectMake(0, 0, CGImageGetWidth(subImageRef), CGImageGetHeight(subImageRef));
    
    UIGraphicsBeginImageContext(smallBounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, smallBounds, subImageRef);
    UIImage* smallImage = [UIImage imageWithCGImage:subImageRef];
    UIGraphicsEndImageContext();
    
    return smallImage;
}

- (UIImage*)zj_rotate:(UIImageOrientation)orient
{
    CGRect bnds = CGRectZero;
    UIImage* copy = nil;
    CGContextRef ctxt = nil;
    CGImageRef imag = self.CGImage;
    CGRect rect = CGRectZero;
    CGAffineTransform tran = CGAffineTransformIdentity;
    
    rect.size.width = CGImageGetWidth(imag);
    rect.size.height = CGImageGetHeight(imag);
    
    bnds = rect;
    
    switch (orient) {
        case UIImageOrientationUp:
            return self;
            
        case UIImageOrientationUpMirrored:
            tran = CGAffineTransformMakeTranslation(rect.size.width, 0.0);
            tran = CGAffineTransformScale(tran, -1.0, 1.0);
            break;
            
        case UIImageOrientationDown:
            tran = CGAffineTransformMakeTranslation(rect.size.width,
                                                    rect.size.height);
            tran = CGAffineTransformRotate(tran, M_PI);
            break;
            
        case UIImageOrientationDownMirrored:
            tran = CGAffineTransformMakeTranslation(0.0, rect.size.height);
            tran = CGAffineTransformScale(tran, 1.0, -1.0);
            break;
            
        case UIImageOrientationLeft:
        {
            CGFloat swap = bnds.size.width;
            bnds.size.width = bnds.size.height;
            bnds.size.height = swap;
            tran = CGAffineTransformMakeTranslation(0.0, rect.size.width);
            tran = CGAffineTransformRotate(tran, 3.0 * M_PI / 2.0);
        }
            break;
            
        case UIImageOrientationLeftMirrored:
        {
            CGFloat swap = bnds.size.width;
            bnds.size.width = bnds.size.height;
            bnds.size.height = swap;
            tran = CGAffineTransformMakeTranslation(rect.size.height,
                                                    rect.size.width);
            tran = CGAffineTransformScale(tran, -1.0, 1.0);
            tran = CGAffineTransformRotate(tran, 3.0 * M_PI / 2.0);
        }
            break;
            
        case UIImageOrientationRight:
        {
            CGFloat swap = bnds.size.width;
            bnds.size.width = bnds.size.height;
            bnds.size.height = swap;
            tran = CGAffineTransformMakeTranslation(rect.size.height, 0.0);
            tran = CGAffineTransformRotate(tran, M_PI / 2.0);
        }
            break;
            
        case UIImageOrientationRightMirrored:
        {
            CGFloat swap = bnds.size.width;
            bnds.size.width = bnds.size.height;
            bnds.size.height = swap;
            tran = CGAffineTransformMakeScale(-1.0, 1.0);
            tran = CGAffineTransformRotate(tran, M_PI / 2.0);
        }
            break;
            
        default:
            return self;
    }
    
    UIGraphicsBeginImageContext(bnds.size);
    ctxt = UIGraphicsGetCurrentContext();
    
    switch (orient) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            CGContextScaleCTM(ctxt, -1.0, 1.0);
            CGContextTranslateCTM(ctxt, -rect.size.height, 0.0);
            break;
            
        default:
            CGContextScaleCTM(ctxt, 1.0, -1.0);
            CGContextTranslateCTM(ctxt, 0.0, -rect.size.height);
            break;
    }
    
    CGContextConcatCTM(ctxt, tran);
    CGContextDrawImage(UIGraphicsGetCurrentContext(), rect, imag);
    
    copy = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return copy;
}

- (UIImage *)zj_rotateVertical
{
    return [self zj_rotate:UIImageOrientationDownMirrored];
}

- (UIImage *)zj_rotateHorizontal
{
    return [self zj_rotate:UIImageOrientationUpMirrored];
}

- (UIImage *)zj_rotatedByRadians:(CGFloat)radians
{
    UIView *rotatedViewBox = [[UIView alloc] initWithFrame:CGRectMake(0,0,self.size.width, self.size.height)];
    CGAffineTransform t = CGAffineTransformMakeRotation(radians);
    rotatedViewBox.transform = t;
    CGSize rotatedSize = rotatedViewBox.frame.size;
    
    UIGraphicsBeginImageContext(rotatedSize);
    CGContextRef bitmap = UIGraphicsGetCurrentContext();
    
    CGContextTranslateCTM(bitmap, rotatedSize.width/2, rotatedSize.height/2);
    
    CGContextRotateCTM(bitmap, radians);
    
    CGContextScaleCTM(bitmap, 1.0, -1.0);
    CGContextDrawImage(bitmap, CGRectMake(-self.size.width / 2, -self.size.height / 2, self.size.width, self.size.height), [self CGImage]);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (UIImage *)zj_rotatedByDegrees:(CGFloat)degrees
{
    return [self zj_rotatedByRadians:(M_PI * (degrees) / 180.0)];
}

#pragma mark - StaticAPI

+ (UIImage *)zj_scaleWithCIImage:(CIImage *)image size:(CGSize)size
{
    if (!image) return nil;
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size.width/CGRectGetWidth(extent), size.height/CGRectGetHeight(extent));

    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);

    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}

+ (UIImage *)zj_imageWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIImage *)zj_imageWithColor:(UIColor *)color
{
    return [self zj_imageWithColor:color size:CGSizeMake(1.0, 1.0)];
}

+ (UIImage *)zj_imageWithRGB:(char *)rgbBuff width:(NSInteger)width height:(NSInteger)height
{
    CGDataProviderRef provider = CGDataProviderCreateWithData(NULL, rgbBuff, width * height * 3, NULL);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGImageRef imgRef = CGImageCreate(width, height, 8, 24, width * 3, colorSpace, kCGBitmapByteOrderDefault, provider, NULL, true,  kCGRenderingIntentDefault);
    UIImage *img = [UIImage imageWithCGImage:imgRef];
    
    if (imgRef != nil) {
        CGImageRelease(imgRef);
        imgRef = nil;
    }
    
    if (colorSpace != nil) {
        CGColorSpaceRelease(colorSpace);
        colorSpace = nil;
    }
    
    if (provider != nil) {
        CGDataProviderRelease(provider);
        provider = nil;
    }
    
    return [img copy];
}

@end
