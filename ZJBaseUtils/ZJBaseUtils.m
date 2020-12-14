//
//  ZJBaseUtil.m
//  ZJBaseUtils
//
//  Created by eafy on 2020/11/23.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import "ZJBaseUtils.h"

/// 保存默认的资源包路径
static NSString *_defaultBundleImagePath = nil;

@implementation ZJBaseUtils

/// 获取pod方式下的资源包路径
/// @param bundleName 资源包名称
+ (NSBundle *)bundleWithBundleName:(NSString *)bundleName {
    
    NSURL *associateBundleURL = nil;
    if (bundleName) {
        if ([bundleName containsString:@".bundle"]) {
            bundleName = [bundleName componentsSeparatedByString:@".bundle"].firstObject;
        }
        
        associateBundleURL = [[NSBundle mainBundle] URLForResource:bundleName withExtension:@"bundle"];  //没使用framwork的情况下
        
        if (!associateBundleURL) {  //使用framework形式
            associateBundleURL = [[NSBundle mainBundle] URLForResource:@"Frameworks" withExtension:nil];
            associateBundleURL = [associateBundleURL URLByAppendingPathComponent:bundleName];
            associateBundleURL = [associateBundleURL URLByAppendingPathExtension:@"framework"];
            
            if (associateBundleURL) {
                NSBundle *associateBunle = [NSBundle bundleWithURL:associateBundleURL];
                associateBundleURL = [associateBunle URLForResource:bundleName withExtension:@"bundle"];
            }
        }
    }
    
    if (!associateBundleURL) {
        NSLog(@"%@默认资源包bundle为空!", NSStringFromClass([self class]));
        return nil;
    } else {
        return [NSBundle bundleWithURL:associateBundleURL];
    }
}

+ (nullable NSString *)imageNamePath:(NSString * _Nullable)imageName
{
    if (!imageName) return nil;
    
    if (!_defaultBundleImagePath) {
        NSBundle *bundle = [self bundleWithBundleName:NSStringFromClass([self class])];
        if (!bundle) {
            _defaultBundleImagePath = @"";
            return nil;
        }
        _defaultBundleImagePath = bundle.bundlePath;
    } else if (_defaultBundleImagePath.length == 0) {
        return nil;
    }
    
    return [NSString stringWithFormat:@"%@/%@", _defaultBundleImagePath, imageName];
}

+ (nullable UIImage *)imageNamed:(NSString * _Nullable)imageName
{
    if (!imageName) return nil;
    UIImage *img = [UIImage imageNamed:imageName];
    if (img) return img;
    
    NSString *filePath = [self imageNamePath:imageName];
    if (filePath) {
        return [[UIImage alloc] initWithContentsOfFile:filePath];
    }
    return nil;
}

+ (nullable NSString *)imageNamedPathWithBundle:(NSString *)bundleName imageName:(NSString * _Nullable)imageName
{
    if (!imageName) return nil;
    
    NSBundle *bundle = [self bundleWithBundleName:bundleName];
    if (!bundle) {
        return nil;
    } else if (bundle.bundlePath.length == 0) {
        return nil;
    }
    
    return [NSString stringWithFormat:@"%@/%@", bundle.bundlePath, imageName];
}

+ (nullable UIImage *)imageNamedWithBundle:(NSString *)bundleName imageName:(NSString * _Nullable)imageName
{
    NSString *filePath = [self imageNamedPathWithBundle:bundleName imageName:imageName];
    if (filePath) {
        return [[UIImage alloc] initWithContentsOfFile:filePath];
    }
    return nil;
}

@end
