//
//  ZJTextField.m
//  ZJBaseUtils
//
//  Created by eafy on 2020/11/30.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import "ZJTextField.h"

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

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self setupLeftViewWidth];
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

- (void)setupLeftViewWidth {
    if (self.leftWidth <= 0) {
        self.leftView = nil;
        self.leftViewMode = UITextFieldViewModeNever;
    } else {
        if (self.leftView) {
            self.leftView.frame = CGRectMake(0, 0, self.leftWidth, self.leftView.bounds.size.height);
        } else {
            UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.leftWidth, self.bounds.size.height)];
            self.leftView = rightView;
        }
        self.leftViewMode = UITextFieldViewModeAlways;
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
