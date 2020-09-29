//
//  ZJSettingLabelItem.h
//  ZJBaseUtils
//
//  Created by eafy on 2020/9/14.
//  Copyright © 2020 ZJ<lizhijian_21@163.com>. All rights reserved.
//

#import "ZJSettingItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZJSettingLabelItem : ZJSettingItem

/// 是否是中心模式
@property (nonatomic,assign) BOOL isCenterModel;
/// 中心主标题字体
@property (nonatomic,strong) UIColor *titleColor;
/// 中心主标题字体
@property (nonatomic,strong) UIFont *titleFont;

@end

NS_ASSUME_NONNULL_END
