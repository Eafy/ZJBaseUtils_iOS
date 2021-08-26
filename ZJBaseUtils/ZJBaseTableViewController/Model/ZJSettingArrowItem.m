//
//  ZJSettingArrowItem.m
//  ZJBaseUtils
//
//  Created by eafy on 2020/9/14.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import <ZJBaseUtils/ZJSettingArrowItem.h>
#import <ZJBaseUtils/ZJSettingTableViewCellExt.h>

@implementation ZJSettingArrowItem

- (ZJSettingItemType)type {
    return ZJSettingItemTypeArrow;
}

- (void)defaultData {
    self.isSelection = YES;
}

#pragma mark - 重载差异化

- (void)updateDiffDataWithCell:(ZJSettingTableViewCell *)cell {
    if (self.isSelection && !self.arrowIcon) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
}

- (void)updateDiffConfigWithCell:(ZJSettingTableViewCell *)cell config:(ZJBaseTVConfig *)config
{
    
}

@end
