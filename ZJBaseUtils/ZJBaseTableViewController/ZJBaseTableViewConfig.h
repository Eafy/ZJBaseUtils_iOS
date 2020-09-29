//
//  ZJBaseTableViewConfig.h
//  ZJBaseUtils
//
//  Created by eafy on 2020/9/14.
//  Copyright © 2020 ZJ<lizhijian_21@163.com>. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZJBaseTableViewConfig : NSObject

/// 启动适配器
@property (nonatomic,assign) BOOL adapterEnable;

/// 所有表单Cell统一的行高（默认54.0f）
@property (nonatomic,assign) CGFloat rowHeight;
/// 所有表单Section统一的头部高度（默认20.0f）
@property (nonatomic,assign) CGFloat sectionHeaderHeight;
/// 所有表单Section统一的底部高度（有数据系统/自定义视图；否则20.0f，最后一个0.1f）
@property (nonatomic,assign) CGFloat sectionFooterHeight;


/*CELL相关设置参数*/
/// Cell背景颜色
@property (nonatomic,strong) UIColor *cellBgColor;
/// Cell选择时的背景颜色
@property (nonatomic,strong) UIColor *cellSelectedBgColor;
/// Cell主标题颜色
@property (nonatomic,strong) UIColor *cellTitleColor;
/// Cell主标题颜色
@property (nonatomic,strong) UIColor *cellSubTitleColor;
/// Cell副标题颜色
@property (nonatomic,strong) UIColor *cellDetailTitleColor;
/// Cell主标题字体
@property (nonatomic,strong) UIFont *cellTitleFont;
/// Cell主标题字体
@property (nonatomic,strong) UIFont *cellSubTitleFont;
/// Cell副标题字体
@property (nonatomic,strong) UIFont *cellDetailTitleFont;

/*UISwitch相关设置参数*/
/// UISwitch选中颜色
@property (nonatomic,strong) UIColor *switchOnTintColor;
/// UISwitch按钮颜色
@property (nonatomic,strong) UIColor *switchThumbTintColor;
/// UISwitch背景颜色
@property (nonatomic,strong) UIColor *switchBgColor;

@end

NS_ASSUME_NONNULL_END
