//
//  ZJSettingSwitchItem.m
//  ZJBaseUtils
//
//  Created by eafy on 2020/9/14.
//  Copyright © 2020 ZJ. All rights reserved.
//
#import "ZJSettingSwitchItem.h"
#import "ZJBaseTVConfig.h"

@implementation ZJSettingSwitchItem

- (ZJSettingItemType)type
{
    return ZJSettingItemTypeSwitch;
}

- (void)setSwitchBtnValue:(BOOL)switchBtnValue
{
    _switchBtnValue = switchBtnValue;
    self.switchBtn.on = switchBtnValue;
}

- (void)setSwitchBtnEnable:(BOOL)switchBtnEnable
{
    _switchBtnEnable = switchBtnEnable;
    self.switchBtn.enabled = switchBtnEnable;
}

- (UISwitch *)switchBtn
{
    if (!_switchBtn) {
        _switchBtn = [[UISwitch alloc] init];
        [_switchBtn addTarget:self action:@selector(switchBtnChange:) forControlEvents:UIControlEventValueChanged];
    }
    return _switchBtn;
}

- (UIView *)accessoryView
{
    if (super.accessoryView.tag != self.type) {
        super.accessoryView = self.switchBtn;
        super.accessoryView.tag = self.type;
    }
    
    return super.accessoryView;
}

#pragma mark - 重载差异化

- (void)updateDiffCinfigWithCell:(ZJSettingTableViewCell *)cell config:(ZJBaseTVConfig *)config
{
    if (config.switchBgColor) self.switchBtn.backgroundColor = config.switchBgColor;
    if (config.switchOnTintColor) self.switchBtn.onTintColor = config.switchOnTintColor;
    if (config.switchThumbTintColor) self.switchBtn.thumbTintColor = config.switchThumbTintColor;
}

#pragma mark - SwitchBtnAction

- (void)switchBtnChange:(UISwitch *)switchBtn
{
    if (_switchBtnBlock) {
        self.switchBtnBlock(switchBtn);
    }
}

@end
