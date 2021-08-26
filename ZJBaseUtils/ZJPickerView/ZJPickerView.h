//
//  ZJPickerView.h
//  ZJBaseUtils
//
//  Created by eafy on 2020/11/23.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ZJBaseUtils/ZJPickerItem.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ZJPickerViewDelegate;

typedef NS_ENUM(NSInteger, ZJPickerViewStyle) {
    ZJPickerViewStyleNormal,
    ZJPickerViewStyleDate_YMD,  // 年月日：2020 01 14
    ZJPickerViewStyleDate_HMS,   // 时分秒：10 33 56
    ZJPickerViewStyleDate_YMDHM,    // 年月日时分：2020 01 14 10 33
    ZJPickerViewStyleDate_YMDHMS,   // 年月日时分秒： 2020 01 14 10 33 56
};

@interface ZJPickerView : UIView

+ (instancetype)initWithFrame:(CGRect)frame itemsArray:(NSArray<ZJPickerItem *> *)itemsArray;

- (instancetype)initWithFrame:(CGRect)frame;

/// 数据代理
@property (nonatomic,weak) id<ZJPickerViewDelegate> delegate;
/// 选择器样式，默认：ZJPickerViewStyleNormal
@property (nonatomic,assign) ZJPickerViewStyle style;

/// 数据源（时间选择器不需要设置）
@property (nonatomic,strong) NSArray<ZJPickerItem *> * _Nullable itemsArray;

/// 设置当前日期（日期选择器类型才有效）
@property (nonatomic,strong) NSDate *selectDate;

/// 滑动每个一个列时是否重置下一列
@property (nonatomic,assign) BOOL isResetNext;

/// 标题
@property (nonatomic,copy) NSString *title;
/// 标题颜色
@property (nonatomic,strong) UIColor *titleColor;
/// 标题颜色
@property (nonatomic,strong) UIFont *titleFont;

/// 确认按钮标题
@property (nonatomic,strong) NSString *okTitle;
/// 确认标题颜色
@property (nonatomic,strong) UIColor *okTitleColor;
/// 确认标题颜色,默认常规16
@property (nonatomic,strong) UIFont *okTitleFont;

/// 取消按钮标题
@property (nonatomic,strong) NSString *cancelTitle;
/// 取消标题颜色
@property (nonatomic,strong) UIColor *cancelTitleColor;
/// 取消标题颜色,默认常规16
@property (nonatomic,strong) UIFont *cancelTitleFont;

/// 顶部视图高度，默认56
@property (nonatomic,assign) CGFloat topViewHeight;
/// 顶部视图底部线条的颜色，默认透明
@property (nonatomic,strong) UIColor *topViewLineColor;
/// 按钮2边的偏移量，默认15
@property (nonatomic,assign) CGFloat btnOffset;

/// 选择行背景颜色，默认透明
@property (nonatomic,strong) UIColor *rowBackgroundColor;
/// 行文字颜色，默认黑色
@property (nonatomic,strong) UIColor *rowTitleColor;
/// 行文字大小，默认常规16
@property (nonatomic,strong) UIFont *rowTitleFont;
/// 选择行文字颜色，默认黑色
@property (nonatomic,strong) UIColor *rowSelTitleColor;
/// 选择行文字大小，默认常规16
@property (nonatomic,strong) UIFont *rowSelTitleFont;
/// 选择框上下线条的颜色，默认：#DCE0E8
@property (nonatomic,strong) UIColor *rowLineColor;
///  选择框上下线条的高度，默认1.0
@property (nonatomic,assign) CGFloat rowLineHeight;
/// 自适应字体大小，默认YES
@property (nonatomic,assign) BOOL rowAdjustsFontSize;

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

/// 替换第几列的数据
/// @param index 索引号
- (BOOL)replaceArrayAtComponent:(NSUInteger)index item:(ZJPickerItem *)item;

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
- (UIView *)pickerView:(ZJPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view;
- (void)pickerView:(ZJPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component;

@end

NS_ASSUME_NONNULL_END
