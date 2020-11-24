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

+ (nullable UIImage *)imageNamed:(NSString * _Nullable)imageName
{
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
    
    NSString *filePath = [NSString stringWithFormat:@"%@/%@", _defaultBundleImagePath, imageName];
    return [[UIImage alloc] initWithContentsOfFile:filePath];
}

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
            
            NSBundle *associateBunle = [NSBundle bundleWithURL:associateBundleURL];
            associateBundleURL = [associateBunle URLForResource:bundleName withExtension:@"bundle"];
        }
    }
    
    if (!associateBundleURL) {
        NSLog(@"%@默认资源包bundle为空!", NSStringFromClass([self class]));
        return nil;
    } else {
        return [NSBundle bundleWithURL:associateBundleURL];
    }
}

@end
