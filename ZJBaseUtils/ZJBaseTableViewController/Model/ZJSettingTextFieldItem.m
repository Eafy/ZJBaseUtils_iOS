//
//  ZJSettingTextFieldItem.m
//  ZJBaseUtils
//
//  Created by eafy on 2020/9/29.
//  Copyright © 2020 ZJ<lizhijian_21@163.com>. All rights reserved.
//

#import "ZJSettingTextFieldItem.h"
#import "ZJSettingTableViewCellExt.h"
#import "UIView+ZJFrame.h"
#import "UIColor+ZJExt.h"
#import "ZJScreen.h"

@interface ZJSettingTextFieldItem () <UITextFieldDelegate>

@end

@implementation ZJSettingTextFieldItem
@dynamic text;

- (ZJSettingItemType)type
{
    return ZJSettingItemTypeTextFidld;
}

- (UIView *)accessoryView
{
    if (!super.accessoryView) {
        super.accessoryView = self.detailTextField;
    }
    
    return super.self.detailTextField;
}

- (UITextField *)detailTextField
{
    if (!_detailTextField) {
        _detailTextField = [[UITextField alloc] init];
        _detailTextField.textColor = ZJColorFromHex(@"#181E28");
        _detailTextField.font = [UIFont systemFontOfSize:14.0f];
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

- (void)setText:(NSString *)text
{
    self.detailTextField.text = text;
}

- (NSString *)text
{
    return self.detailTextField.text;
}

#pragma mark - 重载差异化

- (void)updateDiffDataWithCell:(ZJSettingTableViewCell *)cell
{
    self.detailTextField.zj_width = cell.contentView.zj_width/3.0;
    self.detailTextField.zj_height = cell.contentView.zj_height/2.0;
}

- (void)updateDiffCinfigWithCell:(ZJSettingTableViewCell *)cell config:(ZJBaseTableViewConfig *)config
{
    if (config.textFieldTitleColor) self.detailTextField.textColor = config.textFieldTitleColor;
    if (config.textFieldTitleFont) self.detailTextField.font = config.textFieldTitleFont;
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField endEditing:YES];
    return YES;
}

@end
