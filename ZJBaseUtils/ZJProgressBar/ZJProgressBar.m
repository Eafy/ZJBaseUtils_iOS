//
//  ZJProgressBar.h
//  ZJBaseUtils
//
//  Created by eafy on 2021/1/29.
//  Copyright © 2021 ZJ. All rights reserved.
//

#import <ZJBaseUtils/ZJProgressBar.h>
#import <ZJBaseUtils/UIColor+ZJExt.h>
#import <ZJBaseUtils/UIView+ZJFrame.h>

@interface ZJProgressBar ()

@property (nonatomic,strong) CAShapeLayer *backGroundLayer;         //背景图层
@property (nonatomic,strong) CAShapeLayer *frontFillLayer;          //用来填充的图层
@property (nonatomic,assign) CGFloat oldProgress;

@end

@implementation ZJProgressBar

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        self.progressWidth = 6;
        self.bgColor = ZJColorFromRGB(0xE8ECF1);
        self.color = ZJColorFromRGB(0x3D7DFF);
        self.isAutoUpdateLB = YES;
        self.isClockwise = YES;
        self.startAngle = 0;
        self.animationDuration = 0.1;
    }
    
    return self;
}

- (CAShapeLayer *)backGroundLayer {
    if (!_backGroundLayer) {
        _backGroundLayer = [CAShapeLayer layer];
        _backGroundLayer.backgroundColor = [UIColor clearColor].CGColor;
        _backGroundLayer.lineCap = kCALineCapRound;
        _backGroundLayer.fillColor = [UIColor clearColor].CGColor;
        _backGroundLayer.path = nil;
        _backGroundLayer.frame = self.bounds;
        _backGroundLayer.lineWidth = self.progressWidth;
        _backGroundLayer.strokeColor = self.bgColor.CGColor;
        [self.layer insertSublayer:_backGroundLayer atIndex:0];
    }
    return _backGroundLayer;
}

- (CAShapeLayer *)frontFillLayer {
    if (!_frontFillLayer) {
        _frontFillLayer = [CAShapeLayer layer];
        _frontFillLayer.backgroundColor = [UIColor clearColor].CGColor;
        _frontFillLayer.lineCap = kCALineCapRound;
        _frontFillLayer.fillColor = [UIColor clearColor].CGColor;
        _frontFillLayer.path = nil;
        _frontFillLayer.frame = self.bounds;
        _frontFillLayer.lineWidth = self.progressWidth;
        _frontFillLayer.strokeColor = self.color.CGColor;
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
        _progressLB.text = @"0%";
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
        self.backGroundLayer.frame = CGRectMake(0, self.zj_height - self.progressWidth, self.zj_width, self.progressWidth);
        self.frontFillLayer.frame = self.backGroundLayer.frame;
    }
    
    self.frontFillLayer.path = [self getNewBezierPath].CGPath;
    if (self.isShowProgressLabel) {
        self.progressLB.zj_centerX = self.zj_width/2;
        if (self.style == ZJProgressBarRound) {
            self.progressLB.zj_centerY = self.zj_height/2;
        } else {
            self.progressLB.zj_bottom = self.backGroundLayer.frame.origin.y - 8;
        }
    }
}

- (UIBezierPath *)getNewBezierPath {
    CGFloat progress = self.animationDuration <= 0 ? self.progress : 1.0;
    UIBezierPath *bezierPath = nil;
    if (self.style == ZJProgressBarRound) {
        if (!self.backGroundLayer.path || self.backGroundLayer.bounds.size.width != self.zj_width || self.backGroundLayer.bounds.size.height != self.zj_height) {
            UIBezierPath *bezierPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.zj_width/2.0, self.zj_height/2.0) radius:(CGRectGetWidth(self.bounds)-self.progressWidth)/2.f startAngle:0 endAngle:M_PI*2 clockwise:YES];
            self.backGroundLayer.path = bezierPath.CGPath;
        }
        
        if (self.isClockwise) {
            bezierPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.zj_width/2.0, self.zj_height/2.0) radius:(CGRectGetWidth(self.bounds)-self.progressWidth)/2.f startAngle:(self.startAngle - M_PI_2) endAngle:4*M_PI_2*progress - M_PI_2 + self.startAngle clockwise:YES];
        } else {
            bezierPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.zj_width/2.0, self.zj_height/2.0) radius:(CGRectGetWidth(self.bounds)-self.progressWidth)/2.f startAngle:3*M_PI_2 + self.startAngle endAngle:3*M_PI_2-(4*M_PI_2)*progress + self.startAngle clockwise:NO];
        }
    } else if (self.style == ZJProgressBarHorizontal) {
        if (!self.backGroundLayer.path || self.backGroundLayer.bounds.size.width != self.zj_width || self.backGroundLayer.bounds.size.height != self.zj_height) {
            UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, self.zj_width, self.progressWidth/4) cornerRadius:self.progressWidth/2];
            self.backGroundLayer.path = bezierPath.CGPath;
        }
        
        CGFloat width = self.zj_width * self.progress;
        if (self.isClockwise) {
            bezierPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, width, self.progressWidth/4) cornerRadius:self.progressWidth/2];
        } else {
            bezierPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(self.zj_width - width, 0, width, self.progressWidth/4) cornerRadius:self.progressWidth/2];
        }
    }
    
    return bezierPath;
}

- (void)updatePathAnimation {
    if (self.animationDuration <= 0) {
        self.frontFillLayer.path = [self getNewBezierPath].CGPath;
        return;
    }
    
    if (self.style == ZJProgressBarRound) {
        CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        pathAnimation.duration = self.animationDuration;
        pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        pathAnimation.fromValue = [NSNumber numberWithFloat:self.oldProgress];
        pathAnimation.toValue = [NSNumber numberWithFloat:self.progress];
        pathAnimation.fillMode = kCAFillModeForwards;
        pathAnimation.removedOnCompletion = NO;
        
        [self.frontFillLayer addAnimation:pathAnimation forKey:@"strokeEndAnimation"];
    } else {
        [self setNeedsLayout];
    }
    self.oldProgress = self.progress;
}

- (void)setStyle:(ZJProgressBarStyle)style {
    _style = style;
    [self setNeedsLayout];
}

- (void)setColor:(UIColor *)color {
    _color = color;
    self.frontFillLayer.strokeColor = color.CGColor;
}

- (void)setBgColor:(UIColor *)bgColor {
    _bgColor = bgColor;
    self.backGroundLayer.strokeColor = bgColor.CGColor;
}

- (void)setProgressWidth:(CGFloat)progressWidth {
    _progressWidth = progressWidth;
    self.backGroundLayer.lineWidth = progressWidth;
    self.frontFillLayer.lineWidth = progressWidth;
    [self setNeedsLayout];
}

- (void)setProgress:(CGFloat)progress {
    if (progress < 0) {
        progress = 0;
    } else if (progress > 1.0) {
        progress = 1.0;
    }
    _progress = progress;
    [self updatePathAnimation];
    if (self.isShowProgressLabel && self.isAutoUpdateLB) {
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
