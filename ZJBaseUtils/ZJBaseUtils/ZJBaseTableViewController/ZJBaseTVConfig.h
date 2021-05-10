//
//  ZJBaseTVConfig.h
//  ZJBaseUtils
//
//  Created by eafy on 2020/9/14.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZJBaseTVConfig : NSObject

/// 缓存Cell行高
@property (nonatomic,assign) CGFloat rowCacheHeight;
/// 缓存footer的高度
@property (nonatomic,assign) CGFloat footerCacheHeight;

/// Group圆角，当UITableViewStylePlain模式生效
@property (nonatomic,assign) CGFloat cornerRadius;

#pragma mark -

/// 背景视图左边的间距，默认15
@property (nonatomic,assign) CGFloat marginLeft;

/// 背景视图有边的间距，默认10
@property (nonatomic,assign) CGFloat marginRight;

/// 头视图左边距，默认0，即不设置
@property (nonatomic,assign) CGFloat iconLeftSpace;
/// 头视图右边距，默认5
@property (nonatomic,assign) CGFloat iconRightSpace;

/// 箭头左边间距，默认5，仅右侧多视图时生效
@property (nonatomic,assign) CGFloat arrowLeftSpace;
/// 箭头右边间距，默认5，需要设置ZJSettingItem:-arrowIcon视图参数，否则无效
@property (nonatomic,assign) CGFloat arrowRightSpace;

/// 线条的颜色，默认TableView的背景颜色
@property (nonatomic,strong) UIColor *lineColor;
/// 线条高度，默认0.5
@property (nonatomic,assign) CGFloat lineHeight;

#pragma mark -

/// 启动适配器
@property (nonatomic,assign) BOOL adapterEnable;
/// 控制器视图背景颜色
@property (nonatomic,strong) UIColor *bgColor;
/// TableView视图背景颜色
@property (nonatomic,strong) UIColor *bgTableViewColor;

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

/*UITextField相关设置参数*/
/// 占位文字颜色
@property (nonatomic,strong) UIColor *textFieldPlaceholderColor;
/// 占位文字字体
@property (nonatomic,strong) UIFont *textFieldPlaceholderFont;

/*UISwitch相关设置参数*/
/// UISwitch选中颜色
@property (nonatomic,strong) UIColor *switchOnTintColor;
/// UISwitch按钮颜色
@property (nonatomic,strong) UIColor *switchThumbTintColor;
/// UISwitch背景颜色
@property (nonatomic,strong) UIColor *switchBgColor;

/*RadioBtn相关设置参数*/
/// RadioBtn颜色
@property (nonatomic,strong) UIColor *radioBtnTitleColor;
/// RadioBtn字体
@property (nonatomic,strong) UIFont *radioBtnTitleFont;

@end

NS_ASSUME_NONNULL_END
