//
//  ZJAlertView.m
//  ZJBaseUtils
//
//  Created by eafy on 2020/12/10.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import "ZJAlertView.h"
#import "UIView+ZJFrame.h"
#import "UIColor+ZJExt.h"
#import "ZJScreen.h"
#import "NSString+ZJExt.h"
#import "ZJUtilsDef.h"
#import "ZJBaseUtils.h"

@interface ZJAlertView () <UITextFieldDelegate>

/// 遮罩视图
@property (nonatomic,strong) UIView *maskView;
/// 背景视图
@property (nonatomic,strong) UIView *alertView;
/// 关闭按钮
@property (nonatomic,strong) UIButton *closeBtn;
/// 标题
@property (nonatomic,strong) UILabel *titleLB;
/// 内容
@property (nonatomic,strong) UILabel *messageLB;
/// 顶部图片视图
@property (nonatomic,strong) UIImageView *titleImgView;

@property (nonatomic,strong) UITextField *inputTextField;
@property (nonatomic,strong) UIButton *inputTextClearBtn;

@property (nonatomic,strong) NSMutableArray<ZJAlertAction *> *btnArray;
@property (nonatomic,strong) NSMutableArray<UIView *> *lineViewArray;

@end

@implementation ZJAlertView

+ (instancetype)alertView {
    ZJAlertView *alertView = [[ZJAlertView alloc] init];
    return alertView;
}

+ (instancetype)alertViewWithStyle:(ZJAlertViewStyle)style {
    ZJAlertView *alertView = [[ZJAlertView alloc] init];
    alertView.style = style;
    return alertView;
}

+ (instancetype)alertInputViewWithTitle:(NSString *)title {
    ZJAlertView *alertView = [ZJAlertView alertViewWithStyle:ZJAlertViewStyleTextField];
    alertView.title = title;
    return alertView;
}

+ (instancetype)alertViewWithTitle:(NSString *)title {
    ZJAlertView *alertView = [ZJAlertView alertView];
    alertView.title = title;
    return alertView;
}

+ (instancetype)alertViewWithTitle:(NSString *)title message:(NSString *)message {
    ZJAlertView *alertView = [ZJAlertView alertViewWithTitle:title];
    alertView.message = message;
    return alertView;
}

#pragma mark -

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:[UIScreen mainScreen].bounds]) {
        super.backgroundColor = [UIColor clearColor];
        
        [self addSubview:self.maskView];
    }
    return self;
}

- (NSMutableArray<ZJAlertAction *> *)btnArray {
    if (!_btnArray) {
        _btnArray = [NSMutableArray array];
    }
    return _btnArray;
}

- (NSMutableArray<UIView *> *)lineViewArray {
    if (!_lineViewArray) {
        _lineViewArray = [NSMutableArray array];
    }
    return _lineViewArray;
}

- (UIView *)maskView
{
    if (!_maskView) {
        _maskView = [[UIView alloc] initWithFrame:self.bounds];
        _maskView.backgroundColor = [UIColor clearColor];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickedTapMaskView)];
        [_maskView addGestureRecognizer:tap];
    }
    return _maskView;
}

- (UIView *)alertView {
    if (!_alertView) {
        CGFloat width = 280.0/375*ZJScreenWidth();
        _alertView = [[UIView alloc] initWithFrame:CGRectMake((ZJScreenWidth()-width)/2, 0, width, 0)];
        _alertView.backgroundColor = [UIColor whiteColor];
        _alertView.layer.cornerRadius = 8;
        _alertView.layer.masksToBounds = YES;
        [self.maskView addSubview:_alertView];
    }
    return _alertView;
}

- (UIButton *)closeBtn {
    if (!_closeBtn) {
        _closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.alertView.zj_width-40, 0, 40, 40)];
        _closeBtn.backgroundColor = [UIColor clearColor];
        [_closeBtn setImage:[ZJBaseUtils imageNamed:@"icon_alertview_close"] forState:UIControlStateNormal];
        
        [_closeBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        [self.alertView addSubview:_closeBtn];
    }
    return _closeBtn;
}

