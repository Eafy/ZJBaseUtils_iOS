//
//  ZJMessageBoard.m
//  ZJBaseUtils
//
//  Created by eafy on 2020/12/14.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import <ZJBaseUtils/ZJMessageBoard.h>
#import <ZJBaseUtils/UIColor+ZJExt.h>
#import <ZJBaseUtils/UIView+ZJFrame.h>
#import <ZJBaseUtils/ZJLocalization.h>
#import <ZJBaseUtils/NSString+ZJExt.h>

@interface ZJMessageBoard () <UITextViewDelegate>

@property (nonatomic,strong) UILabel *countLB;
@property (nonatomic,assign) CGSize msgContentSize;

@end

@implementation ZJMessageBoard

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.titleEdgeInsets = UIEdgeInsetsMake(18, 16, 0, 16);
        self.msgEdgeInsets = UIEdgeInsetsMake(12, 8, 12, 16);
        
        _countColor = ZJColorFromRGB(0x8690A9);
        _countSpecialColor = ZJColorFromRGB(0xF45C5C);
        _countFont = [UIFont systemFontOfSize:14];
        _isCountMaxWarning = YES;
        
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
        _msgTextView.delegate = self;
    }
    return _msgTextView;
}

- (UILabel *)countLB {
    if (!_countLB) {
        _countLB = [[UILabel alloc] init];
        _countLB.backgroundColor = [UIColor clearColor];
        _countLB.textColor = self.countColor;
        _countLB.font = self.countFont;
        _countLB.textAlignment = NSTextAlignmentRight;
    }
    return _countLB;
}

- (void)setMsgMaxCount:(NSUInteger)msgMaxCount {
    _msgMaxCount = msgMaxCount;
    [self jmMessageBoardTextViewTextDidChange:[NSNotification notificationWithName:UITextViewTextDidChangeNotification object:self.msgTextView]];
}

- (void)setCountColor:(UIColor *)countColor {
    _countColor = countColor;
    self.countLB.textColor = countColor;
}

- (void)setCountFont:(UIFont *)countFont {
    _countFont = countFont;
    self.countLB.font = countFont;
}

- (void)setIsHideCount:(BOOL)isHideCount {
    _isHideCount = isHideCount;
    self.countLB.hidden = isHideCount;
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
    
    if (!self.isHideCount) {
        self.countLB.zj_bottom = self.zj_height - self.msgEdgeInsets.bottom;
        self.countLB.zj_right = self.msgTextView.zj_right;
    }
}

- (void)jmMessageBoardTextViewTextDidChange:(NSNotification *)noti {
    if (noti.object == self.msgTextView) {
        if (self.msgMaxCount > 0 && self.msgTextView.text.length > self.msgMaxCount) {
            self.msgTextView.text = [self.msgTextView.text substringToIndex:self.msgMaxCount];
        }
        
        NSString *str1 = [NSString stringWithFormat:@"/%lu", (unsigned long)self.msgMaxCount];
        NSString *str2 = [NSString stringWithFormat:@"%lu%@", (unsigned long)self.msgTextView.text.length, self.msgMaxCount > 0 ? str1 : @""];
        NSArray *specialStrArray = (self.isCountMaxWarning && self.msgTextView.text.length >= self.msgMaxCount) ? @[[NSString stringWithFormat:@"%lu", (unsigned long)self.msgTextView.text.length]] : nil;
        self.countLB.attributedText = nil;
        self.countLB.attributedText = [str2 zj_stringWithColor:self.countLB.textColor specialColor:self.countSpecialColor specialStrings:specialStrArray lineSpacing:0 font:self.countLB.font alignment:NSTextAlignmentRight];
        [self.countLB sizeToFit];
        
        if (self.isAutoFrame && self.msgTextView.zj_height > 0) {
            if (CGSizeEqualToSize(self.msgContentSize, CGSizeZero)) {
                self.msgContentSize = self.msgTextView.contentSize;
            }
            
            if (self.msgTextView.contentSize.height > self.msgContentSize.height && self.msgTextView.contentSize.height > self.msgTextView.zj_height) {
                self.zj_height += self.msgTextView.font.lineHeight;
                self.msgTextView.zj_height +=self.msgTextView.font.lineHeight;
                self.msgContentSize = self.msgTextView.contentSize;
            } else if (self.msgTextView.contentSize.height + self.msgTextView.font.lineHeight < self.msgContentSize.height) {
                self.zj_height -= self.msgTextView.font.lineHeight;
                self.msgTextView.zj_height -=self.msgTextView.font.lineHeight;
                self.msgContentSize = self.msgTextView.contentSize;
            }
        }
    }
}

#pragma mark - UITextViewDelegate

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if (self.msgMaxCount > 0 && textView.text.length + text.length > self.msgMaxCount) {
        return NO;
    }
    
    return YES;
}

@end
