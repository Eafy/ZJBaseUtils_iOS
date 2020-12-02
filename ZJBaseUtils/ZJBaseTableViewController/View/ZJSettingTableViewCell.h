//
//  ZJSettingTableViewCell.h
//  ZJBaseUtils
//
//  Created by eafy on 2020/9/14.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZJBaseTVPrivateData.h"
#import "ZJSettingItemGroup.h"
#import "ZJSettingItem.h"
#import "ZJSettingCustomViewItem.h"
#import "ZJSettingArrowItem.h"
#import "ZJSettingSwitchItem.h"
#import "ZJSettingLabelItem.h"
#import "ZJSettingTextFieldItem.h"
#import "ZJSettingRadioItem.h"
#import "ZJSettingScoreItem.h"
#import "ZJSettingStepperItem.h"
#import "ZJSettingButtonItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZJSettingTableViewCell : UITableViewCell

/// 基础数据模型
@property (nonatomic,strong,readonly) ZJSettingItem *item;

/// 切角类型（UIRectCorner），默认无
@property (nonatomic,assign) NSInteger cornerType;

/// 是否显示线条
@property (nonatomic, assign) BOOL isShowLine;

/// 获取一个模板类Cell视图示例
/// @param tableView UITableView对象
/// @param item ZJSettingItem数据模组
/// @param config 全局颜色、字体等配置
+ (instancetype)cellWithTableView:(UITableView *)tableView item:(ZJSettingItem *)item config:(ZJBaseTVConfig *)config;

@end

NS_ASSUME_NONNULL_END
