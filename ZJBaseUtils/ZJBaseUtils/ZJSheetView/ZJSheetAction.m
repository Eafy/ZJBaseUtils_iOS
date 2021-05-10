//
//  ZJSheetAction.m
//  ZJBaseUtils
//
//  Created by eafy on 2020/12/14.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import "ZJSheetAction.h"
#import "UIColor+ZJExt.h"
#import "UIView+ZJExt.h"

@interface ZJSheetAction ()

@property (nonatomic,strong) UILabel *detailLB;

@end

@implementation ZJSheetAction

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
    }
    
    return self;
}

- (UILabel *)detailLB {
    if (!_detailLB) {
        _detailLB = [[UILabel alloc] init];
        _detailLB.backgroundColor = [UIColor clearColor];
        _detailLB.textAlignment = NSTextAlignmentCenter;
    }
    return _detailLB;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (self.style == ZJSheetActionStyleDetail && _detailTitle && self.bounds.size.width > 0) {
        self.titleLabel.frame = CGRectMake(self.titleLabel.frame.origin.x, self.bounds.size.height/2-self.titleLabel.bounds.size.height, self.titleLabel.bounds.size.width, self.titleLabel.bounds.size.height);
        self.detailLB.frame = CGRectMake(0, self.bounds.size.height/2+4, self.bounds.size.width, self.detailLB.bounds.size.height);
    }
}

#pragma mark -

- (void)setTitle:(NSString *)title
{
    _title = title;
    [self setTitle:title forState:UIControlStateNormal];
}

- (void)setTitleColor:(UIColor *)titleColor
{
    _titleColor = titleColor;
    [self setTitleColor:titleColor forState:UIControlStateNormal];
}

- (void)setTitleFont:(UIFont *)titleFont
{
    _titleFont = titleFont;
    self.titleLabel.font = titleFont;
}

- (void)setDetailTitle:(NSString *)detailTitle {
    _detailTitle = detailTitle;
    self.detailLB.text = detailTitle;
    
    if (detailTitle && !_detailLB.superview) {
        [self insertSubview:self.detailLB aboveSubview:self.titleLabel];
        [self.detailLB sizeToFit];
    } else if (!detailTitle && _detailLB) {
        [self.detailLB removeFromSuperview];
        _detailLB = nil;
    }
}

- (void)setDetailTitleColor:(UIColor *)detailTitleColor {
    _detailTitleColor = detailTitleColor;
    self.detailLB.textColor = detailTitleColor;
}

- (void)setDetailTitleFont:(UIFont *)detailTitleFont {
    _detailTitleFont = detailTitleFont;
    self.detailLB.font = detailTitleFont;
}

- (void)setHeight:(CGFloat)height {
    _height = height;
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, height);
}

#pragma mark -

+ (instancetype)actionWithTitle:(NSString * _Nullable)title style:(ZJSheetActionStyle)style handler:(void (^ __nullable)(ZJSheetAction *action))handler {
    ZJSheetAction *btn = [[ZJSheetAction alloc] init];
    btn.style = style;
    btn.title = title;
    btn.handler = handler;
    btn.titleColor = ZJColorFromRGB(0x181E28);
    btn.titleFont = [UIFont systemFontOfSize:16];
    btn.height = 48;
    return btn;
}

+ (instancetype)actionDefaultWithTitle:(nullable NSString *)title handler:(void (^ __nullable)(ZJSheetAction *action))handler {
    ZJSheetAction *btn = [ZJSheetAction actionWithTitle:title style:ZJSheetActionStyleDefault handler:handler];
    btn.titleFont = [UIFont systemFontOfSize:16];
    return btn;
}

+ (instancetype)actionDetailWithTitle:(nullable NSString *)title detail:(NSString *)detail handler:(void (^ __nullable)(ZJSheetAction *action))handler {
    ZJSheetAction *btn = [ZJSheetAction actionWithTitle:title style:ZJSheetActionStyleDetail handler:handler];
    btn.detailTitle = detail;
    btn.detailTitleColor = ZJColorFromRGB(0xBCC4D4);
    btn.detailTitleFont = [UIFont systemFontOfSize:14];
    btn.height = 64;
    return btn;
}

+ (instancetype)actionCancellWithTitle:(nullable NSString *)title handler:(void (^ __nullable)(ZJSheetAction *action))handler {
    ZJSheetAction *btn = [ZJSheetAction actionWithTitle:title style:ZJSheetActionStyleCancel handler:handler];
    btn.titleColor = ZJColorFromRGB(0x3D7DFF);
    btn.titleFont = [UIFont boldSystemFontOfSize:16];
    return btn;
}

@end
