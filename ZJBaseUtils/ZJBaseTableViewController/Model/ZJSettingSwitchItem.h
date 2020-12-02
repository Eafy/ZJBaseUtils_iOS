//
//  ZJSettingSwitchItem.h
//  ZJBaseUtils
//
//  Created by eafy on 2020/9/14.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import "ZJSettingItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZJSettingSwitchItem : ZJSettingItem

/// SwitchBtn操作之后的响应
@property (nonatomic,copy) void(^ _Nullable switchBtnBlock)(UISwitch * _Nonnull switchBtn);
/// SwitchBtn的值
@property (nonatomic,assign) BOOL value;
/// SwitchBtn的使能
@property (nonatomic,assign) BOOL enable;
/// UISwitch开关
@property (nonatomic,strong) UISwitch * _Nullable switchBtn;

@end

NS_ASSUME_NONNULL_END
