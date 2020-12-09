//
//  ZJSlider.m
//  ZJBaseUtils
//
//  Created by eafy on 2020/7/27.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import "ZJSlider.h"
#import <CoreGraphics/CoreGraphics.h>
#import "UIView+ZJExt.h"
#import "UIView+ZJFrame.h"
#import "UIView+ZJShadow.h"
#import "UIColor+ZJExt.h"

@interface ZJSlider()

@property (nonatomic,assign) BOOL minTumbOn;

@property (nonatomic,assign) BOOL maxTumbOn;

@property (nonatomic,assign) CGFloat distanceFromCenter;

/// 左右2边的铺垫值，即滑块的直径
@property (nonatomic,assign) CGFloat padding;

/// 左边滑块
@property (nonatomic,strong) UIImageView *thumbLeftImgView;
/// 右边滑块
@property (nonatomic,strong) UIImageView *thumbRightImgView;
/// 选择区域
@property (nonatomic,strong) UIView *selectedView;
/// 未选中背景线
@property (nonatomic,strong) UIView *bgLineView;

@property (nonatomic,strong) UILabel *signCountLeftLB;
@property (nonatomic,strong) UILabel *signCountRightLB;

@end

@implementation ZJSlider

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.maxTumbOn = NO;
        self.maxTumbOn = NO;
        self.lineHeight = 6;
        self.isShowSign = NO;
        self.isRangeMode = NO;
        self.isShowShapingSign = NO;
        
        _thumbColor = [UIColor whiteColor];
        _leverColor = ZJColorFromRGB(0xBCC4D4);
        _leverDisabledColor = ZJColorFromRGB(0xDCE0E8);
        _progressColor = ZJColorFromRGB(0x3D7DFF);
        _progressDisabledColor = ZJColorFromRGB(0xD6E4FF);
        _textColor = ZJColorFromRGB(0x5A6482);
        _textFont = [UIFont systemFontOfSize:16];
        
        [self addSubview:self.bgLineView];
        [self addSubview:self.selectedView];
        [self addSubview:self.thumbLeftImgView];
        [self addSubview:self.thumbRightImgView];
        
        [self setSubFrame:self.frame];
    }
    return self;
}

- (UIView *)bgLineView
{
    if (!_bgLineView) {
        _bgLineView = [[UIView alloc] init];
        _bgLineView.backgroundColor = self.leverColor;
        _bgLineView.userInteractionEnabled = NO;
    }
    return _bgLineView;
}

- (UIView *)selectedView
{
    if (!_selectedView) {
        _selectedView = [[UIView alloc] init];
        _selectedView.backgroundColor = self.progressColor;
        _selectedView.userInteractionEnabled = NO;
    }
    
    return _selectedView;
}

- (UIImageView *)thumbLeftImgView
{
    if (!_thumbLeftImgView) {
        _thumbLeftImgView = [[UIImageView alloc] init];
        _thumbLeftImgView.backgroundColor = self.thumbColor;
        _thumbLeftImgView.userInteractionEnabled = NO;
    }
    return _thumbLeftImgView;
}

- (UIImageView *)thumbRightImgView
{
    if (!_thumbRightImgView) {
        _thumbRightImgView = [[UIImageView alloc] init];
        _thumbRightImgView.backgroundColor = self.thumbColor;
        _thumbRightImgView.userInteractionEnabled = NO;
        _thumbRightImgView.hidden = YES;
    }
    return _thumbRightImgView;
}

- (UILabel *)signCountLeftLB
{
    if (!_signCountLeftLB) {
        _signCountLeftLB = [[UILabel alloc] init];
        _signCountLeftLB.text = @"0";
        _signCountLeftLB.font = self.textFont;
        _signCountLeftLB.textColor = self.textColor;
        _signCountLeftLB.backgroundColor = [UIColor clearColor];
        _signCountLeftLB.contentMode = UIViewContentModeBottom;
    }
    return _signCountLeftLB;
}

- (UILabel *)signCountRightLB
{
    if (!_signCountRightLB) {
        _signCountRightLB = [[UILabel alloc] init];
        _signCountRightLB.text = @"0";
        _signCountRightLB.font =  self.textFont;
        _signCountRightLB.textColor = self.textColor;
        _signCountRightLB.backgroundColor = [UIColor clearColor];
        _signCountRightLB.contentMode = UIViewContentModeBottom;
        _signCountRightLB.hidden = YES;
    }
    return _signCountRightLB;
}

#pragma mark -

