//
//  ZJSettingLabelItem.m
//  ZJBaseUtils
//
//  Created by eafy on 2020/9/14.
//  Copyright © 2020 ZJ<lizhijian_21@163.com>. All rights reserved.
//

#import "ZJSettingLabelItem.h"
#import "UIColor+ZJExt.h"

@implementation ZJSettingLabelItem

- (ZJSettingItemType)type
{
    return ZJSettingItemTypeLabel;
}


- (void)setIsCenterModel:(BOOL)isCenterModel
{
    _isCenterModel = isCenterModel;
    if (_isCenterModel) {
        _titleColor = ZJColorFromRGB(0xF02359);
        _titleFont = [UIFont boldSystemFontOfSize:16.0f];
    }
}

@end
