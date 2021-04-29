//
//  ZJButton.m
//  ZJUXKit
//
//  Created by eafy on 2020/7/25.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import "ZJButton.h"
#import "UIColor+ZJExt.h"
#import "UIImage+ZJExt.h"
#import "UIView+ZJExt.h"
#import "UIView+ZJFrame.h"

@implementation ZJButton

+ (instancetype)buttonWithStyle:(ZJButtonStyle)style
{
    ZJButton *btn = [[ZJButton alloc] init];
    btn.style = style;
    return btn;
}

+ (instancetype)buttonWithStyle:(ZJButtonStyle)style frame:(CGRect)frame
{
    ZJButton *btn = [[ZJButton alloc] initWithFrame:frame];
    btn.style = style;
    return btn;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.layer.cornerRadius = 4;
        self.layer.masksToBounds = YES;
        self.titleLabel.font = [UIFont boldSystemFontOfSize:14.f];
        self.style = ZJButtonStyleNormal;

        _lineColor = ZJColorFromRGB(0x3D7DFF);
        _edgeInsetsStyle = ZJButtonEdgeInsetsStyleLeft;
    }
    
    return self;
}

- (void)setStyle:(ZJButtonStyle)style
{
    _style = style;
    switch (style) {
        case ZJButtonStyleNormal:
            self.colorStyle = ZJButtonColorWhite;
            break;
        case ZJButtonStyleColor:
            self.colorStyle = ZJButtonColorBlue;
            break;
        case ZJButtonStyleLine:
            [self clear];
            [self zj_borderWithWidth:1 color:self.lineColor];
            
            self.norTitleColor = ZJColorFromRGB(0x3D7DFF);
            self.highTitleColor = ZJColorFromRGB(0x2F56FF);
            self.disTitleColor = ZJColorFromRGB(0xD6E4FF);
            [self addTarget:self action:@selector(handleStateHighlighted) forControlEvents:UIControlEventTouchDown];
            [self addTarget:self action:@selector(handleStateNormal) forControlEvents:UIControlEventTouchUpInside];
            break;
        default:
            break;
    }
}

- (void)clear
{
    [self setBackgroundImage:nil forState:UIControlStateNormal];
    [self setBackgroundImage:nil forState:UIControlStateHighlighted];
    [self setBackgroundImage:nil forState:UIControlStateDisabled];
}

- (void)setEnabled:(BOOL)enabled
{
    [super setEnabled:enabled];

    if (self.style == ZJButtonStyleLine) {
        if (!self.lineColor) return;
        self.layer.borderColor = enabled ? self.lineColor.CGColor : ZJColorFromRgbWithAlpha(self.lineColor.zj_toHexNumber, 0.3).CGColor;
    }
}

- (void)handleStateNormal
{
    if (self.style == ZJButtonStyleLine) {
        UIImage *img = [self backgroundImageForState:UIControlStateNormal];
        if (!img) return;;
        UIColor *color = [img zj_colorAtPixel:CGPointMake(1, 1)];
        if (!color) return;
        self.layer.borderColor = color.CGColor;
    }
}

- (void)handleStateHighlighted
{
    if (self.style == ZJButtonStyleLine) {
        UIImage *img = [self backgroundImageForState:UIControlStateHighlighted];
        if (!img) return;;
        UIColor *color = [img zj_colorAtPixel:CGPointMake(1, 1)];
        if (!color) return;
        self.layer.borderColor = color.CGColor;
    }
}

#pragma mark -

- (void)setNorTitle:(NSString *)norTitle
{
    _norTitle = norTitle;
    [self setTitle:norTitle forState:UIControlStateNormal];
}

- (void)setSelTitle:(NSString *)selTitle
{
    _selTitle = selTitle;
    [self setTitle:selTitle forState:UIControlStateSelected];
}

#pragma mark -

- (void)setNorTitleColor:(UIColor *)norTitleColor
{
    _norTitleColor = norTitleColor;
    [self setTitleColor:norTitleColor forState:UIControlStateNormal];
}

- (void)setHighTitleColor:(UIColor *)highTitleColor
{
    _highTitleColor = highTitleColor;
    [self setTitleColor:highTitleColor forState:UIControlStateHighlighted];
}

- (void)setSelTitleColor:(UIColor *)selTitleColor
{
    _selTitleColor = selTitleColor;
    [self setTitleColor:selTitleColor forState:UIControlStateSelected];
}

- (void)setDisTitleColor:(UIColor *)disTitleColor
{
    _disTitleColor = disTitleColor;
    [self setTitleColor:disTitleColor forState:UIControlStateDisabled];
}

#pragma mark -

- (void)setImageName:(NSString *)imgName state:(UIControlState)state
{
    if (!imgName || [imgName isEqualToString:@""]) {
        [self setImage:nil forState:state];
    } else {
        [self setImage:[UIImage imageNamed:imgName] forState:state];
    }
}

