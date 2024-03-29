//
//  ZJSettingLabelItem.m
//  ZJBaseUtils
//
//  Created by eafy on 2020/9/14.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import <ZJBaseUtils/ZJSettingLabelItem.h>
#import <ZJBaseUtils/ZJSettingTableViewCellExt.h>
#import <ZJBaseUtils/UIColor+ZJExt.h>
#import <ZJBaseUtils/ZJLocalization.h>
#import <ZJBaseUtils/UIView+ZJFrame.h>

@implementation ZJSettingLabelItem

- (ZJSettingItemType)type {
    return ZJSettingItemTypeLabel;
}

- (void)defaultData {
    if (!self.centerTitleColor)  self.centerTitleColor = ZJColorFromRGB(0xF02359);
    if (!self.centerTitleFont) self.centerTitleFont = [UIFont boldSystemFontOfSize:16.0f];
}

- (void)setIsCenterModel:(BOOL)isCenterModel {
    _isCenterModel = isCenterModel;
}

#pragma mark - 重载差异化

- (void)updateDiffDataWithCell:(ZJSettingTableViewCell *)cell
{
    if (self.isCenterModel) {
        cell.textLabel.text = nil;
        cell.detailTextLabel.text = nil;
        cell.imageView.image = nil;
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
        
        cell.subTitleLabel.textAlignment = NSTextAlignmentCenter;
        cell.subTitleLabel.text = self.title.localized;
    }
}

- (void)layoutDiffSubviewWithCell:(ZJSettingTableViewCell *)cell
{
    if (self.isCenterModel) {
        cell.subTitleLabel.zj_centerXY = cell.contentView.zj_centerXY;
        cell.subTitleLabel.textAlignment = NSTextAlignmentCenter;
    }
}

- (void)updateDiffConfigWithCell:(ZJSettingTableViewCell *)cell config:(ZJBaseTVConfig *)config {
    if (self.isCenterModel) {
        if (self.centerTitleColor) cell.subTitleLabel.textColor = self.centerTitleColor;
        if (self.centerTitleFont) cell.subTitleLabel.font = self.centerTitleFont;
    }
}


@end
