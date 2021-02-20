//
//  ZJInputTextView.m
//  ZJUXKit
//
//  Created by eafy on 2020/11/28.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import "ZJInputTextView.h"
#import "UIColor+ZJExt.h"
#import "ZJLine.h"
#import "NSString+ZJExt.h"
#import "UIView+ZJFrame.h"

@interface ZJInputTextView ()

/// 底线条
@property (nonatomic,strong) ZJLine *vLineView;
@property (nonatomic,strong) UIButton *areaCodeBtn;
@property (nonatomic,strong) NSTimer *verCodeTimer;
@property (nonatomic,assign) NSInteger verCodeTimerCount;

@end

@implementation ZJInputTextView
@synthesize inputTextClearBtn = _inputTextClearBtn;

+ (instancetype)inputViewWithStyle:(ZJInputTextViewStyle)style
{
    ZJInputTextView *view = [[ZJInputTextView alloc] init];
    view.space = 16;
    view.style = style;
    
    return view;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _space = 16;
    }
    
    return self;
}

- (void)dealloc {
    if (_verCodeTimer) {
        [_verCodeTimer invalidate];
        _verCodeTimer = nil;
    }
}

- (UIImageView *)iconImgView
{
    if (!_iconImgView) {
        _iconImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 24, 24)];
        [self addSubview:_iconImgView];
    }
    
    return _iconImgView;
}

- (UIButton *)assistBtn
{
    if (!_assistBtn) {
        _assistBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 24, 24)];
        _assistBtn.hidden = YES;
        [self addSubview:_assistBtn];
        
        [_assistBtn addTarget:self action:@selector(clickedAssistBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _assistBtn;
}

- (UITextField *)inputTextField
{
    if (!_inputTextField) {
        _inputTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 0, 18)];
        _inputTextField.font = [UIFont boldSystemFontOfSize:14];
        _inputTextField.textColor = ZJColorFromRGB(0x181E28);
        _inputTextField.attributedPlaceholder = [@"Input Info" zj_stringWithColor:ZJColorFromRGB(0xBCC4D4) font:_inputTextField.font];
        _inputTextField.returnKeyType = UIReturnKeyNext;
        _inputTextField.keyboardType = UIKeyboardTypeASCIICapable;
        [self addSubview:_inputTextField];
        
        [self inputTextClearBtn];
    }
    
    return _inputTextField;
}

- (ZJLine *)liveView
{
    if (!_liveView) {
        _liveView = [[ZJLine alloc] initWithFrame:CGRectMake(0, 0, 0, 0.5)];
        [self addSubview:_liveView];
    }
    
    return _liveView;
}

- (UIButton *)inputTextClearBtn
{
    if (!_inputTextClearBtn) {
        _inputTextClearBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 24, 24)];
        [_inputTextClearBtn setImage:[UIImage imageNamed:@"icon_textField_clear_normal"] forState:UIControlStateNormal];
        [_inputTextClearBtn addTarget:self action:@selector(clickedInputTextAssistBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        
        self.inputTextField.clearButtonMode = UITextFieldViewModeNever;
        self.inputTextField.rightView = _inputTextClearBtn;
        self.inputTextField.rightViewMode = UITextFieldViewModeWhileEditing;
    }
    
    return _inputTextClearBtn;
}

- (void)setInputTextClearBtn:(UIButton *)inputTextClearBtn
{
    if (!inputTextClearBtn && _inputTextClearBtn) {
        self.inputTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.inputTextField.rightView = nil;
        self.inputTextField.rightViewMode = UITextFieldViewModeNever;
        _inputTextClearBtn = nil;
    }
}

- (ZJLine *)vLineView {
    if (!_vLineView) {
        _vLineView = [[ZJLine alloc] initWithFrame:CGRectMake(0, 6, 0.5, 0)];
        [self addSubview:_vLineView];
    }
    return _vLineView;
}

