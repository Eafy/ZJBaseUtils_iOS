//
//  ZJPickerItem.m
//  ZJBaseUtils
//
//  Created by eafy on 2020/11/23.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import <ZJBaseUtils/ZJPickerItem.h>

@implementation ZJPickerItem

- (NSMutableArray<NSString *> *)titleArray
{
    if (!_titleArray) {
        _titleArray = [NSMutableArray array];
    }
    return _titleArray;
}

@end
