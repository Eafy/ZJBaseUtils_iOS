//
//  ZJBaseTVPrivateData.m
//  ZJBaseUtils
//
//  Created by eafy on 2020/11/11.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import "ZJBaseTVPrivateData.h"

@implementation ZJBaseTVPrivateData

- (ZJBaseTVConfig *)config
{
    if (!_config) {
        _config = [[ZJBaseTVConfig alloc] init];
    }
    return _config;
}

@end
