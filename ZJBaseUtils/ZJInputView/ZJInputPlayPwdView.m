//
//  ZJInputPlayPwdView.m
//  ZJBaseUtils
//
//  Created by eafy on 2020/10/14.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import <ZJBaseUtils/ZJInputPlayPwdView.h>
#import <ZJBaseUtils/ZJTextField.h>
#import <ZJBaseUtils/UIColor+ZJExt.h>

@interface ZJInputPlayPwdView() <UITextFieldDelegate, ZJTextFieldDelegate>

@property (nonatomic,strong) NSMutableArray *textFieldsArray;
@property (nonatomic,strong) NSMutableArray *textArray;
/// 0：首次，1：向前，2：向后
@property (nonatomic,assign) NSInteger isJumpType;

@end

@implementation ZJInputPlayPwdView


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _textColor = ZJColorFromRGB(0x181E28);
        _textFont = [UIFont boldSystemFontOfSize:16];
        _borderColor = ZJColorFromRGB(0xBCC4D4);
        _borderWidth = 0.5;
        _cornerRadius = 4;
        _isLinearinput = YES;
        _inputSize = CGSizeMake(46, 46);
        _keyboardType = UIKeyboardTypeNumberPad;
        
        self.inputMaxCount = 6;
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat margin = (self.bounds.size.width - (self.inputMaxCount * self.inputSize.width)) / (self.inputMaxCount + 1);
    for (int i = 0; i < self.inputMaxCount; i++) {
        ZJTextField *inputTextField = [self.textFieldsArray objectAtIndex:i];
        inputTextField.frame = CGRectMake(i * (self.inputSize.width + margin) + margin, self.bounds.size.height*0.5-self.inputSize.height*0.5, self.inputSize.width, self.inputSize.height);
        inputTextField.secureTextEntry = !self.isSecureStar;
    }
}

- (NSMutableArray *)textFieldsArray
{
    if (!_textFieldsArray) {
        _textFieldsArray = [NSMutableArray array];
    }
    return _textFieldsArray;
}

- (NSMutableArray *)textArray
{
    if (!_textArray) {
        _textArray = [NSMutableArray arrayWithCapacity:self.inputMaxCount];
    }
    return _textArray;
}

- (void)setInputMaxCount:(NSUInteger)inputMaxCount
{
    _inputMaxCount = inputMaxCount;
    
    for (ZJTextField *textField in self.textFieldsArray) {
        [textField removeFromSuperview];
    }
    [self.textFieldsArray removeAllObjects];
    
    for (int i=0; i<inputMaxCount; i++) {
        ZJTextField *inputTextField = [[ZJTextField alloc] init];
        inputTextField.textColor = self.textColor;
        inputTextField.font = self.textFont;
        inputTextField.secureTextEntry = YES;
        inputTextField.layer.borderColor = self.borderColor.CGColor;
        inputTextField.layer.borderWidth = self.borderWidth;
        inputTextField.layer.cornerRadius = self.cornerRadius;
        inputTextField.layer.masksToBounds = YES;
        inputTextField.tag = i;
        inputTextField.textAlignment = NSTextAlignmentCenter;
        inputTextField.keyboardType = self.keyboardType;
        inputTextField.delegate = self;
        inputTextField.zj_delegate = self;
        [self addSubview:inputTextField];
        [self.textFieldsArray addObject:inputTextField];
    }
}

#pragma mark -

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (self.isLinearinput && !self.isJumpType && !textField.isFirstResponder) {
        NSUInteger index = self.textArray.count;
        if (index >= self.inputMaxCount) {  //判断是否点击最后一个
            index = self.inputMaxCount - 1;
        }
        if (textField.tag == index) {    //判断是自己
            return YES;
        }
        
        ZJTextField *textFieldT = self.textFieldsArray[index];
        [textFieldT becomeFirstResponder];
        return NO;
    }
    self.isJumpType = 0;
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    self.textArray[textField.tag] = string;
    [self checkTextFieldsChange];
    if (string.length > 0) {
        textField.text = self.isSecureStar ? @"*" : string;

        if (textField.tag + 1 < self.textFieldsArray.count) {
            self.isJumpType = 1;    //向前走
            ZJTextField *textFieldT = self.textFieldsArray[textField.tag + 1];
            [textFieldT becomeFirstResponder];
        } else {
            return NO;
        }
    }
    
    return YES;
}

- (void)textFieldWillDeleteBackward:(ZJTextField *)textField
{
    if (textField.text.length == 0) {
        if (textField.tag - 1 >= 0) {
            self.isJumpType = 2;    //向后走
            ZJTextField *textFieldT = self.textFieldsArray[textField.tag - 1];
            [textFieldT becomeFirstResponder];
        }
    }
}

- (void)checkTextFieldsChange
{
    NSMutableString *str = [NSMutableString string];
    for (NSString *strT in self.textArray) {
        if (strT) {
            [str appendString:strT];
        }
    }
    NSLog(@"Input string:%@", str);
    if (_inputTextFieldChangeHandler) {
        self.inputTextFieldChangeHandler(str);
    }
}

@end
