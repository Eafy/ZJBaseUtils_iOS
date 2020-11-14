//
//  ZJBaseTarbarItem.m
//  ZJBaseUtils
//
//  Created by eafy on 2020/11/14.
//

#import "ZJBaseTarbarItem.h"
#import "UIColor+ZJExt.h"

@implementation ZJBaseTarbarItem

 - (instancetype)init
{
    if (self = [super init]) {
        _norTitleColor = [UIColor zj_colorWithHexString:@"#808080"];
        _selTitleColor = [UIColor zj_colorWithHexString:@"#d81e06"];
        _imageSize = CGSizeMake(28, 28);
        _titleFont = 12.f;
        _titleOffset = 2.f;
        _imageOffset = 2.f;
    }
    return self;
}

@end
