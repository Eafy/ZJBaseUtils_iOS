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

- (void)setText:(NSString *)text {
    super.text = text;
    [self setNeedsDisplay];
}

- (void)attributedText:(NSString *)text normalColor:(UIColor *)normalColor specialColor:(UIColor *)specialColor specialStrings:(NSArray *)specialStrings lineSpacing:(CGFloat)lineSpace font:(UIFont *)font alignment:(NSTextAlignment)alignment hasUnderline:(BOOL)hasUnderline
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.alignment = alignment;
    paragraphStyle.maximumLineHeight = 60;  //最大的行高
    paragraphStyle.lineSpacing = lineSpace;  //行自定义行高度
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:text attributes:@{NSForegroundColorAttributeName:normalColor, NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle}];
    if (specialColor) {
        for (int i=0; i<specialStrings.count; i++) {
            NSString *specialString = [specialStrings objectAtIndex:i];
            NSRange range = [text rangeOfString:specialString];
            [str addAttribute:NSForegroundColorAttributeName value:specialColor range:range];
            NSURL *url = [NSURL URLWithString:specialString];
            if (!url) {
                url = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"%d",i]];
            }
            [str addAttribute:NSLinkAttributeName value:url range:range];
            [str addAttribute:NSFontAttributeName value:font range:range];
            [str addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithBool:hasUnderline] range:range];
        }
    }
    self.attributedText = str;
    self.linkTextAttributes = [NSDictionary dictionary];
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
        self.attributedText.length > 0 ||
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
