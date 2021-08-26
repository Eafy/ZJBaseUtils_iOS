//
//  ZJSlider.m
//  ZJBaseUtils
//
//  Created by eafy on 2020/7/27.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import <ZJBaseUtils/ZJSlider.h>
#import <CoreGraphics/CoreGraphics.h>
#import <ZJBaseUtils/UIView+ZJExt.h>
#import <ZJBaseUtils/UIView+ZJFrame.h>
#import <ZJBaseUtils/UIView+ZJShadow.h>
#import <ZJBaseUtils/UIColor+ZJExt.h>

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

@property (nonatomic,strong) UILabel *signCountTopLeftLB;
@property (nonatomic,strong) UILabel *signCountTopRightLB;
@property (nonatomic,strong) UILabel *signCountSideLeftLB;
@property (nonatomic,strong) UILabel *signCountSideRightLB;

@property (nonatomic,strong) NSMutableArray *fixedPointViews;

@end

@implementation ZJSlider

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initDefaultData];
    }
    return self;
}

- (instancetype)initWithStyle:(ZJSliderStyle)style
{
    if (self = [super init]) {
        [self initDefaultData];
        self.style = style;
    }
    return self;
}

- (void)initDefaultData
{
    self.style = ZJSliderStyleSinglePoint;
    self.maxTumbOn = NO;
    self.maxTumbOn = NO;
    self.lineHeight = 6;
    self.isShowTopSign = NO;
    self.isShowBothSideSign = NO;
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

- (UILabel *)signCountTopLeftLB
{
    if (!_signCountTopLeftLB) {
        _signCountTopLeftLB = [[UILabel alloc] init];
        _signCountTopLeftLB.text = @"0";
        _signCountTopLeftLB.font = self.textFont;
        _signCountTopLeftLB.textColor = self.textColor;
        _signCountTopLeftLB.backgroundColor = [UIColor clearColor];
        _signCountTopLeftLB.contentMode = UIViewContentModeBottom;
    }
    return _signCountTopLeftLB;
}

- (UILabel *)signCountTopRightLB
{
    if (!_signCountTopRightLB) {
        _signCountTopRightLB = [[UILabel alloc] init];
        _signCountTopRightLB.text = @"0";
        _signCountTopRightLB.font =  self.textFont;
        _signCountTopRightLB.textColor = self.textColor;
        _signCountTopRightLB.backgroundColor = [UIColor clearColor];
        _signCountTopRightLB.contentMode = UIViewContentModeBottom;
        _signCountTopRightLB.hidden = YES;
    }
    return _signCountTopRightLB;
}

- (UILabel *)signCountSideLeftLB {
    if (!_signCountSideLeftLB) {
        _signCountSideLeftLB = [[UILabel alloc] init];
        _signCountSideLeftLB.text = @"0";
        _signCountSideLeftLB.font =  self.textFont;
        _signCountSideLeftLB.textColor = self.textColor;
        _signCountSideLeftLB.backgroundColor = [UIColor clearColor];
        _signCountSideLeftLB.contentMode = UIViewContentModeRight;
    }
    return _signCountSideLeftLB;
}

- (UILabel *)signCountSideRightLB {
    if (!_signCountSideRightLB) {
        _signCountSideRightLB = [[UILabel alloc] init];
        _signCountSideRightLB.text = @"0";
        _signCountSideRightLB.font =  self.textFont;
        _signCountSideRightLB.textColor = self.textColor;
        _signCountSideRightLB.backgroundColor = [UIColor clearColor];
        _signCountSideRightLB.contentMode = UIViewContentModeLeft;
    }
    return _signCountSideRightLB;
}

- (NSMutableArray *)fixedPointViews {
    if (!_fixedPointViews) {
        _fixedPointViews = [NSMutableArray array];
    }
    return _fixedPointViews;
}

#pragma mark -

- (void)setSubFrame:(CGRect)frame
{
    self.bgLineView.frame = CGRectMake(0, self.zj_height - self.padding/2 - self.lineHeight, frame.size.width, self.lineHeight);
    if (self.isShowBothSideSign) {
        [self.signCountSideLeftLB sizeToFit];
        [self.signCountSideRightLB sizeToFit];
        
        self.signCountSideLeftLB.zj_height = 20;
        self.signCountSideLeftLB.zj_centerY = self.bgLineView.zj_centerY;
        
        self.signCountSideRightLB.zj_height =  self.signCountSideLeftLB.zj_height;
        self.signCountSideRightLB.zj_centerY = self.signCountSideLeftLB.zj_centerY;
        self.signCountSideRightLB.zj_right = self.zj_width;
        
        self.bgLineView.zj_left = self.signCountSideLeftLB.zj_right + 8;
        self.bgLineView.zj_width = self.signCountSideRightLB.zj_left - 8 - self.bgLineView.zj_left;
    }
    [self.bgLineView zj_cornerWithRadii:CGSizeMake(self.bgLineView.zj_height/2, self.bgLineView.zj_height/2) rectCorner:UIRectCornerAllCorners];
    
    self.selectedView.frame = self.bgLineView.frame;
    [self.selectedView zj_cornerWithRadii:CGSizeMake(self.selectedView.zj_height/2, self.selectedView.zj_height/2) rectCorner:UIRectCornerAllCorners];
    
    self.thumbLeftImgView.frame = CGRectMake(0, 0, self.padding, self.padding);
    self.thumbLeftImgView.zj_centerY = self.bgLineView.zj_centerY;
    [self.thumbLeftImgView zj_shadowWithOpacity:0.3 shadowRadius:3 andCornerRadius:self.thumbLeftImgView.zj_height/2];

    self.thumbRightImgView.frame = CGRectMake(0, 0, self.padding, self.padding);
    self.thumbRightImgView.zj_centerY = self.bgLineView.zj_centerY;
    [self.thumbRightImgView zj_shadowWithOpacity:0.3 shadowRadius:3 andCornerRadius:self.thumbRightImgView.zj_height/2];
    
    if (self.isShowTopSign) {
        [self.signCountTopLeftLB sizeToFit];
        [self.signCountTopRightLB sizeToFit];
        
        self.signCountTopLeftLB.zj_height = 20;
        self.signCountTopLeftLB.zj_centerX = self.thumbLeftImgView.zj_centerX;
        self.signCountTopLeftLB.zj_bottom = self.thumbLeftImgView.zj_top - 4;
        
        self.signCountTopRightLB.zj_height = self.signCountTopLeftLB.zj_height;
        self.signCountTopRightLB.zj_bottom = self.signCountTopLeftLB.zj_bottom;
        self.signCountTopRightLB.zj_centerX = self.thumbRightImgView.zj_centerX;
    }
    
    if (self.style == ZJSliderStyleFixedPoint) {
        NSInteger index = 0;
        for (UIView *view in self.fixedPointViews) {
            view.zj_width = view.zj_height = self.lineHeight*2;
            view.layer.cornerRadius = view.zj_height/2;
            view.zj_centerY = self.bgLineView.zj_centerY;
            view.zj_centerX = (self.bgLineView.zj_width-self.padding)/self.fixedPointCount * index + self.padding/2 + self.bgLineView.zj_left;
            index ++;
        }
    }
}

- (void)setLineHeight:(CGFloat)lineHeight
{
    _lineHeight = lineHeight;
    self.padding = lineHeight * 4.5;
    self.frame = self.frame;
}

- (void)setIsShowTopSign:(BOOL)isShowTopSign
{
    if (_isShowTopSign == isShowTopSign) return;
    
    _isShowTopSign = isShowTopSign;
    if (isShowTopSign) {
        [self addSubview:self.signCountTopLeftLB];
        [self addSubview:self.signCountTopRightLB];
        if (self.style == ZJSliderStyleRange) {
            self.signCountTopRightLB.hidden = NO;
        }
        [self setSubFrame:self.frame];
    } else {
        if (_signCountTopLeftLB) {
            [self.signCountTopLeftLB removeFromSuperview];
            _signCountTopLeftLB = nil;
        }
        if (_signCountTopRightLB) {
            [self.signCountTopRightLB removeFromSuperview];
            _signCountTopRightLB = nil;
        }
    }
}

- (void)setIsShowBothSideSign:(BOOL)isShowBothSideSign
{
    if (_isShowBothSideSign == isShowBothSideSign) return;
    
    _isShowBothSideSign = isShowBothSideSign;
    if (isShowBothSideSign) {
        [self addSubview:self.signCountSideLeftLB];
        [self addSubview:self.signCountSideRightLB];
        [self setSubFrame:self.frame];
    } else {
        if (_signCountSideLeftLB) {
            [self.signCountSideLeftLB removeFromSuperview];
            _signCountSideLeftLB = nil;
        }
        if (_signCountSideRightLB) {
            [self.signCountSideRightLB removeFromSuperview];
            _signCountSideRightLB = nil;
        }
    }
}

- (void)setFixedPointCount:(NSInteger)fixedPointCount {
    _fixedPointCount = fixedPointCount;
    
    for (UIView *view in self.fixedPointViews) {
        [view removeFromSuperview];
    }
    [self.fixedPointViews removeAllObjects];
    
    for (NSInteger i=0; i<fixedPointCount+1; i++) {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = self.leverColor;
        view.layer.masksToBounds = YES;
        [self insertSubview:view aboveSubview:self.bgLineView];
        [self.fixedPointViews addObject:view];
        if (i == 0 || i == fixedPointCount) {
            view.hidden = YES;
        }
    }
    [self setSubFrame:self.frame];
}

- (void)layoutSubviews {
    [super layoutSubviews];

    if (self.zj_width && self.bgLineView.zj_width != self.zj_width) {
        [self setSubFrame:self.frame];
    }
    
    self.thumbLeftImgView.zj_centerX = [self xFromValue:self.selectedMinValue];
    self.thumbRightImgView.zj_centerX = [self xFromValue:self.style == ZJSliderStyleRange ? self.selectedMaxValue : self.maxValue];
    
    if (self.style == ZJSliderStyleRange) {
        self.selectedView.zj_left = self.thumbLeftImgView.zj_centerX;
        self.selectedView.zj_width = self.thumbRightImgView.zj_centerX - self.thumbLeftImgView.zj_centerX;
    } else {
        self.selectedView.zj_left = self.bgLineView.zj_left;
        self.selectedView.zj_width = self.thumbLeftImgView.zj_centerX - self.selectedView.zj_left;
    }
    
    if (self.isShowTopSign) {
        
        if (self.isShowShapingSign) {
            self.signCountTopLeftLB.text = [NSString stringWithFormat:@"%ld", (long)(self.selectedMinValue)];
            if (self.isShowShapingSign) {
                self.signCountSideLeftLB.text = [NSString stringWithFormat:@"%ld", (long)self.minValue];
                self.signCountSideRightLB.text = [NSString stringWithFormat:@"%ld", (long)self.maxValue];
            }
        } else {
            self.signCountTopLeftLB.text = [NSString stringWithFormat:@"%.2f", self.selectedMinValue];
            if (self.isShowShapingSign) {
                self.signCountSideLeftLB.text = [NSString stringWithFormat:@"%.2f", self.minValue];
                self.signCountSideRightLB.text = [NSString stringWithFormat:@"%.2f", self.maxValue];
            }
        }
        
        if (self.style == ZJSliderStyleRange) {
            if (self.isShowShapingSign) {
                self.signCountTopRightLB.text = [NSString stringWithFormat:@"%ld", (long)(self.selectedMaxValue)];
            } else {
                self.signCountTopRightLB.text = [NSString stringWithFormat:@"%.2f", self.selectedMaxValue];
            }
        }
        [self.signCountTopLeftLB sizeToFit];
        [self.signCountTopRightLB sizeToFit];
        
        self.signCountTopLeftLB.zj_centerX = self.thumbLeftImgView.zj_centerX;
        self.signCountTopRightLB.zj_centerX = self.thumbRightImgView.zj_centerX;
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
        self.thumbLeftImgView.zj_centerX = MAX([self xFromValue:self.minValue], MIN(touchPoint.x - self.distanceFromCenter, [self xFromValue:self.style == ZJSliderStyleRange ? (self.selectedMaxValue- self.minRange) : self.maxValue]));
        
        self.selectedMinValue = [self valueFromX:self.thumbLeftImgView.zj_centerX];
        [self showFiexedPointX:NO];
    }
    
    if (self.maxTumbOn) {
        self.thumbRightImgView.center = CGPointMake(MIN([self xFromValue:self.maxValue], MAX(touchPoint.x - self.distanceFromCenter, [self xFromValue:self.selectedMinValue + self.minRange])), self.thumbRightImgView.zj_centerY);
        
        self.selectedMaxValue = [self valueFromX:self.thumbRightImgView.zj_centerX];
    }
    [self setNeedsLayout];
    [self sendActionsForControlEvents:UIControlEventValueChanged];
    NSLog(@"selectedMinValue = %f, selectedMaxValue = %f", self.selectedMinValue, self.selectedMaxValue);
    
    return YES;
}

- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    if (self.style != ZJSliderStyleRange && !self.minTumbOn && !self.maxTumbOn) {   //这个支持单点
        self.minTumbOn = self.maxTumbOn = YES;
        [self continueTrackingWithTouch:touch withEvent:event];
    }

    [self showFiexedPointX:YES];
    self.minTumbOn = NO;
    self.maxTumbOn = NO;
}

