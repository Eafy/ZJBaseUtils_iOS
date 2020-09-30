//
//  ZJSettingTableViewCell.h
//  ZJBaseUtils
//
//  Created by eafy on 2020/9/14.
//  Copyright © 2020 ZJ<lizhijian_21@163.com>. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZJBaseTableViewConfig.h"
#import "ZJSettingItemGroup.h"
#import "ZJSettingItem.h"
#import "ZJSettingCustomViewItem.h"
#import "ZJSettingArrowItem.h"
#import "ZJSettingSwitchItem.h"
#import "ZJSettingLabelItem.h"
#import "ZJSettingTextFieldItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZJSettingTableViewCell : UITableViewCell

/// 基础数据模型
@property (nonatomic,strong,readonly) ZJSettingItem *item;

/// 获取一个模板类Cell视图示例
/// @param tableView UITableView对象
/// @param item JMSettingItem数据模组
/// @param config 全局颜色、字体等配置
+ (instancetype)cellWithTableView:(UITableView *)tableView item:(ZJSettingItem *)item config:(ZJBaseTableViewConfig *)config;

@end

NS_ASSUME_NONNULL_END
