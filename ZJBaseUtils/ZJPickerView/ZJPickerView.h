//
//  ZJPickerView.h
//  ZJBaseUtils
//
//  Created by eafy on 2020/11/23.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZJPickerItem.h"

NS_ASSUME_NONNULL_BEGIN

@protocol ZJPickerViewDelegate;

@interface ZJPickerView : UIView

+ (instancetype)initWithFrame:(CGRect)frame itemsArray:(NSArray<ZJPickerItem *> *)itemsArray;

- (instancetype)initWithFrame:(CGRect)frame;

/// 数据代理
@property (nonatomic,weak) id<ZJPickerViewDelegate> delegate;

/// 数据源
@property (nonatomic,strong) NSArray<ZJPickerItem *> * _Nullable itemsArray;

/// 滑动每个一个列时是否重置下一列
@property (nonatomic,assign) BOOL isResetNext;

/// 标题
@property (nonatomic,strong) NSString *title;
/// 标题颜色
@property (nonatomic,strong) UIColor *titleColor;
/// 标题颜色
@property (nonatomic,strong) UIFont *titleFont;

/// 确认按钮标题
@property (nonatomic,strong) NSString *okTitle;
/// 确认标题颜色
@property (nonatomic,strong) UIColor *okTitleColor;
/// 确认标题颜色
@property (nonatomic,strong) UIFont *okTitleFont;

/// 取消按钮标题
@property (nonatomic,strong) NSString *cancelTitle;
/// 取消标题颜色
@property (nonatomic,strong) UIColor *cancelTitleColor;
/// 取消标题颜色
@property (nonatomic,strong) UIFont *cancelTitleFont;

/// 顶部视图高度，默认56
@property (nonatomic,assign) CGFloat topViewHeight;
/// 按钮2遍的偏移量，默认15
@property (nonatomic,assign) CGFloat btnOffset;

/// 选择行背景颜色，默认透明
@property (nonatomic,assign) UIColor *rowBackgroundColor;
/// 行文字颜色，默认黑色
@property (nonatomic,strong) UIColor *rowTitleColor;
/// 行文字大小，默认常规18
@property (nonatomic,assign) UIFont *rowTitleFont;
/// 选择框上下线条的颜色，默认：#DCE0E8
@property (nonatomic,strong) UIColor *rowLineColor;
///  选择框上下线条的高度，默认0.5
@property (nonatomic,assign) CGFloat rowLineHeight;

/// 上面遮罩层颜色，默认HEXA：#181E28B2
@property (nonatomic,strong) UIColor *maskColor;

/// 顶部左边及右边圆角
@property (nonatomic,assign) CGFloat cornerRadius;

/// 显示
- (void)show;

/// 隐藏/移除
- (void)dismiss;

/// 选择哪列哪行
/// @param component 列数
/// @param row 行数
/// @param animated 是否动画
- (void)selectComponent:(NSInteger)component row:(NSInteger)row animated:(BOOL)animated;

@end

@protocol ZJPickerViewDelegate<NSObject>
@required

/// 点击确认之后的最终回调
/// @param pickerView 选择器
/// @param rows 已选择行数索引列表
/// @param titles 已选择行数的标题列表
- (void)pickerView:(ZJPickerView *)pickerView didConfirmWithRows:(NSArray<NSNumber *> *)rows titles:(NSArray<NSString *> *)titles;

@optional

- (NSInteger)pickerView:(ZJPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component;
- (CGFloat)pickerView:(ZJPickerView *)pickerView widthForComponent:(NSInteger)component;
- (CGFloat)pickerView:(ZJPickerView *)pickerView rowHeightForComponent:(NSInteger)component;
- (nullable NSString *)pickerView:(ZJPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component;
- (nullable NSAttributedString *)pickerView:(ZJPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component;
- (void)pickerView:(ZJPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component;

@end

NS_ASSUME_NONNULL_END