- (UILabel *)titleLB {
    if (!_titleLB) {
        _titleLB = [[UILabel alloc] initWithFrame:CGRectMake(32, 0, self.alertView.zj_width-64, 20)];
        _titleLB.backgroundColor = [UIColor clearColor];
        _titleLB.textColor = ZJColorFromRGB(0x181E28);
        _titleLB.font = [UIFont boldSystemFontOfSize:16];
        _titleLB.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLB;
}

- (UILabel *)messageLB {
    if (!_messageLB) {
        _messageLB = [[UILabel alloc] initWithFrame:CGRectMake(24, 0, self.alertView.zj_width-24*2, 0)];
        _messageLB.backgroundColor = [UIColor clearColor];
        _messageLB.textColor = ZJColorFromRGB(0x5A6482);
        _messageLB.font = [UIFont systemFontOfSize:14];
        _messageLB.textAlignment = NSTextAlignmentLeft;
        _messageLB.numberOfLines = 0;
    }
    return _messageLB;
}

- (UIImageView *)titleImgView {
    if (!_titleImgView) {
        _titleImgView = [[UIImageView alloc] init];
        _titleImgView.backgroundColor = [UIColor clearColor];
        _titleImgView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _titleImgView;
}

- (UITextField *)inputTextField {
    if (!_inputTextField) {
        _inputTextField = [[UITextField alloc] initWithFrame:CGRectMake(24, 0, self.alertView.zj_width-48, 30)];
        _inputTextField.font = [UIFont systemFontOfSize:16];
        _inputTextField.textColor = ZJColorFromRGB(0x181E28);
        _inputTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _inputTextField.layer.borderWidth = 1;
        _inputTextField.layer.borderColor = ZJColorFromRGB(0xDCE0E8).CGColor;
        _inputTextField.layer.cornerRadius = 4;
        _inputTextField.layer.masksToBounds = YES;
        _inputTextField.returnKeyType = UIReturnKeyDone;
        _inputTextField.delegate = self;
        
        UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 12, 30)];
        _inputTextField.leftView = rightView;
        _inputTextField.leftViewMode = UITextFieldViewModeAlways;
        
        [self addSubview:_inputTextField];
    }
    
    return _inputTextField;
}

- (UIButton *)inputTextClearBtn {
    if (!_inputTextClearBtn) {
        _inputTextClearBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 24, 24)];
        [_inputTextClearBtn addTarget:self action:@selector(clickedInputTextAssistBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _inputTextClearBtn;
}

#pragma mark - 参数设置

- (void)setStyle:(ZJAlertViewStyle)style
{
    if (_style == style) return;
    
    if (style == ZJAlertViewStyleTextField) {
        [self.alertView addSubview:self.inputTextField];
    } else if (_inputTextField) {
        [self.inputTextField removeFromSuperview];
        _inputTextField = nil;
    }
    _style = style;
}

- (void)setTitle:(NSString *)title {
    _title = title;
    if (title) {
        self.titleLB.text = self.title;
        if (!self.titleLB.superview)
            [self.alertView addSubview:self.titleLB];
    } else if (_titleLB) {
        [self.titleLB removeFromSuperview];
        _titleLB = nil;
    }
}

- (void)setMessage:(NSString *)message {
    _message = message;
    if (message) {
        self.messageLB.text = self.message;
        if (!self.messageLB.superview)
            [self.alertView addSubview:self.messageLB];
    } else if (_messageLB) {
        [self.messageLB removeFromSuperview];
        _messageLB = nil;
    }
}

- (void)setTitleImageName:(NSString *)titleImageName {
    _titleImageName = titleImageName;
    if (titleImageName && ![titleImageName isEqualToString:@""]) {
        self.titleImgView.image = [UIImage imageNamed:titleImageName];
        if (!self.titleImgView.superview)
            [self.alertView insertSubview:self.titleImgView belowSubview:self.closeBtn];
    } else if (_titleImgView) {
        [self.titleImgView removeFromSuperview];
        _titleImgView = nil;
    }
}

- (void)setCloseImageName:(NSString *)closeImageName
{
    _closeImageName = closeImageName;
    [self.closeBtn setImage:closeImageName?[UIImage imageNamed:closeImageName]:nil forState:UIControlStateNormal];
}

- (void)setIsHideCloseBtn:(BOOL)isHideCloseBtn {
    self.closeBtn.hidden = isHideCloseBtn;
}

- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    self.alertView.backgroundColor = backgroundColor;
}

