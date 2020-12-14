//
//  ZJTextView.m
//  ZJBaseUtils
//
//  Created by eafy on 2020/12/9.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import "ZJTextView.h"

@interface ZJTextView ()

@end

@implementation ZJTextView

- (instancetype)initWithFrame:(CGRect)frame textContainer:(NSTextContainer *)textContainer
{
    if (self = [super initWithFrame:frame textContainer:textContainer]) {
        [self initDefaultData];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)initDefaultData {
    _placeLeftSpace = 8.0;
    _placeTopSpace = 8.0;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(jmTextViewTextDidChange:) name:UITextViewTextDidChangeNotification object:self];
}

- (void)jmTextViewTextDidChange:(NSNotification *)noti {
    if (noti.object == self) {
        [self setNeedsDisplay];
    }
}

#pragma mark -

- (void)layoutSubviews {
    [super layoutSubviews];
    [self setNeedsDisplay];
}

- (void)setAttributedText:(NSAttributedString *)attributedText {
    self.placeholderString = attributedText;
    [self setNeedsDisplay];
}

- (void)setText:(NSString *)text {
    super.text = text;
    [self setNeedsDisplay];
}

- (void)placeholderWithText:(NSString *)str color:(UIColor *)color font:(UIFont * _Nullable)font
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if (color) {
        [dic setValue:color forKey:NSForegroundColorAttributeName];
    }
    if (font) {
        [dic setValue:font forKey:NSFontAttributeName];
    }
    
    self.placeholderString = [[NSAttributedString alloc] initWithString:str attributes:dic];
    [self setNeedsLayout];
}

#pragma mark -

- (void)drawRect:(CGRect)rect {
    if (self.text.length > 0 ||
        !self.placeholderString ||
        self.placeholderString.string.length == 0) {
        return;
    }

    CGRect frame = rect;
    frame.origin.x = self.placeLeftSpace;
    frame.origin.y = self.placeTopSpace;
    frame.size.width -= 2 * rect.origin.x;

    NSRange range = NSMakeRange(0, self.placeholderString.string.length);
    [self.placeholderString.string drawInRect:frame withAttributes:[self.placeholderString attributesAtIndex:0 effectiveRange:&range]];
}

@end
