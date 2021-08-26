//
//  ZJSettingRadioItem.h
//  ZJBaseUtils
//
//  Created by eafy on 2020/9/29.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import <ZJBaseUtils/ZJSettingItem.h>

NS_ASSUME_NONNULL_BEGIN

/// 单选或复选框
@interface ZJSettingRadioItem : ZJSettingItem

/// 使能(设值无效)
@property (nonatomic,assign) BOOL enable;
/// 是否是单选框模式
@property (nonatomic,assign) BOOL radioModel;
/// 普通状态图标
@property (nonatomic,copy) NSString * _Nullable normalIcon;
/// 已选择状态图标
@property (nonatomic,copy) NSString * _Nullable selectIcon;
/// 无效普通状态图标
@property (nonatomic,copy) NSString * _Nullable normalDisIcon;
/// 无效选择状态图标
@property (nonatomic,copy) NSString * _Nullable selectDisIcon;
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
/// 选择/取消回调，stateArray为状态集合，index为触发索引号，selected是否选择，可反向设置
@property (nonatomic,copy) void(^ _Nullable radioBtnBlock)(NSString *selTitle, NSArray * _Nonnull stateArray, NSInteger index, BOOL *selected);

/// 更改选择状态（不触发回调）
/// @param index 索引号
- (void)selected:(NSUInteger)index;

@end

NS_ASSUME_NONNULL_END