- (void)setCornerRadius:(CGFloat)cornerRadius
{
    _cornerRadius = cornerRadius;
    self.alertView.layer.cornerRadius = cornerRadius;
}

- (void)setMaskAlpha:(CGFloat)maskAlpha {
    _maskAlpha = maskAlpha;
    self.maskView.backgroundColor = ZJColorFromRrgWithAlpha(0x0, maskAlpha);
}

- (void)setTitleColor:(UIColor *)titleColor {
    _titleColor = titleColor;
    self.titleLB.textColor = titleColor;
}

- (void)setTitleFont:(UIFont *)titleFont {
    _titleFont = titleFont;
    self.titleLB.font = titleFont;
}

- (void)setMessageColor:(UIColor *)messageColor {
    _messageColor = messageColor;
    self.messageLB.textColor = messageColor;
}

- (void)setMessageFont:(UIFont *)messageFont {
    _messageFont = messageFont;
    self.messageLB.font = messageFont;
}

- (void)setTextFieldText:(NSString *)textFieldText {
    self.inputTextField.text = textFieldText;
}

- (NSString *)textFieldText {
    return self.inputTextField.text;
}

- (void)setKeyboardType:(UIKeyboardType)keyboardType {
    self.inputTextField.keyboardType = keyboardType;
}

- (void)setTextFieldTextColor:(UIColor *)textFieldTextColor {
    _textFieldTextColor = textFieldTextColor;
    self.inputTextField.textColor = textFieldTextColor;
}

- (void)setTextFieldTextFont:(UIFont *)textFieldTextFont {
    _textFieldTextFont = textFieldTextFont;
    self.inputTextField.font = textFieldTextFont;
}

- (void)setTextFieldClearImageName:(NSString *)textFieldClearImageName {
    _textFieldClearImageName = textFieldClearImageName;
    if (textFieldClearImageName) {
        [self.inputTextClearBtn setImage:[UIImage imageNamed:textFieldClearImageName] forState:UIControlStateNormal];
        self.inputTextField.clearButtonMode = UITextFieldViewModeNever;
        self.inputTextField.rightView = self.inputTextClearBtn;
        self.inputTextField.rightViewMode = UITextFieldViewModeWhileEditing;
    } else {
        self.inputTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.inputTextField.rightView = nil;
        self.inputTextField.rightViewMode = UITextFieldViewModeNever;
        _inputTextClearBtn = nil;
    }
}

- (void)setTextFieldAttributedString:(NSAttributedString *)textFieldAttributedString {
    _textFieldAttributedString = textFieldAttributedString;
    self.inputTextField.attributedPlaceholder = textFieldAttributedString;
}

- (void)setTextFieldLeftViewWidth:(CGFloat)textFieldLeftViewWidth {
    _textFieldLeftViewWidth = textFieldLeftViewWidth;
    if (textFieldLeftViewWidth <= 0) {
        self.inputTextField.leftViewMode = UITextFieldViewModeNever;
    } else {
        if (self.inputTextField.leftView) {
            self.inputTextField.leftView.zj_width = textFieldLeftViewWidth;
        }
        self.inputTextField.leftViewMode = UITextFieldViewModeAlways;
    }
}

- (void)setTextFieldDelegate:(id<UITextFieldDelegate>)textFieldDelegate {
    self.inputTextField.delegate = textFieldDelegate;
}

