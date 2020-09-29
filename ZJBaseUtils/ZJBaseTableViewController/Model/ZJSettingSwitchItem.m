//
//  ZJSettingSwitchItem.m
//  ZJBaseUtils
//
//  Created by eafy on 2020/9/14.
//  Copyright © 2020 ZJ<lizhijian_21@163.com>. All rights reserved.
//
#import "ZJSettingSwitchItem.h"

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

#pragma mark -

- (UISwitch *)switchBtn
{
    if (!_switchBtn) {
        _switchBtn = [[UISwitch alloc] init];
    }
    
    return _switchBtn;
}

@end
