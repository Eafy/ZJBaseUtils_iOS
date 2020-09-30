//
//  ZJSettingItem.m
//  ZJBaseUtils
//
//  Created by eafy on 2020/9/14.
//  Copyright © 2020 ZJ<lizhijian_21@163.com>. All rights reserved.
//

#import "ZJSettingItem.h"
#import "ZJSettingTableViewCell.h"
#import "ZJBaseTableViewConfig+ZJExt.h"

@implementation ZJSettingItem

- (instancetype)initWithIcon:(NSString *)icon title:(NSString *)title
{
    if (self = [super init]) {
        _icon = icon;
        _title = title;
    }
    return self;
}

- (instancetype)initWithIcon:(NSString *)icon title:(NSString *)title destClass:(Class)destVc
{
    if (self = [super init]) {
        _icon = icon;
        _title = title;
        _destVC = destVc;
    }
    return self;
}

#pragma mark -

- (void)updateDiffDataWithCell:(ZJSettingTableViewCell *)cell {
}

- (void)layoutDiffSubviewWithCell:(ZJSettingTableViewCell *)cell {
}

- (void)updateDiffCinfigWithCell:(ZJSettingTableViewCell *)cell config:(ZJBaseTableViewConfig *)config {
}

@end
