//
//  ZJLabel.m
//  ZJBaseUtils
//
//  Created by eafy on 2020/7/25.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import <ZJBaseUtils/ZJLabel.h>
#import <ZJBaseUtils/UIColor+ZJExt.h>
#import <ZJBaseUtils/UIView+ZJExt.h>
#import <ZJBaseUtils/UIView+ZJGesture.h>
#import <ZJBaseUtils/ZJUtilsDef.h>

@interface ZJLabel ()

@end

@implementation ZJLabel

+ (instancetype)labelWithStyle:(ZJLabelStyle)style
{
    ZJLabel *label = [[ZJLabel alloc] init];
    label.style = style;
    return label;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.layer.cornerRadius = 4;
        self.layer.masksToBounds = YES;
        self.font = [UIFont boldSystemFontOfSize:14.f];
        self.textColor = [UIColor whiteColor];
        self.textAlignment = NSTextAlignmentCenter;
        self.backgroundColor = ZJColorFromRGB(0x3D7DFF);
        
        self.lineColor = self.backgroundColor;
        _bgNorColcor = self.backgroundColor;
        _bgSelColcor = self.backgroundColor;
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.style == ZJLabelStyleDottedLine) {
        [self zj_borderWithWidth:1 cornerRadii:CGSizeMake(self.layer.cornerRadius, self.layer.cornerRadius) rectCorner:UIRectCornerAllCorners length:8 space:4 strokeColor:self.lineColor];
    } else if (self.style & ZJLabelStyleCorner) {
        self.layer.masksToBounds = NO;
        
        if (self.style & ZJLabelStyleLine) {
            [self zj_borderWithWidth:1 cornerRadii:CGSizeMake(self.layer.cornerRadius, self.layer.cornerRadius) rectCorner:(UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomRight) length:8 space:0 strokeColor:self.lineColor];
        } else {
            [self zj_cornerWithRadii:CGSizeMake(self.layer.cornerRadius, self.layer.cornerRadius) rectCorner:(UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomRight)];
        }
    }
}

#pragma mark -

- (void)setStyle:(ZJLabelStyle)style
{
    _style = style;
    switch (style) {
        case ZJLabelStyleNormal:
            
            break;
        case ZJLabelStyleLine:
            self.backgroundColor = [UIColor clearColor];
            self.textColor = ZJColorFromRGB(0x3D7DFF);
            [self zj_borderWithWidth:1 color:self.lineColor];
            break;
        case ZJLabelStyleDottedLine:
            self.backgroundColor = [UIColor clearColor];
            self.textColor = ZJColorFromRGB(0x3D7DFF);
            break;
        case ZJLabelStyleSelectable:
        {
            self.selected = self.selected;
            weakSelf(self);
            [self zj_addSingleTap:^(id  _Nonnull obj) {
                weakSelf.selected = !self.selected;
                if (weakSelf.labelSelectBlock) {
                    weakSelf.labelSelectBlock(self.selected);
                }
            }];
        }
            break;
        default:
            break;
    }
}

- (void)setTextColor:(UIColor *)textColor
{
    super.textColor = textColor;
    if (!_textNorColcor) {
        _textNorColcor = textColor;
    }
}

- (void)setTextNorColcor:(UIColor *)textNorColcor
{
    _textNorColcor = textNorColcor;
    super.textColor = textNorColcor;
}

- (void)setLineColor:(UIColor *)lineColor
{
    _lineColor = lineColor;
    if (self.style == ZJLabelStyleLine) {
        [self zj_borderWithWidth:1 color:lineColor];
    } else if (self.style == ZJLabelStyleDottedLine) {
        [self zj_borderWithWidth:1 cornerRadii:CGSizeMake(self.layer.cornerRadius, self.layer.cornerRadius) rectCorner:UIRectCornerAllCorners length:8 space:4 strokeColor:self.lineColor];
    }
}

- (void)setBgNorColcor:(UIColor *)bgNorColcor
{
    _bgNorColcor = bgNorColcor;
    self.backgroundColor = bgNorColcor;
}

- (void)setSelected:(BOOL)selected
{
    _selected = selected;
    if (self.style == ZJLabelStyleSelectable) {
        self.backgroundColor = selected ? self.bgSelColcor : self.bgNorColcor;
        self.textColor = selected ? self.textSelColcor : self.textNorColcor;
    }
}

- (void)drawRect:(CGRect)rect
{
    if (self.isGradientEnable && self.gradientColors.count > 1 && self.gradientPercents.count > 1) {
        
        CGFloat *locations = malloc(sizeof(CGFloat) * self.gradientColors.count);
        NSMutableArray *colorArray = [NSMutableArray array];
        for (int i=0; i<self.gradientColors.count; i++) {
            UIColor *color = [self.gradientColors objectAtIndex:i];
            [colorArray addObject:(id)color.CGColor];
            if (i < self.gradientPercents.count) {
                locations[i] = [self.gradientPercents[i] floatValue];
            } else {
                locations[i] = 1.0;
            }
        }
        
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        // 获取文字mask
        [self.text drawInRect:self.bounds withAttributes:@{ NSFontAttributeName: self.font }];
        CGImageRef textMask = CGBitmapContextCreateImage(context);
        
        // 清空画布
        CGContextClearRect(context, rect);
        
        // 设置蒙层
        CGContextTranslateCTM(context, 0.0, self.bounds.size.height);
        CGContextScaleCTM(context, 1.0, -1.0);
        CGContextClipToMask(context, rect, textMask);
        
        // 绘制渐变
        CGColorSpaceRef colorSpace = CGColorGetColorSpace([[self.gradientColors lastObject] CGColor]);
        CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)colorArray, locations);
        CGPoint start = CGPointMake(0, self.bounds.size.height / 2.0);
        CGPoint end = CGPointMake(self.bounds.size.width, self.bounds.size.height / 2.0);
        CGContextDrawLinearGradient(context, gradient, start, end, kCGGradientDrawsBeforeStartLocation);
        
        // 释放
        CGColorSpaceRelease(colorSpace);
        CGGradientRelease(gradient);
        CGImageRelease(textMask);
        free(locations);
    }
}

@end