#pragma mark -

- (void)layoutSubviews
{
    CGFloat bottom = 0;
    
    if (_titleImgView) {
        //        CGSize size = self.titleImgView.image.size;
        //        CGFloat height = size.height > 64 ? 64 : size.height;
        self.titleImgView.zj_top = _titleLB ? 32 : 40;
        self.titleImgView.zj_size = _titleLB ? CGSizeMake(50, 50) : CGSizeMake(64, 64);
        bottom = self.titleImgView.zj_bottom;
        self.titleImgView.zj_centerX = self.alertView.zj_width/2;
        
        if (self.style == ZJAlertViewStyleTextField) {
            _titleImgView.hidden = YES;
            bottom = 0;
        } else {
            _titleImgView.hidden = NO;
        }
    }
    
        
    if (_titleLB) {
        CGSize size = [self.titleLB.text zj_sizeWithFont:self.titleLB.font maxSize:CGSizeMake(self.titleLB.zj_width, self.titleLB.zj_height*2)];
        if (size.height > self.titleLB.zj_height) {
            self.titleLB.numberOfLines = 2;
            self.titleLB.zj_height = size.height;
        }
        self.titleLB.zj_top = bottom + (bottom > 0 ? 16 : 24);
        bottom = self.titleLB.zj_bottom;
    }
    
    if (self.style == ZJAlertViewStyleTextField) {
        self.inputTextField.zj_top = bottom + (bottom > 0 ? 16 : 24);
        bottom = self.inputTextField.zj_bottom + 8;
    } else {
        if (_messageLB) {
            CGSize size = [self.messageLB.text zj_sizeWithFont:self.messageLB.font maxSize:CGSizeMake(self.messageLB.zj_width, 400)];
            if (_titleLB && _titleImgView) {
                bottom += 12;
            } else if (_titleLB || _titleImgView) {
                bottom += 16;
            } else {
                bottom += 40;
            }
            if (size.width >= self.messageLB.zj_width - 1) {
                self.messageLB.textAlignment = NSTextAlignmentLeft;
            } else {
                self.messageLB.textAlignment = NSTextAlignmentCenter;
            }
            
            self.messageLB.zj_top = bottom;
            self.messageLB.zj_height = size.height;
            bottom = self.messageLB.zj_bottom;
        }
    }
    
    for (int i=0; i<self.btnArray.count; i++) {
        if (self.btnArray.count == 2) {
            bottom += 16;
            
            UIView *line1 = [self.lineViewArray objectAtIndex:0];
            line1.frame = CGRectMake(0, bottom, self.alertView.zj_width, 0.5);
            
            UIView *line2 = [self.lineViewArray objectAtIndex:1];
            line2.frame = CGRectMake(self.alertView.zj_width/2-0.25, bottom, 0.5, 44);
            bottom += 0.5;
            
            ZJAlertAction *btn1 = [self.btnArray objectAtIndex:0];
            btn1.frame = CGRectMake(0, bottom, self.alertView.zj_width/2-0.5, 44);
            
            ZJAlertAction *btn2 = [self.btnArray objectAtIndex:1];
            btn2.frame = CGRectMake(self.alertView.zj_width/2-0.25, bottom, self.alertView.zj_width/2-0.5, 44);
            
            bottom += 44;
            break;
        } else {
            bottom += 16;
            UIView *line1 = [self.lineViewArray objectAtIndex:i];
            line1.frame = CGRectMake(0, bottom, self.alertView.zj_width, 0.5);
            bottom += 0.5;
                
            ZJAlertAction *btn = [self.btnArray objectAtIndex:i];
            btn.frame = CGRectMake(0, bottom, self.alertView.zj_width, 44);
            bottom += 44;
        }
    }
    
    if (self.btnArray.count == 0) {
        bottom += 20;
    }
    
    self.alertView.zj_height = bottom;
    self.alertView.zj_centerY = self.zj_centerY;
}

