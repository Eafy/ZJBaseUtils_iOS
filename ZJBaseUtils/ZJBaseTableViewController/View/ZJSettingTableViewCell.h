//
//  ZJSettingTableViewCell.h
//  ZJBaseUtils
//
//  Created by eafy on 2020/9/14.
//  Copyright © 2020 ZJ<lizhijian_21@163.com>. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZJSettingItem;
@class ZJBaseTableViewConfig;

NS_ASSUME_NONNULL_BEGIN

@interface ZJSettingTableViewCell : UITableViewCell

/// 基础数据模型
@property (nonatomic,strong) ZJSettingItem *item;
/// SwitchBtn操作之后的响应
@property (nonatomic,copy) void(^ _Nullable switchBtnBlock)(UISwitch * _Nonnull switchBtn);
/// 自定义视图
@property (nonatomic,strong) UIView *customView;

+ (instancetype)cellWithTableView:(UITableView *)tableView item:(ZJSettingItem *)item config:(ZJBaseTableViewConfig *)config;

@end

NS_ASSUME_NONNULL_END