- (UIButton *)areaCodeBtn {
    if (!_areaCodeBtn) {
        _areaCodeBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        [_areaCodeBtn setTitle:@"+86" forState:UIControlStateNormal];
        [_areaCodeBtn setTitleColor:ZJColorFromRGB(0x181E28) forState:UIControlStateNormal];
        _areaCodeBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        [_areaCodeBtn addTarget:self action:@selector(clickedAreaCodeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_areaCodeBtn];
    }
    return _areaCodeBtn;
}

#pragma mark -

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.iconImgView.zj_left = self.space;
    self.iconImgView.zj_centerY = self.zj_height/2;
    
    if (self.style == ZJInputTextViewStyleVerificationCode) {
        self.assistBtn.zj_width = 84;
    }
    self.assistBtn.zj_right = self.zj_right - self.space;
    self.assistBtn.zj_centerY = self.zj_height/2;
    
    CGFloat left = self.iconImgView.zj_right + self.space/2;
    CGFloat right = self.assistBtn.zj_left - self.space/2;
    
    if (self.style == ZJInputTextViewStylePhoneAreaCode) {
        self.areaCodeBtn.zj_left = left;
        self.areaCodeBtn.zj_height = self.zj_height;
        self.areaCodeBtn.zj_width = 32;
        left = self.areaCodeBtn.zj_right + self.space/2;
        
        self.vLineView.zj_height = self.zj_height - self.vLineView.zj_top * 2;
        self.vLineView.zj_left = left;
        left = self.vLineView.zj_right + self.space/2;
    } else if (self.style == ZJInputTextViewStyleVerificationCode) {
        self.vLineView.zj_height = self.zj_height - self.vLineView.zj_top * 2;
        self.vLineView.zj_left = self.assistBtn.zj_left - self.space/2;
        right = self.vLineView.zj_left - self.space/2;
    }
    
    self.inputTextField.zj_left = left;
    self.inputTextField.zj_width = right - left;
    self.inputTextField.zj_centerY = self.zj_height/2;
    if (self.assistBtn.hidden) {
        self.inputTextField.zj_width = self.assistBtn.zj_right - self.inputTextField.zj_left;
    }
    
    self.liveView.zj_bottom = self.zj_height;
    if (self.style == ZJInputTextViewStylePhoneAreaCode) {
        self.liveView.zj_left = self.areaCodeBtn.zj_left;
    } else {
        self.liveView.zj_left = self.inputTextField.zj_left;
    }
    self.liveView.zj_width = self.assistBtn.zj_right - self.liveView.zj_left;
    
}

#pragma mark - clickedAssistBtnAction

- (void)clickedAssistBtnAction:(UIButton *)btn
{
    if (self.style == ZJInputTextViewStylePassword) {
        btn.selected = !btn.selected;
        self.inputTextField.secureTextEntry = btn.selected;
    } else if (self.style == ZJInputTextViewStyleVerificationCode) {
        self.assistBtn.selected = !self.assistBtn.selected;
        self.assistBtn.userInteractionEnabled = !self.assistBtn.selected;
        if (self.assistBtn.selected) {
            self.verCodeTimerCount = 60;
            [self.verCodeTimer invalidate];
            self.verCodeTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(handleVerCodeTimerAction:) userInfo:nil repeats:YES];
        }
    }
}

- (void)clickedInputTextAssistBtnAction:(UIButton *)btn
{
    if (self.inputTextField.clearButtonMode == UITextFieldViewModeNever) {
        self.inputTextField.text = @"";
    }
}

- (void)clickedAreaCodeBtnAction:(UIButton *)btn {
    if (self.tapAreaCodeBtnCompletion) {
        self.tapAreaCodeBtnCompletion(btn);
    }
}

- (void)handleVerCodeTimerAction:(NSTimer *)timer {
    self.verCodeTimerCount --;
    if (self.verCodeTimerCount <= 0) {
        [self.verCodeTimer invalidate];
        self.assistBtn.selected = NO;
        self.assistBtn.userInteractionEnabled = YES;
        [self.assistBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    } else {
        [self.assistBtn setTitle:[NSString stringWithFormat:@"%lds秒后重获", (long)self.verCodeTimerCount] forState:UIControlStateSelected];
    }
}

- (void)setStyle:(ZJInputTextViewStyle)style
{
    _style = style;
    if (style == ZJInputTextViewStylePhone ||
        style == ZJInputTextViewStylePhoneAreaCode) {   //手机
        self.inputTextField.keyboardType = UIKeyboardTypePhonePad;
        
        self.iconImgView.image = [UIImage imageNamed:@"icon_uxkit_phone"];
    } else if (style == ZJInputTextViewStyleEmail) {
        self.inputTextField.keyboardType = UIKeyboardTypeEmailAddress;
        
    } else if (style == ZJInputTextViewStylePassword) {
        self.inputTextField.secureTextEntry = YES;
        self.assistBtn.hidden = NO;
        
        self.iconImgView.image = [UIImage imageNamed:@"icon_uxkit_password"];
        [self.assistBtn setImage:[UIImage imageNamed:@"icon_uxkit_hide"] forState:UIControlStateNormal];
        [self.assistBtn setImage:[UIImage imageNamed:@"icon_uxkit_display"] forState:UIControlStateSelected];
    } else if (style == ZJInputTextViewStyleVerificationCode) {
        self.inputTextField.secureTextEntry = NO;
        self.assistBtn.hidden = NO;
        self.inputTextField.keyboardType = UIKeyboardTypePhonePad;
        
        self.assistBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [self.assistBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [self.assistBtn setTitle:@"60s秒后重获" forState:UIControlStateSelected];
        [self.assistBtn setTitleColor:ZJColorFromRGB(0x3D7DFF) forState:UIControlStateNormal];
        [self.assistBtn setTitleColor:ZJColorFromRGB(0xBCC4D4) forState:UIControlStateSelected];
    }
}

@end
