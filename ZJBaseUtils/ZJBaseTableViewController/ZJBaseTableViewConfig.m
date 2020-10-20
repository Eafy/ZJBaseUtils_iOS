//
//  ZJBaseTableViewConfig.m
//  ZJBaseUtils
//
//  Created by eafy on 2020/9/14.
//  Copyright © 2020 ZJ<lizhijian_21@163.com>. All rights reserved.
//

#import "ZJBaseTableViewConfig.h"
#import "UIColor+ZJExt.h"

@interface ZJBaseTableViewConfig ()

@end

@implementation ZJBaseTableViewConfig

- (instancetype)init
{
    if (self = [super init]) {
         _cellTitleColor = ZJColorFromHex(@"#181E28");
        _cellSubTitleColor = ZJColorFromHex(@"#8690A9");
        _cellDetailTitleColor = ZJColorFromHex(@"#5A6482");
        
        _cellTitleFont = [UIFont systemFontOfSize:16.0f];
        _cellSubTitleFont = [UIFont systemFontOfSize:12.0f];
        _cellDetailTitleFont = [UIFont systemFontOfSize:13.0f];
    }
    
    return self;
}

@end