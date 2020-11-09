//
//  ZJSettingItem.h
//  ZJBaseUtils
//
//  Created by eafy on 2020/9/14.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// Cell的item类型
typedef NS_ENUM(NSUInteger, ZJSettingItemType) {
    ZJSettingItemTypeNone = 0,      //不识别
    ZJSettingItemTypeArrow,         //跳转类型
    ZJSettingItemTypeLabel,         //标签类型
    ZJSettingItemTypeSwitch,        //开关类型
    ZJSettingItemTypeTextFidld,     //文本类型
    ZJSettingItemTypeCustomView,    //自定义类型
    
    ZJSettingItemTypeRadio = ZJSettingItemTypeArrow,         //单选/复选类型
};

@class ZJSettingTableViewCell;
@class ZJBaseTableViewConfig;

@interface ZJSettingItem : NSObject

/// item类型(设置无效)
@property (nonatomic,assign) ZJSettingItemType type;

/// 标识
@property (nonatomic,assign) NSInteger tag;
/// 图标
@property (nonatomic,copy) NSString * _Nullable icon;
/// 左边主标题
@property (nonatomic,copy) NSString * _Nullable title;
/// 主标题右侧图标
@property (nonatomic,copy) NSString * _Nullable titleHintIcon;
/// 左边副标题
@property (nonatomic,copy) NSString * _Nullable subTitle;
/// 右边详情
@property (nonatomic,copy) NSString * _Nullable detailTitle;
/// 右侧箭头图标
@property (nonatomic,copy) NSString * _Nullable arrowIcon;
/// 处理点击的事件，走此block会终止后续的操作
@property (nonatomic,copy) void(^ _Nullable operationHandle)(ZJSettingItem * _Nullable item);

#pragma mark - 自定义区

/// 自定义arrow视图
@property (nonatomic,strong) UIView * _Nullable accessoryView;
/// 自定义Cell视图
@property (nonatomic,strong) UIView * _Nullable customView;

#pragma mark - 传递数据区
/// 需要传递的数据（一般是对象类）
@property (nonatomic,strong) id _Nullable dataObject;
/// 需要传递的数据（一般是数据类）
@property (nonatomic,strong) id _Nullable data;
/// 需要传递的数据（一般是指针数据）
@property (nonatomic,assign) char * _Nullable pData;

#pragma mark -

/// 指向的下一个视图控制器类
@property (nonatomic,assign) Class _Nullable destVC;

/// 初始化一个Item模组
/// @param icon 主图片名称
/// @param title 主标题
- (instancetype _Nonnull)initWithIcon:(NSString * _Nullable)icon title:(NSString * _Nullable)title;

/// 初始化一个Item模组
/// @param icon 主图片名称
/// @param title 主标题
/// @param destVc 点击的下一个控制器类，ZJSettingItemTypeArrow类型才生效
- (instancetype _Nonnull)initWithIcon:(NSString *_Nullable)icon title:(NSString *_Nullable)title destClass:(Class _Nullable )destVc;

#pragma mark - 重载差异化

/// 差异化更新数据（子item需要需要重写）
/// @param cell cell示例对象
- (void)updateDiffDataWithCell:(ZJSettingTableViewCell *)cell;

/// 差异化更新子视图/布局（子item需要需要重写）
/// @param cell cell示例对象
- (void)layoutDiffSubviewWithCell:(ZJSettingTableViewCell *)cell;

/// 差异化更新配置数据（子item需要需要重写）
/// @param config ZJBaseTableViewConfig示例对象
- (void)updateDiffCinfigWithCell:(ZJSettingTableViewCell *)cell config:(ZJBaseTableViewConfig *)config;

@end

NS_ASSUME_NONNULL_END
