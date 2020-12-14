//
//  ZJMessageBoard.m
//  ZJBaseUtils
//
//  Created by eafy on 2020/12/14.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import "ZJMessageBoard.h"
#import "UIColor+ZJExt.h"
#import "UIView+ZJFrame.h"
#import "ZJLocalization.h"
#import "NSString+ZJExt.h"

@interface ZJMessageBoard ()

@property (nonatomic,strong) UILabel *countLB;

@end

@implementation ZJMessageBoard

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.titleEdgeInsets = UIEdgeInsetsMake(18, 16, 0, 16);
        self.msgEdgeInsets = UIEdgeInsetsMake(12, 8, 12, 16);
        
        [self addSubview:self.titleLB];
        [self addSubview:self.msgTextView];
        [self addSubview:self.countLB];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(jmMessageBoardTextViewTextDidChange:) name:UITextViewTextDidChangeNotification object:self.msgTextView];
    }
    
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 

- (UILabel *)titleLB {
    if (!_titleLB) {
        _titleLB = [[UILabel alloc] init];
        _titleLB.backgroundColor = [UIColor clearColor];
        _titleLB.textColor = ZJColorFromRGB(0x181E28);
        _titleLB.font = [UIFont boldSystemFontOfSize:16];
        _titleLB.text = @"留言".localized;
        [_titleLB sizeToFit];
    }
    return _titleLB;
}

- (ZJTextView *)msgTextView {
    if (!_msgTextView) {
        _msgTextView = [[ZJTextView alloc] init];
        _msgTextView.textColor = ZJColorFromRGB(0x181E28);
        _msgTextView.font = [UIFont systemFontOfSize:14];
        [_msgTextView placeholderWithText:@"请输入留言".localized color:ZJColorFromRGB(0x8690A9) font:[UIFont systemFontOfSize:14]];
    }
    return _msgTextView;
}

- (UILabel *)countLB {
    if (!_countLB) {
        _countLB = [[UILabel alloc] init];
        _countLB.backgroundColor = [UIColor clearColor];
        _countLB.textColor = ZJColorFromRGB(0x8690A9);
        _countLB.font = [UIFont boldSystemFontOfSize:14];
        _countLB.textAlignment = NSTextAlignmentRight;
    }
    return _countLB;
}

- (void)setMsgMaxCount:(NSUInteger)msgMaxCount {
    _msgMaxCount = msgMaxCount;
    
    NSString *str = [NSString stringWithFormat:@"0/%lu", msgMaxCount];
    self.countLB.attributedText = [str zj_stringWithColor:_countLB.textColor specialColor:ZJColorFromRGB(0x8690A9) specialStrings:nil lineSpacing:0 font:_countLB.font alignment:NSTextAlignmentRight];
}

#pragma mark -

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.titleLB sizeToFit];
    self.titleLB.frame = CGRectMake(self.titleEdgeInsets.left, self.titleEdgeInsets.top, self.titleLB.zj_width, self.titleLB.zj_height);
    
    self.msgTextView.zj_left = self.titleLB.zj_right + self.titleEdgeInsets.right + self.msgEdgeInsets.left;
    self.msgTextView.zj_width = self.zj_width - self.msgTextView.zj_left - self.msgEdgeInsets.right;
    self.msgTextView.zj_top = self.msgEdgeInsets.top;
    self.msgTextView.zj_height = self.zj_height - self.msgEdgeInsets.top - self.msgEdgeInsets.bottom;
    
    self.countLB.zj_bottom = self.msgTextView.zj_bottom;
    self.countLB.zj_width = 100;
    self.countLB.zj_right = self.msgTextView.zj_right;
}

- (void)jmMessageBoardTextViewTextDidChange:(NSNotification *)noti {
    if (noti.object == self.msgTextView) {
        NSString *str1 = [NSString stringWithFormat:@"/%lu", (unsigned long)self.msgMaxCount];
        NSString *str2 = [NSString stringWithFormat:@"%lu%@", (unsigned long)self.msgTextView.text.length, self.msgMaxCount > 0 ? str1 : @""];
        
        self.countLB.attributedText = [str2 zj_stringWithColor:self.countLB.textColor specialColor:ZJColorFromRGB(0x8690A9) specialStrings:@[[NSString stringWithFormat:@"%lu", (unsigned long)self.msgTextView.text.length]] lineSpacing:0 font:_countLB.font alignment:NSTextAlignmentRight];
    }
}

@end
