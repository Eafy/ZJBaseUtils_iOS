//
//  ZJInputTextView.h
//  ZJBaseUtils
//
//  Created by eafy on 2020/11/28.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ZJBaseUtils/ZJLine.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, ZJInputTextViewStyle) {
    ZJInputTextViewStylePhone,          //手机账号
    ZJInputTextViewStylePhoneAreaCode,  //带区号的手机
    ZJInputTextViewStyleEmail,          //邮箱账号
    ZJInputTextViewStylePassword,       //密码
    ZJInputTextViewStyleVerificationCode,   //验证码
    ZJInputTextViewStyleCustom,         //自定义
};

@interface ZJInputTextView : UIView

+ (instancetype)inputViewWithStyle:(ZJInputTextViewStyle)style;

/// 样式
@property (nonatomic,assign) ZJInputTextViewStyle style;

/// 左右间距，默认16
@property (nonatomic,assign) CGFloat space;

/// 头视图
@property (nonatomic,strong) UIImageView *iconImgView;
/// 输入框
@property (nonatomic,strong) UITextField *inputTextField;
/// 输入占位提示语
@property (nonatomic,copy) NSString *placeholderString;
/// 右边辅助按钮
@property (nonatomic,strong) UIButton *assistBtn;
/// 输入框右边辅助按钮，置空时使用系统默认
@property (nonatomic,strong) UIButton *inputTextClearBtn;
/// 底线条
@property (nonatomic,strong) ZJLine *liveView;

/// 点击区号按钮回调
@property (nonatomic,copy) void (^ _Nullable tapAreaCodeBtnCompletion)(UIButton *btn);

@end

NS_ASSUME_NONNULL_END
