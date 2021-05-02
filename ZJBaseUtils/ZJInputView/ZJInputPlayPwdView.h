//
//  ZJInputPlayPwdView.h
//  ZJBaseUtils
//
//  Created by eafy on 2020/10/14.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


/// 支付码输入框
@interface ZJInputPlayPwdView : UIView

/// 输入框个数，默认6个
@property (nonatomic,assign) NSUInteger inputMaxCount;
/// 输入框大小，默认[46,46]
@property (nonatomic,assign) CGSize inputSize;
/// 是否是线性输入，默认YES
@property (nonatomic,assign) BOOL isLinearinput;
/// 输入字符串更改回调
@property (nonatomic,copy) void (^ _Nullable inputTextFieldChangeHandler)(NSString *str);


/// 键盘类型，默认数字键盘
@property (nonatomic,assign) UIKeyboardType keyboardType;
/// 文字字体，默认常规16
@property (nonatomic,strong) UIFont *textFont;
/// 文字颜色
@property (nonatomic,strong) UIColor *textColor;
/// 边框颜色
@property (nonatomic,strong) UIColor *borderColor;
/// 边框宽度，默认0.5
@property (nonatomic,assign) CGFloat borderWidth;
/// 圆角大小，默认4
@property (nonatomic,assign) CGFloat cornerRadius;
/// 密码类型显示为星号*，默认NO
@property (nonatomic,assign) BOOL isSecureStar;

@end

NS_ASSUME_NONNULL_END
