//
//  ZJBaseTVConfig.m
//  ZJBaseUtils
//
//  Created by eafy on 2020/9/14.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import "ZJBaseTVConfig.h"
#import "UIColor+ZJExt.h"

@interface ZJBaseTVConfig ()

@end

@implementation ZJBaseTVConfig

- (instancetype)init
{
    if (self = [super init]) {
        
        _rowHeight = 56.0f;
        
        _cellTitleColor = ZJColorFromHex(@"#181E28");
        _cellSubTitleColor = ZJColorFromHex(@"#8690A9");
        _cellDetailTitleColor = ZJColorFromHex(@"#5A6482");
        
        _cellTitleFont = [UIFont systemFontOfSize:16.0f];
        _cellSubTitleFont = [UIFont systemFontOfSize:12.0f];
        _cellDetailTitleFont = [UIFont systemFontOfSize:13.0f];
        
        _marginLeft = 15.f;
        _marginRight = 10.f;
        _arrowLeftSpace = 5.f;
        _iconLeftSpace = 0;
        _iconRightSpace = 5.f;
        _arrowLeftSpace = 5.f;
        _arrowRightSpace = 5.f;
        
        _lineHeight = .5f;
    }
    
    return self;
}

@end
