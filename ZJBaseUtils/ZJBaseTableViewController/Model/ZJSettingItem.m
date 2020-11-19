//
//  ZJSettingItem.m
//  ZJBaseUtils
//
//  Created by eafy on 2020/9/14.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import "ZJSettingItem.h"
#import "ZJSettingTableViewCell.h"
#import "ZJBaseTVConfig.h"

@implementation ZJSettingItem

- (ZJSettingItemType)type
{
    return ZJSettingItemTypeNone;
}

- (instancetype)initWithIcon:(NSString *)icon title:(NSString *)title
{
    if (self = [super init]) {
        _icon = icon;
        _title = title;
        _type = [self type];
    }
    return self;
}

- (instancetype)initWithIcon:(NSString *)icon title:(NSString *)title destClass:(Class)destVc
{
    if (self = [super init]) {
        _icon = icon;
        _title = title;
        _destVC = destVc;
        _type = [self type];
    }
    return self;
}

- (void)dealloc
{
    if (_accessoryView) {
        [self.accessoryView removeFromSuperview];
        _accessoryView = nil;
    }
    if (_customView) {
        [self.customView removeFromSuperview];
        _customView = nil;
    }
    _privateData = nil;
    _operationHandle = nil;
}

#pragma mark -

- (void)updateDiffDataWithCell:(ZJSettingTableViewCell *)cell {
}

- (void)layoutDiffSubviewWithCell:(ZJSettingTableViewCell *)cell {
}

- (void)updateDiffConfigWithCell:(ZJSettingTableViewCell *)cell config:(ZJBaseTVConfig *)config {
}

@end