- (void)setSubFrame:(CGRect)frame
{
    self.bgLineView.frame = CGRectMake(0, self.zj_height - self.padding/2 - self.lineHeight, frame.size.width, self.lineHeight);
    [self.bgLineView zj_cornerWithRadii:CGSizeMake(self.bgLineView.zj_height/2, self.bgLineView.zj_height/2) rectCorner:UIRectCornerAllCorners];
    
    self.selectedView.frame = self.bgLineView.frame;
    [self.selectedView zj_cornerWithRadii:CGSizeMake(self.selectedView.zj_height/2, self.selectedView.zj_height/2) rectCorner:UIRectCornerAllCorners];
    
    self.thumbLeftImgView.frame = CGRectMake(0, 0, self.padding, self.padding);
    self.thumbLeftImgView.zj_centerY = self.bgLineView.zj_centerY;
    [self.thumbLeftImgView zj_shadowWithOpacity:0.3 shadowRadius:3 andCornerRadius:self.thumbLeftImgView.zj_height/2];

    self.thumbRightImgView.frame = CGRectMake(0, 0, self.padding, self.padding);
    self.thumbRightImgView.zj_centerY = self.bgLineView.zj_centerY;
    [self.thumbRightImgView zj_shadowWithOpacity:0.3 shadowRadius:3 andCornerRadius:self.thumbRightImgView.zj_height/2];
    
    if (self.isShowSign) {
        self.signCountLeftLB.zj_height = 20;
        self.signCountLeftLB.zj_centerX = self.thumbLeftImgView.zj_centerX;
        self.signCountLeftLB.zj_bottom = self.thumbLeftImgView.zj_top - 4;
        
        self.signCountRightLB.frame =  self.signCountLeftLB.frame;
        self.signCountRightLB.zj_centerX = self.thumbRightImgView.zj_centerX;
    }
}

- (void)setLineHeight:(CGFloat)lineHeight
{
    _lineHeight = lineHeight;
    self.padding = lineHeight * 4.5;
    self.frame = self.frame;
}

- (void)setIsShowSign:(BOOL)isShowSign
{
    if (_isShowSign == isShowSign) return;
    
    _isShowSign = isShowSign;
    if (isShowSign) {
        [self addSubview:self.signCountLeftLB];
        [self addSubview:self.signCountRightLB];
        if (self.isRangeMode) {
            self.signCountRightLB.hidden = NO;
        }
        self.frame = self.frame;
    } else {
        if (_signCountLeftLB) {
            [self.signCountLeftLB removeFromSuperview];
            _signCountLeftLB = nil;
        }
        if (_signCountRightLB) {
            [self.signCountRightLB removeFromSuperview];
            _signCountRightLB = nil;
        }
    }
}

- (void)setIsRangeMode:(BOOL)isRangeMode
{
    if (_isRangeMode == isRangeMode) return;
    _isRangeMode = isRangeMode;
    
    self.signCountRightLB.hidden = !isRangeMode;
    self.thumbRightImgView.hidden = !isRangeMode;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    if (self.zj_width && self.bgLineView.zj_width != self.zj_width) {
        [self setSubFrame:self.frame];
    }
    
    self.thumbLeftImgView.zj_centerX = [self xForValue:self.selectedMinValue];
    self.thumbRightImgView.zj_centerX = [self xForValue:self.isRangeMode?self.selectedMaxValue:self.maxValue];
    
    if (self.isRangeMode) {
        self.selectedView.zj_left = self.thumbLeftImgView.zj_centerX;
        self.selectedView.zj_width = self.thumbRightImgView.zj_centerX - self.thumbLeftImgView.zj_centerX;
    } else {
        self.selectedView.zj_left = 0;
        self.selectedView.zj_width = self.thumbLeftImgView.zj_centerX;
    }
    
    if (self.isShowSign) {
        self.signCountLeftLB.zj_centerX = self.thumbLeftImgView.zj_centerX;
        self.signCountRightLB.zj_centerX = self.thumbRightImgView.zj_centerX;
        
        if (self.isShowShapingSign) {
            self.signCountLeftLB.text = [NSString stringWithFormat:@"%ld", (long)(self.selectedMinValue)];
        } else {
            self.signCountLeftLB.text = [NSString stringWithFormat:@"%.2f", self.selectedMinValue];
        }
        [self.signCountLeftLB sizeToFit];
        
        if (self.isRangeMode) {
            if (self.isShowShapingSign) {
                self.signCountRightLB.text = [NSString stringWithFormat:@"%ld", (long)(self.selectedMaxValue)];
            } else {
                self.signCountRightLB.text = [NSString stringWithFormat:@"%.2f", self.selectedMaxValue];
            }
            [self.signCountRightLB sizeToFit];
        }
    }
}

#pragma mark - 

- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint touchPoint = [touch locationInView:self];
    CGRect minExpanRect = CGRectMake(self.thumbLeftImgView.zj_left, self.thumbLeftImgView.zj_top, self.thumbLeftImgView.zj_width, self.thumbLeftImgView.zj_height);
    CGRect maxExpandRect = CGRectMake(self.thumbRightImgView.zj_left, self.thumbRightImgView.zj_top, self.thumbRightImgView.zj_width, self.thumbRightImgView.zj_height);
    
    if (CGRectContainsPoint(minExpanRect, touchPoint)) {
        self.minTumbOn = YES;
        self.distanceFromCenter = touchPoint.x - self.thumbLeftImgView.zj_centerX;
    } else if (CGRectContainsPoint(maxExpandRect, touchPoint)) {
        self.maxTumbOn = YES;
        self.distanceFromCenter = touchPoint.x - self.thumbRightImgView.zj_centerX;
    }

    return YES;
}

- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    if (!self.minTumbOn && !self.maxTumbOn) {
        return YES;
    }
    CGPoint touchPoint = [touch locationInView:self];
    if (self.minTumbOn) {
        self.thumbLeftImgView.center = CGPointMake(MAX([self xForValue:self.minValue], MIN(touchPoint.x - self.distanceFromCenter, [self xForValue:self.isRangeMode?(self.selectedMaxValue- self.minRange):self.maxValue])), self.thumbLeftImgView.zj_centerY);
        
        self.selectedMinValue = [self valueForX:self.thumbLeftImgView.zj_centerX];
    }
    
    if (self.maxTumbOn) {
        self.thumbRightImgView.center = CGPointMake(MIN([self xForValue:self.maxValue], MAX(touchPoint.x - self.distanceFromCenter, [self xForValue:self.selectedMinValue + self.minRange])), self.thumbRightImgView.zj_centerY);
        
        self.selectedMaxValue = [self valueForX:self.thumbRightImgView.zj_centerX];
    }
    [self setNeedsLayout];
    [self sendActionsForControlEvents:UIControlEventValueChanged];
    NSLog(@"selectedMinValue = %f, selectedMaxValue = %f", self.selectedMinValue, self.selectedMaxValue);
    
    return YES;
}

- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    if (!self.isRangeMode && !self.minTumbOn && !self.maxTumbOn) {   //这个支持单点
        self.minTumbOn = self.maxTumbOn = YES;
        [self continueTrackingWithTouch:touch withEvent:event];
    }
    self.minTumbOn = NO;
    self.maxTumbOn = NO;
}

- (float)xForValue:(float)value {
    return (self.zj_width - self.padding) * ((value - self.minValue) / (self.maxValue - self.minValue)) + self.padding / 2;
}

- (float)valueForX:(float)x {
    return self.minValue + (x - self.padding / 2) / (self.zj_width - self.padding) * (self.maxValue - self.minValue);
}

#pragma mark -

- (void)setSelectedMinValue:(CGFloat)selectedMinValue
{
    if (selectedMinValue < 0) {
        selectedMinValue = 0;
    } else if (selectedMinValue > self.maxValue) {
        selectedMinValue = self.maxValue;
    }
    _selectedMinValue = selectedMinValue;
}

- (void)setSelectedMaxValue:(CGFloat)selectedMaxValue
{
    if (selectedMaxValue < self.minValue) {
        selectedMaxValue = self.minValue;
    } else if (selectedMaxValue > self.maxValue) {
        selectedMaxValue = self.maxValue;
    }
    _selectedMaxValue = selectedMaxValue;
}

- (void)setEnabled:(BOOL)enabled
{
    super.enabled = enabled;
    if (enabled) {
        self.bgLineView.backgroundColor = self.leverColor;
        self.selectedView.backgroundColor = self.progressColor;
    } else {
        self.bgLineView.backgroundColor = self.leverDisabledColor;
        self.selectedView.backgroundColor = self.progressDisabledColor;
    }
}

#pragma mark -

- (void)setLeverColor:(UIColor *)leverColor
{
    _leverColor = leverColor;
    if (_bgLineView) {
        self.bgLineView.backgroundColor = leverColor;
    }
}

- (void)setLeverDisabledColor:(UIColor *)leverDisabledColor
{
    _leverDisabledColor = leverDisabledColor;
    if (_bgLineView) {
        self.bgLineView.backgroundColor = leverDisabledColor;
    }
}

- (void)setProgressColor:(UIColor *)progressColor
{
    _progressColor = progressColor;
    if (_selectedView) {
        self.selectedView.backgroundColor = progressColor;
    }
}

- (void)setProgressDisabledColor:(UIColor *)progressDisabledColor
{
    _progressDisabledColor = progressDisabledColor;
    if (_selectedView) {
        self.selectedView.backgroundColor = progressDisabledColor;
    }
}

- (void)setTextColor:(UIColor *)textColor
{
    _textColor = textColor;
    if (_signCountLeftLB) {
        self.signCountLeftLB.textColor = textColor;
        self.signCountRightLB.textColor = textColor;
    }
}

- (void)setTextFont:(UIFont *)textFont
{
    _textFont = textFont;
    if (_textFont) {
        self.signCountLeftLB.font = textFont;
        self.signCountRightLB.font = textFont;
    }
}

- (void)setThumbColor:(UIColor *)thumbColor
{
    _thumbColor = thumbColor;
    if (_thumbLeftImgView) {
        self.thumbLeftImgView.backgroundColor = thumbColor;
        self.thumbRightImgView.backgroundColor = thumbColor;
    }
}

@end