- (void)addAction:(ZJAlertAction *)action {
    [self.btnArray addObject:action];
    [self.alertView addSubview:action];
    
    [action addTarget:self action:@selector(clickedAlertAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = ZJColorFromRGB(0xDCE0E8);
    [self.lineViewArray addObject:lineView];
    [self.alertView addSubview:lineView];
    
    if (self.btnArray.count == 2) { //2个时添加竖线
        lineView = [[UIView alloc] init];
        lineView.backgroundColor = ZJColorFromRGB(0xDCE0E8);
        [self.lineViewArray addObject:lineView];
        [self.alertView addSubview:lineView];
    }
}

- (void)clickedAlertAction:(ZJAlertAction *)action {
    if (action.handler) {
        action.handler(action);
    }
    [self dismiss];
}

- (void)clickedTapMaskView {
    if (self.style == ZJAlertViewStyleTextField) {
        [self.inputTextField resignFirstResponder];
    }
}

- (void)clickedInputTextAssistBtnAction:(UIButton *)btn
{
    if (self.inputTextField.clearButtonMode == UITextFieldViewModeNever) {
        self.inputTextField.text = @"";
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self clickedTapMaskView];
    return YES;
}

#pragma mark -

- (void)show
{
    self.alpha = 0;
    [ZJScreen.keyWindow addSubview:self];
    if (self.animationStyle == ZJAlertViewStyleAnimation2) {
        [self showAnimation2WithLayer:self.alertView.layer durationTime:0.3];
    } else {
        [self showAnimation1WithLayer:self.alertView.layer durationTime:0.3];
    }
    
    @weakify(self);
    [UIView animateWithDuration:0.3 animations:^{
        @strongify(self);
        self.alpha = 1;
    }];
}

- (void)dismiss
{
    if (self.animationStyle == ZJAlertViewStyleAnimation2) {
        [self hideAnimation2WithLayer:self.alertView.layer durationTime:0.25];
    } else {
        [self hideAnimation1WithLayer:self.alertView.layer durationTime:0.25];
    }
    
    @weakify(self);
    [UIView animateWithDuration:0.25 animations:^{
        @strongify(self);
        self.alpha = 0;
    } completion:^(BOOL finished) {
        @strongify(self);
        [self removeFromSuperview];
        [self.btnArray removeAllObjects];
        [self.lineViewArray removeAllObjects];
    }];
}

#pragma mark - 动画样式

- (void)showAnimation1WithLayer:(CALayer *)layer durationTime:(double)duration
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = duration;
    NSValue *value1 = [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1)];
    NSValue *value2 = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.15, 1.15, 1)];
    NSValue *value3 = [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.92, 0.92, 1)];
    NSValue *value4 = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1, 1, 1)];
    animation.values = @[value1,value2,value3,value4];
    [layer addAnimation:animation forKey:nil];
}

- (void)hideAnimation1WithLayer:(CALayer *)layer durationTime:(double)duration
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = duration;
    NSValue *value1 = [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1)];
    NSValue *value2 = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1, 1, 1)];
    animation.values = @[value2,value1];
    [layer addAnimation:animation forKey:nil];
}

- (void)showAnimation2WithLayer:(CALayer *)layer durationTime:(double)duration
{
    CAKeyframeAnimation *popAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    popAnimation.duration = duration;
    popAnimation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2f, 1.2f, 1.0f)], [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1f, 1.1f, 1.0f)], [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.05f, 1.05f, 1.05f)], [NSValue valueWithCATransform3D:CATransform3DIdentity]];
    popAnimation.keyTimes = @[@0.0f, @0.2f, @0.4f, @1.0f];
    popAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [layer addAnimation:popAnimation forKey:nil];
}

- (void)hideAnimation2WithLayer:(CALayer *)layer durationTime:(double)duration
{
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.toValue = [NSNumber numberWithFloat:0.4];
    scaleAnimation.duration = duration;
    scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [layer addAnimation:scaleAnimation forKey:nil];
}

@end
