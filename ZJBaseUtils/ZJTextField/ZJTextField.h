
//
//  ZJTextField.h
//  ZJBaseUtils
//
//  Created by eafy on 2020/11/30.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ZJTextFieldDelegate;

@interface ZJTextField : UITextField

@property (nonatomic,weak) id<ZJTextFieldDelegate> zj_delegate;

/// 输入框文字左侧间距，默认0
@property (nonatomic,assign) CGFloat textInnerMargin;

/// 输入框清除按钮图片
@property (nonatomic,copy) NSString * _Nullable clearBtnImageName;

/// 设置占位文字的属性
/// @param str 字符串
/// @param color 颜色
/// @param font 字体
- (void)placeholderWithText:(NSString *)str color:(UIColor * _Nullable)color font:(UIFont * _Nullable)font;

@end

@protocol ZJTextFieldDelegate <NSObject>
@optional

/// 将点击键盘的删除按钮（系统处理之前）
/// @param textField ZJTextField
- (void)textFieldWillDeleteBackward:(ZJTextField *)textField;

/// 已点击键盘的删除按钮（系统处理之后）
/// @param textField ZJTextField
- (void)textFieldDidDeleteBackward:(ZJTextField *)textField;

@end

NS_ASSUME_NONNULL_END
