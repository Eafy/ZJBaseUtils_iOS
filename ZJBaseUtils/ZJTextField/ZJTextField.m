//
//  ZJTextField.m
//  ZJBaseUtils
//
//  Created by eafy on 2020/11/30.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import "ZJTextField.h"
#import "UIView+ZJFrame.h"

@interface ZJTextField ()

@property (nonatomic,strong) UIButton *clearBtn;

@end


@implementation ZJTextField

- (void)deleteBackward {
    if ([self.zj_delegate respondsToSelector:@selector(textFieldWillDeleteBackward:)]) {
        [self.zj_delegate textFieldWillDeleteBackward:self];
    }
    [super deleteBackward];
    if ([self.zj_delegate respondsToSelector:@selector(textFieldDidDeleteBackward:)]) {
        [self.zj_delegate textFieldDidDeleteBackward:self];
    }
}

- (CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectMake(bounds.origin.x + self.textInnerMargin + self.leftView.zj_right, bounds.origin.y, bounds.size.width, bounds.size.height);
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    return CGRectMake(bounds.origin.x + self.textInnerMargin + self.leftView.zj_right, bounds.origin.y, bounds.size.width, bounds.size.height);
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (_clearBtn) {
        self.clearBtn.bounds = CGRectMake(0, 0, self.bounds.size.height-2, self.bounds.size.height-2);
    }
}

- (UIButton *)clearBtn {
    if (!_clearBtn) {
        _clearBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 24, 24)];
        [_clearBtn addTarget:self action:@selector(clickedClearBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _clearBtn;
}

#pragma mark -

- (void)setClearBtnImageName:(NSString *)clearBtnImageName {
    _clearBtnImageName = clearBtnImageName;
    if (clearBtnImageName) {
        [self.clearBtn setImage:[UIImage imageNamed:clearBtnImageName] forState:UIControlStateNormal];
        self.rightView = self.clearBtn;
        self.clearButtonMode = UITextFieldViewModeNever;
        self.rightViewMode = UITextFieldViewModeWhileEditing;
    } else {
        self.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.rightViewMode = UITextFieldViewModeNever;
        self.rightView = nil;
        _clearBtn = nil;
    }
}

- (void)placeholderWithText:(NSString *)str color:(UIColor *)color font:(UIFont *)font {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if (color) {
        [dic setValue:color forKey:NSForegroundColorAttributeName];
    }
    if (font) {
        [dic setValue:font forKey:NSFontAttributeName];
    }
    
    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:str attributes:dic];
    [self setNeedsLayout];
}

#pragma mark -

- (void)clickedClearBtnAction:(UIButton *)btn
{
    if (self.clearButtonMode == UITextFieldViewModeNever) {
        self.text = @"";
    }
}

@end