- (float)xFromValue:(float)value {
    return (self.bgLineView.zj_width - self.padding) * ((value - self.minValue) / (self.maxValue - self.minValue)) + self.padding/2 + self.bgLineView.zj_left;
}

- (float)valueFromX:(float)x {
    return self.minValue + (x - self.padding / 2 - self.bgLineView.zj_left) / (self.bgLineView.zj_width - self.padding) * (self.maxValue - self.minValue);
}

- (void)showFiexedPointX:(BOOL)isFixedPoint {
    if (self.style == ZJSliderStyleFixedPoint) {
        CGFloat minX = 0;
        CGFloat maxX = 0;
        CGFloat minViewX = 0;
        for (UIView *view in self.fixedPointViews) {
            if (self.thumbLeftImgView.zj_centerX > view.zj_centerX) {
                minX = self.thumbLeftImgView.zj_centerX - view.zj_centerX;
                minViewX = view.zj_centerX;
                view.backgroundColor = self.progressColor;
            } else if (maxX == 0 && self.thumbLeftImgView.zj_centerX < view.zj_centerX) {
                maxX = view.zj_centerX - self.thumbLeftImgView.zj_centerX;
                view.backgroundColor = self.leverColor;
                
                if (isFixedPoint) {
                    self.selectedMinValue = [self valueFromX:maxX > minX ? minViewX : view.zj_centerX];
                    [self setNeedsLayout];
                }
            } else {
                view.backgroundColor = self.leverColor;
            }
        }
    }
}

#pragma mark -

- (void)setStyle:(ZJSliderStyle)style {
    if (_style == style) return;
    _style = style;
    
    self.signCountTopRightLB.hidden = style != ZJSliderStyleRange;
    self.thumbRightImgView.hidden = self.signCountTopRightLB.hidden;
    if (style != ZJSliderStyleFixedPoint && _fixedPointViews) {
        for (UIView *view in self.fixedPointViews) {
            [view removeFromSuperview];
        }
        [self.fixedPointViews removeAllObjects];
    }
}

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

- (void)setMinValue:(CGFloat)minValue {
    _minValue = minValue;
    [self setNeedsLayout];
}

- (void)setMaxValue:(CGFloat)maxValue {
    _maxValue = maxValue;
    [self setNeedsLayout];
}

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
    if (_signCountTopLeftLB) {
        self.signCountTopLeftLB.textColor = textColor;
        self.signCountTopRightLB.textColor = textColor;
    }
}

- (void)setTextFont:(UIFont *)textFont
{
    _textFont = textFont;
    if (_textFont) {
        self.signCountTopLeftLB.font = textFont;
        self.signCountTopRightLB.font = textFont;
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
