//
//  ZJSettingCustomViewItem.m
//  ZJBaseUtils
//
//  Created by eafy on 2020/9/14.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import "ZJSettingCustomViewItem.h"
#import "ZJSettingTableViewCell.h"

@implementation ZJSettingCustomViewItem

- (ZJSettingItemType)type
{
    return ZJSettingItemTypeCustomView;
}

#pragma mark - 重载差异化

- (void)updateDiffDataWithCell:(ZJSettingTableViewCell *)cell
{
    cell.imageView.image = nil;
    cell.textLabel.text = nil;
    if (!self.customView.superview) [cell.contentView addSubview:self.customView];
}

@end
