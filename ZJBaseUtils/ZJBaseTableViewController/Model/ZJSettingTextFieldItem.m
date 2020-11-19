//
//  ZJSettingTextFieldItem.m
//  ZJBaseUtils
//
//  Created by eafy on 2020/9/29.
//  Copyright © 2020 ZJ. All rights reserved.
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
    if (super.accessoryView.tag != self.type) {
        super.accessoryView = self.detailTextField;
        super.accessoryView.tag = self.type;
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
        
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        if (self.placeholderColor) {
            [dic setValue:self.placeholderColor forKey:NSForegroundColorAttributeName];
        }
        if (self.placeholderFont) {
            [dic setValue:self.placeholderFont forKey:NSFontAttributeName];
        }
        if (dic.count > 0) {
            NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:self.placeholder attributes:dic];
            _detailTextField.attributedPlaceholder = attrString;
        }
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

- (void)setClearBtnImgName:(NSString *)clearBtnImgName
{
    if (!clearBtnImgName || [clearBtnImgName isEqualToString:@""]) {
        return;
    }
    
    _clearBtnImgName = clearBtnImgName;
    UIButton *button = [self.detailTextField valueForKey:@"_clearButton"];
    [button setImage:[UIImage imageNamed:clearBtnImgName] forState:UIControlStateNormal];
}

#pragma mark - 重载差异化

- (void)updateDiffDataWithCell:(ZJSettingTableViewCell *)cell
{
    [cell.textLabel sizeToFit];
    self.detailTextField.zj_width = cell.zj_width - cell.textLabel.zj_width - 50;
    self.detailTextField.zj_height = cell.contentView.zj_height/2.0;
}

- (void)updateDiffConfigWithCell:(ZJSettingTableViewCell *)cell config:(ZJBaseTVConfig *)config
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