- (void)setNorImgName:(NSString *)norImgName
{
    _norImgName = norImgName;
    [self setImageName:norImgName state:UIControlStateNormal];
}

- (void)setHighImgName:(NSString *)highImgName
{
    _highImgName = highImgName;
    [self setImageName:highImgName state:UIControlStateHighlighted];
}

- (void)setSelImgName:(NSString *)selImgName
{
    _selImgName = selImgName;
    [self setImageName:selImgName state:UIControlStateSelected];
}

- (void)setDisImgName:(NSString *)disImgName
{
    _disImgName = disImgName;
    [self setImageName:disImgName state:UIControlStateDisabled];
}

#pragma mark -

- (void)setSpace:(CGFloat)space
{
    _space = space;
    [self zj_layoutWithEdgeInsetsStyle:self.edgeInsetsStyle imageTitleSpace:self.space];
}

- (void)setLineColor:(UIColor *)lineColor
{
    _lineColor = lineColor;
    [self zj_borderWithWidth:1 color:lineColor];
}

- (void)setEdgeInsetsStyle:(ZJButtonEdgeInsetsStyle)edgeInsetsStyle
{
    _edgeInsetsStyle = edgeInsetsStyle;
    [self zj_layoutWithEdgeInsetsStyle:edgeInsetsStyle imageTitleSpace:self.space];
}

#pragma mark - colorStyle

- (void)setColorStyle:(ZJButtonColorStyle)colorStyle {
    _colorStyle = colorStyle;
    switch (colorStyle) {
        case ZJButtonColorWhite:
            [self clear];
            self.norTitleColor = ZJColorFromRGB(0x181E28);
            self.highTitleColor = ZJColorFromRGB(0x8690A8);
            self.disTitleColor = ZJColorFromRGB(0xBCC4D4);
            break;
        case ZJButtonColorBlue:
            if (self.style == ZJButtonStyleLine) {
                self.lineColor = ZJColorFromRGB(0x3D7DFF);
                self.norTitleColor = ZJColorFromRGB(0x3D7DFF);
                self.highTitleColor = ZJColorFromRGB(0x2E56FE);
                self.disTitleColor = ZJColorFromRGB(0xC1D5FF);
            } else if (self.style == ZJButtonStyleColor) {
                self.norTitleColor = [UIColor whiteColor];
                self.highTitleColor = self.norTitleColor;
                self.disTitleColor = self.norTitleColor;
                [self setBackgroundImage:[UIImage zj_imageWithColor:ZJColorFromRGB(0x3D7DFF)] forState:UIControlStateNormal];
                [self setBackgroundImage:[UIImage zj_imageWithColor:ZJColorFromRGB(0x2E56FE)] forState:UIControlStateHighlighted];
                [self setBackgroundImage:[UIImage zj_imageWithColor:ZJColorFromRGB(0xC1D5FF)] forState:UIControlStateDisabled];
            } else {
                self.norTitleColor = ZJColorFromRGB(0x3D7DFF);
                self.highTitleColor = ZJColorFromRGB(0x2E56FE);
                self.disTitleColor = ZJColorFromRGB(0xC1D5FF);
            }
            break;
        case ZJButtonColorRed:
            if (self.style == ZJButtonStyleLine) {
                self.lineColor = ZJColorFromRGB(0xF45C5C);
                self.norTitleColor = ZJColorFromRGB(0xF45C5C);
                self.highTitleColor = ZJColorFromRGB(0xF13636);
                self.disTitleColor = ZJColorFromRGB(0xF9A4A4);
            } else if (self.style == ZJButtonStyleColor) {
                self.norTitleColor = [UIColor whiteColor];
                self.highTitleColor = self.norTitleColor;
                self.disTitleColor = self.norTitleColor;
                [self setBackgroundImage:[UIImage zj_imageWithColor:ZJColorFromRGB(0xF45C5C)] forState:UIControlStateNormal];
                [self setBackgroundImage:[UIImage zj_imageWithColor:ZJColorFromRGB(0xF13636)] forState:UIControlStateHighlighted];
                [self setBackgroundImage:[UIImage zj_imageWithColor:ZJColorFromRGB(0xF9A4A4)] forState:UIControlStateDisabled];
            } else {
                self.norTitleColor = ZJColorFromRGB(0xF45C5C);
                self.highTitleColor = ZJColorFromRGB(0xF13636);
                self.disTitleColor = ZJColorFromRGB(0xF9A4A4);
            }
            break;
        default:
            break;
    }
}

- (void)setHeightStyle:(ZJButtonHeightStyle)heightStyle {
    _heightStyle = heightStyle;
    switch (heightStyle) {
        case ZJButtonHeightLarge:
            self.zj_height = 48;
            break;
        case ZJButtonHeightMedium:
            self.zj_height = 40;
            break;
        case ZJButtonHeightSmall:
            self.zj_height = 32;
            break;
        default:
            break;
    }
}

@end
