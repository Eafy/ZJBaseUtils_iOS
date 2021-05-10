//
//  ZJSettingSwitchItem.m
//  ZJBaseUtils
//
//  Created by eafy on 2020/9/14.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import "ZJSettingSwitchItem.h"
#import "ZJBaseTVConfig.h"
#import "UIColor+ZJExt.h"

@implementation ZJSettingSwitchItem
@dynamic value;
@dynamic enable;

- (ZJSettingItemType)type
{
    return ZJSettingItemTypeSwitch;
}

- (void)setValue:(BOOL)value
{
    self.switchBtn.on = value;
}

- (BOOL)value {
    return self.switchBtn.on;
}

- (void)setEnable:(BOOL)enable
{
    self.switchBtn.enabled = enable;
}

- (BOOL)enable {
    return self.switchBtn.enabled;
}

- (UISwitch *)switchBtn
{
    if (!_switchBtn) {
        _switchBtn = [[UISwitch alloc] init];
        _switchBtn.thumbTintColor = ZJColorFromRGB(0xFFFFFF);
        _switchBtn.tintColor = ZJColorFromRGB(0xBCC4D4);
        _switchBtn.onTintColor = ZJColorFromRGB(0x3D7DFF);
        _switchBtn.backgroundColor = [UIColor clearColor];
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

- (void)updateDiffConfigWithCell:(ZJSettingTableViewCell *)cell config:(ZJBaseTVConfig *)config
{
    if (config.switchBgColor) self.switchBtn.backgroundColor = config.switchBgColor;
    if (config.switchOnTintColor) {
        self.switchBtn.onTintColor = config.switchOnTintColor;
    }
    if (config.switchThumbTintColor) self.switchBtn.thumbTintColor = config.switchThumbTintColor;
}

#pragma mark - SwitchBtnAction

- (void)switchBtnChange:(UISwitch *)switchBtn
{
    if (_switchBtnBlock) {
        self.switchBtnBlock(self, switchBtn);
    }
}

@end
