//
//  ZJProgressBar.m
//  ZJBaseUtils
//
//  Created by eafy on 2021/1/29.
//  Copyright © 2021 ZJ. All rights reserved.
//

#import "ZJProgressBar.h"
#import "UIColor+ZJExt.h"
#import "UIView+ZJFrame.h"

@interface ZJProgressBar ()

@property (nonatomic,strong) CAShapeLayer *backGroundLayer;         //背景图层
@property (nonatomic,strong) CAShapeLayer *frontFillLayer;          //用来填充的图层

@end

@implementation ZJProgressBar

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        self.width = 6;
        self.bgColor = ZJColorFromRGB(0xE8ECF1);
        self.color = ZJColorFromRGB(0x3D7DFF);
    }
    
    return self;
}

- (CAShapeLayer *)backGroundLayer {
    if (!_backGroundLayer) {
        _backGroundLayer = [CAShapeLayer layer];
        _backGroundLayer.lineCap = kCALineCapRound;
        _backGroundLayer.fillColor = nil;
        _backGroundLayer.path = nil;
        [self.layer insertSublayer:_backGroundLayer atIndex:0];
    }
    return _backGroundLayer;
}

- (CAShapeLayer *)frontFillLayer {
    if (!_frontFillLayer) {
        _frontFillLayer = [CAShapeLayer layer];
        _frontFillLayer.lineCap = kCALineCapRound;
        _frontFillLayer.fillColor = nil;
        _frontFillLayer.path = nil;
        [self.layer addSublayer:_frontFillLayer];
    }
    return _frontFillLayer;
}

- (UILabel *)progressLB {
    if (!_progressLB) {
        _progressLB = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 45, 20)];
        _progressLB.backgroundColor = [UIColor clearColor];
        _progressLB.textColor = ZJColorFromRGB(0x5A6482);
        _progressLB.font = [UIFont boldSystemFontOfSize:16];
        _progressLB.textAlignment = NSTextAlignmentCenter;
//        [_progressLB sizeToFit];
    }
    return _progressLB;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (self.style == ZJProgressBarRound) {
        self.backGroundLayer.frame = self.bounds;
        self.frontFillLayer.frame = self.bounds;
    } else {
        self.backGroundLayer.frame = CGRectMake(0, self.zj_height - self.width, self.zj_width, self.width);
        self.frontFillLayer.frame = self.backGroundLayer.frame;
    }
    
    [self updateBezierPath];
    if (self.isShowProgressLabel) {
        self.progressLB.zj_centerX = self.zj_width/2;
        if (self.style == ZJProgressBarRound) {
            self.progressLB.zj_centerY = self.zj_height/2;
        } else {
            self.progressLB.zj_bottom = self.backGroundLayer.frame.origin.y - 8;
        }
    }
}

- (void)updateBezierPath {
    if (self.style == ZJProgressBarRound) {
        if (!self.backGroundLayer.path || self.backGroundLayer.bounds.size.width != self.zj_width || self.backGroundLayer.bounds.size.height != self.width) {
            UIBezierPath *bezierPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.zj_width/2.0, self.zj_height/2.0) radius:(CGRectGetWidth(self.bounds)-self.width)/2.f startAngle:0 endAngle:M_PI*2 clockwise:YES];
            self.backGroundLayer.path = bezierPath.CGPath;
        }
        
        UIBezierPath *bezierPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.zj_width/2.0, self.zj_height/2.0) radius:(CGRectGetWidth(self.bounds)-self.width)/2.f startAngle:-M_PI_2 endAngle:(2*M_PI)*self.progress-M_PI_2 clockwise:YES];
        self.frontFillLayer.path = bezierPath.CGPath;
    } else if (self.style == ZJProgressBarHorizontal) {
        if (!self.backGroundLayer.path || self.backGroundLayer.bounds.size.width != self.zj_width || self.backGroundLayer.bounds.size.height != self.width) {
            UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, self.zj_width, self.width/4) cornerRadius:self.width/2];
            self.backGroundLayer.path = bezierPath.CGPath;
        }
        
        CGFloat width = self.zj_width * self.progress;
        UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, width, self.width/4) cornerRadius:self.width/2];
        self.frontFillLayer.path = bezierPath.CGPath;
    }
}

- (void)setStyle:(ZJProgressBarStyle)style {
    _style = style;
    self.backGroundLayer.path = nil;
    [self setNeedsLayout];
}

- (void)setColor:(UIColor *)color {
    _color = color;
    self.frontFillLayer.strokeColor = color.CGColor;
    [self updateBezierPath];
}

- (void)setBgColor:(UIColor *)bgColor {
    _bgColor = bgColor;
    self.backGroundLayer.strokeColor = bgColor.CGColor;
    self.backGroundLayer.path = nil;
    [self updateBezierPath];
}

- (void)setWidth:(CGFloat)width {
    _width = width;
    self.backGroundLayer.lineWidth = width;
    self.frontFillLayer.lineWidth = width;
    self.backGroundLayer.path = nil;
    [self setNeedsLayout];
}

- (void)setProgress:(CGFloat)progress {
    if (progress < 0) {
        progress = 0;
    } else if (progress > 1.0) {
        progress = 1.0;
    }
    _progress = progress;
    [self updateBezierPath];
    if (self.isShowProgressLabel) {
        self.progressLB.text = [NSString stringWithFormat:@"%d%%", (int)(progress * 100)];
    }
}

- (void)setIsShowProgressLabel:(BOOL)isShowProgressLabel {
    _isShowProgressLabel = isShowProgressLabel;
    
    if (isShowProgressLabel) {
        if (!_progressLB.superview) {
            [self addSubview:self.progressLB];
        }
    } else if (_progressLB) {
        [_progressLB removeFromSuperview];
        _progressLB = nil;
    }
}

@end
