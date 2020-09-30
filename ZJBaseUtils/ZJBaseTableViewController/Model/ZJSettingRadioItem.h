//
//  ZJSettingRadioItem.h
//  ZJSmartUtils
//
//  Created by eafy on 2020/9/29.
//  Copyright © 2020 ZJ<lizhijian_21@163.com>. All rights reserved.
//

#import "ZJSettingItem.h"

NS_ASSUME_NONNULL_BEGIN

/// 单选或复选框
@interface ZJSettingRadioItem : ZJSettingItem

/// 是否是单选框模式
@property (nonatomic,assign) BOOL radioModel;
/// 普通状态图标
@property (nonatomic,copy) NSString * _Nullable normalIcon;
/// 已选择状态图标
@property (nonatomic,copy) NSString * _Nullable selectIcon;
/// 标题数组
@property (nonatomic,strong) NSArray<NSString *> * _Nullable titleArray;
/// 状态数组
@property (nonatomic,strong) NSArray<NSNumber *> * _Nullable stateArray;
/// 按钮之间的间隔宽度，默认24.0f
@property (nonatomic,assign) NSInteger btnSpace;
/// RadioBtn颜色，默认"#181E28"
@property (nonatomic,strong) UIColor *radioBtnTitleColor;
/// RadioBtn字体，默认14号
@property (nonatomic,strong) UIFont *radioBtnTitleFont;
/// 选择/取消回调
@property (nonatomic,copy) void(^ _Nullable radioBtnBlock)(NSArray * _Nonnull stateArray, NSInteger index, BOOL selected);

@end

NS_ASSUME_NONNULL_END
