//
//  ZJSettingTextFieldItem.m
//  ZJBaseUtils
//
//  Created by eafy on 2020/9/29.
//  Copyright © 2020 ZJ<lizhijian_21@163.com>. All rights reserved.
//

#import "ZJSettingTextFieldItem.h"

@interface ZJSettingTextFieldItem () <UITextFieldDelegate>

@end

@implementation ZJSettingTextFieldItem

- (ZJSettingItemType)type
{
    return ZJSettingItemTypeTextFidld;
}

- (UITextField *)detailTextField
{
    if (!_detailTextField) {
        _detailTextField = [[UITextField alloc] init];
        _detailTextField.backgroundColor = [UIColor clearColor];
        _detailTextField.textAlignment = NSTextAlignmentRight;
        _detailTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _detailTextField.returnKeyType = UIReturnKeyDone;
        _detailTextField.delegate = self;
    }
    
    return _detailTextField;
}

- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = placeholder;
    self.detailTextField.placeholder = placeholder;
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField endEditing:YES];
    return YES;
}

@end
