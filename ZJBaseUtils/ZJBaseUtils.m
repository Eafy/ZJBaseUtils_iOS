//
//  ZJBaseUtil.m
//  ZJBaseUtils
//
//  Created by eafy on 2020/11/23.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import "ZJBaseUtils.h"

@implementation ZJBaseUtils

+ (nullable UIImage *)imageNamed:(NSString * _Nullable)imageName
{
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"ZJBaseUtils" ofType:@"bundle"];
    if (!bundlePath) {
        return nil;
    }
    
    NSString *filePath = [NSString stringWithFormat:@"%@/%@", bundlePath, imageName];
    return [[UIImage alloc] initWithContentsOfFile:filePath];
}

@end
