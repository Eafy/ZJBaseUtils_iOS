//
//  ZJSettingArrowItem.m
//  ZJBaseUtils
//
//  Created by eafy on 2020/9/14.
//  Copyright © 2020 ZJ<lizhijian_21@163.com>. All rights reserved.
//

#import "ZJSettingArrowItem.h"
#import "ZJSettingTableViewCellExt.h"

@implementation ZJSettingArrowItem

- (ZJSettingItemType)type
{
    return ZJSettingItemTypeArrow;
}

#pragma mark - 重载差异化

- (void)updateDiffDataWithCell:(ZJSettingTableViewCell *)cell
{
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleDefault;
}

@end
