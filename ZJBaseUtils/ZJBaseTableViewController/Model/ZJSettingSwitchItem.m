//
//  ZJSettingSwitchItem.m
//  ZJBaseUtils
//
//  Created by eafy on 2020/9/14.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import <ZJBaseUtils/ZJSettingSwitchItem.h>
#import <ZJBaseUtils/ZJBaseTVConfig.h>
#import <ZJBaseUtils/UIColor+ZJExt.h>

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
