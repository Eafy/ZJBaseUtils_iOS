//
//  ZJNotifyHUD.m
//  ZJBaseUtils
//
//  Created by eafy on 2020/10/15.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import <ZJBaseUtils/ZJNotifyHUD.h>
#import <ZJBaseUtils/ZJScreen.h>
#import <ZJBaseUtils/NSString+ZJExt.h>
#import <ZJBaseUtils/UIColor+ZJExt.h>
#import <ZJBaseUtils/UIView+ZJFrame.h>
#import <ZJBaseUtils/ZJBundleRes.h>
#import <ZJBaseUtils/NSString+ZJExt.h>

@interface ZJNotifyHUD ()

@property (nonatomic,strong) UIWindow *mainWindow;
@property (nonatomic,strong) UIWindow *overlayWindow;
@property (nonatomic,assign) BOOL isShowLan;

@property (nonatomic,strong) NSDate *showStartDate;
@property (nonatomic,assign) CGFloat minShowTime;
@property (nonatomic,strong) NSTimer *minShowTimer;
@property (nonatomic,assign) CGAffineTransform rotationTransform;
@property (nonatomic,assign) CGFloat yOffset;
@property (nonatomic,assign) CGFloat yPosEnd;
@property (nonatomic,assign) CGFloat duration;
@property (nonatomic,assign) BOOL isMark;

@property (nonatomic,strong) UIImageView *iconImgView;
@property (nonatomic,strong) UILabel *titleLB;

@end

@implementation ZJNotifyHUD
static ZJNotifyHUD *_shared;

+ (instancetype)shared {
    if (!_shared) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^ {
            _shared = [[ZJNotifyHUD alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
            [_shared defaultConfig];
        });
    }
    return _shared;
}

- (void)defaultConfig
{
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
    _rotationTransform = CGAffineTransformIdentity;
    _font = [UIFont systemFontOfSize:16];
    _titleColor = [UIColor whiteColor];
    _cornerRadius = 4.f;
    _marginUpDown = 6.;
    _marginLeftRight = 12.f;
    _animationType = ZJNotifyHUDAnimationFade;
    _rightViewStyle = ZJNotifyHUDRightViewStyleNone;
    
    _iconImage = nil;
    _tapRightBtnUpInsideCompletion = nil;
    if (_iconImgView) {
        [self.iconImgView removeFromSuperview];
        _iconImgView = nil;
    }
}

- (void)configHubPara
{
    self.titleLB.font = self.font;
    self.titleLB.textColor = self.titleColor;
    self.layer.cornerRadius = self.cornerRadius;
    self.layer.masksToBounds = YES;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
        
    if (self.animationType <= ZJNotifyHUDAnimationZoomIn ||
        self.animationType == ZJNotifyHUDAnimationPopBottom) {
        self.frame = [self assemblyLastframe];
    }
}

- (CGRect)assemblyLastframe
{
    UIView *parent = self.superview;
    if (parent) {
        self.frame = parent.bounds;
    }
    CGRect bounds = self.bounds;
    
    CGFloat maxWidth = bounds.size.width - 2 * self.marginLeftRight;
    CGFloat maxHeight = bounds.size.height - 2 * self.marginUpDown;
    CGFloat minWidth = self.marginLeftRight;
    CGFloat minHeight = 0;
    
    [self.titleLB sizeToFit];
    CGSize labelSize = [self.titleLB.text zj_sizeWithFont:self.titleLB.font maxSize:CGSizeZero];
    minHeight = labelSize.height + self.textSpace + 2 * self.marginUpDown;
    minHeight = MIN(minHeight, maxHeight);
    
    if (labelSize.width > maxWidth) {
        if (labelSize.width > maxWidth) {
            labelSize.height = labelSize.height * 2;
        }
        if (labelSize.width > self.titleLB.zj_width) {
            labelSize.width = self.titleLB.zj_width;
        }
    }
    
    CGSize iconImgSize = self.iconImgView.image.size;
    if (!CGSizeEqualToSize(iconImgSize, CGSizeZero)) {
        if (iconImgSize.height > minHeight - self.marginUpDown ||
            iconImgSize.width > minHeight - self.marginUpDown) {
            iconImgSize.height = minHeight - self.marginUpDown;
            iconImgSize.width = iconImgSize.height;
        }
        minWidth += self.marginLeftRight;
        minWidth += iconImgSize.width;
        
        self.iconImgView.frame = CGRectMake(self.marginLeftRight, (minHeight-iconImgSize.height)/2, iconImgSize.width, iconImgSize.height);
        maxWidth -= iconImgSize.width;
    } else if (_iconImgView) {
        [self.iconImgView removeFromSuperview];
        _iconImgView = nil;
    }
    labelSize.width = MIN(labelSize.width, maxWidth);
    self.titleLB.frame = CGRectMake(minWidth, (minHeight-labelSize.height)/2, labelSize.width, labelSize.height);
    
    minWidth += self.titleLB.zj_width;
    minWidth += self.marginLeftRight;
    
    if (self.rightViewStyle != ZJNotifyHUDRightViewStyleNone && _tapRightBtnUpInsideCompletion) {
        
        CGSize sizeTitle = [[self.rightOperationBtn titleForState:UIControlStateNormal] zj_sizeWithFont:self.rightOperationBtn.titleLabel.font maxSize:CGSizeZero];
        CGSize sizeImg = [self.rightOperationBtn imageForState:UIControlStateNormal].size;
        self.rightOperationBtn.zj_height = minHeight - 4;   //按钮高度
        minWidth += self.marginLeftRight/2;
        
        if (self.rightOperationBtn.backgroundColor != [UIColor clearColor]) {
            self.rightOperationBtn.zj_width = sizeTitle.width + sizeImg.width + 32;   //按钮宽度
            minWidth += self.rightOperationBtn.zj_width + 8;
            self.rightOperationBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        } else {
            self.rightOperationBtn.zj_width = sizeTitle.width + sizeImg.width;
            minWidth += self.rightOperationBtn.zj_width;
            self.rightOperationBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
            [self.rightOperationBtn setTitleColor:self.titleColor forState:UIControlStateNormal];
        }
        
        self.rightOperationBtn.frame = CGRectMake(minWidth-self.marginLeftRight-self.rightOperationBtn.zj_width, (minHeight-self.rightOperationBtn.zj_height)/2, self.rightOperationBtn.zj_width, self.rightOperationBtn.zj_height);
    } else if (_rightOperationBtn) {
        [self.rightOperationBtn removeFromSuperview];
        _rightOperationBtn = nil;
    }
    
    CGFloat yPosEnd = 0;
    CGFloat xPosEnd = 0;
    if (self.isShowLan) {
        xPosEnd = (ZJScreenHeight() - minWidth)/2;
        yPosEnd = (ZJScreenWidth() - minHeight)/2;
    } else {
        xPosEnd = (ZJScreenWidth() - minWidth)/2;
        yPosEnd = (ZJScreenHeight() - minHeight)/2;
    }
    
    yPosEnd += self.yOffset;    //偏移
    if (self.animationType == ZJNotifyHUDAnimationPopDownToUp ||
        self.animationType == ZJNotifyHUDAnimationPopDownToDown) {
        self.yPosEnd = yPosEnd;
        yPosEnd = 0;
    } else if (self.animationType == ZJNotifyHUDAnimationPopUpToDown ||
               self.animationType == ZJNotifyHUDAnimationPopUpToUp) {
        self.yPosEnd = yPosEnd;
        yPosEnd = ZJScreenHeight();
    } else if (self.animationType == ZJNotifyHUDAnimationPopBottom) {
        yPosEnd = ZJScreenHeight() - ZJTabarBarHeight() - minHeight;
        self.overlayWindow.frame = CGRectMake(xPosEnd, yPosEnd, minWidth, minHeight);   //调整Window的大小，否则底部视图无法点击
        xPosEnd = yPosEnd= 0;
    }
        
    return CGRectMake(xPosEnd, yPosEnd, minWidth, minHeight);
}

#pragma mark -

- (UIWindow *)overlayWindow
{
    if (!_overlayWindow) {
        if (!_mainWindow) {
            _mainWindow = [ZJScreen keyWindow];
        }
        _overlayWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _overlayWindow.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin
                                | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        _overlayWindow.backgroundColor = [UIColor clearColor];
        _overlayWindow.userInteractionEnabled = NO;
        
        if (_mainWindow) {
            [_mainWindow addSubview:_overlayWindow];
        }
    }
    return _overlayWindow;
}

- (UIImageView *)iconImgView
{
    if (!_iconImgView) {
        _iconImgView = [[UIImageView alloc] init];
        _iconImgView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_iconImgView];
    }
    return _iconImgView;
}

- (UILabel *)titleLB
{
    if (!_titleLB) {
        _titleLB = [[UILabel alloc] init];
        _titleLB.textAlignment = NSTextAlignmentLeft;
        _titleLB.numberOfLines = 0;
//        _titleLB.adjustsFontSizeToFitWidth = NO;
        [self addSubview:_titleLB];
    }
    return _titleLB;
}

- (UIButton *)rightOperationBtn
{
    if (!_rightOperationBtn) {
        _rightOperationBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 0)];
        _rightOperationBtn.backgroundColor = [UIColor clearColor];
        _rightOperationBtn.layer.cornerRadius = 4;
        _rightOperationBtn.layer.masksToBounds = YES;
        [self addSubview:_rightOperationBtn];
    }
    return _rightOperationBtn;
}

#pragma mark -

- (void)setTapRightBtnUpInsideCompletion:(void (^)(UIButton * _Nonnull))tapRightBtnUpInsideCompletion
{
    _tapRightBtnUpInsideCompletion = tapRightBtnUpInsideCompletion;
    
    if (tapRightBtnUpInsideCompletion) {
        [self.rightOperationBtn addTarget:self action:@selector(clickedTapRightBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    } else {
        [self.rightOperationBtn removeTarget:self action:@selector(clickedTapRightBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)clickedTapRightBtnAction:(UIButton *)btn
{
    if (_tapRightBtnUpInsideCompletion) {
        NSLog(@"Notify HUD right button has been clicked");
        self.tapRightBtnUpInsideCompletion(btn);
        self.tapRightBtnUpInsideCompletion = nil;
        [self hide];
    }
}

#pragma mark - Show & Hide Animation

- (void)show:(BOOL)animated
{
    self.overlayWindow.frame = [[UIScreen mainScreen] bounds];
    [self showUsingAnimation:animated];
}

- (void)showUsingAnimation:(BOOL)animated
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [self setNeedsDisplay];

    if (animated) {
        if (self.animationType == ZJNotifyHUDAnimationZoomIn) {
            self.transform = CGAffineTransformConcat(_rotationTransform, CGAffineTransformMakeScale(0.5f, 0.5f));
        } else if (self.animationType == ZJNotifyHUDAnimationZoomOut) {
            self.transform = CGAffineTransformConcat(_rotationTransform, CGAffineTransformMakeScale(1.5f, 1.5f));
        } else if (self.animationType == ZJNotifyHUDAnimationPopDownToUp ||
                   self.animationType == ZJNotifyHUDAnimationPopDownToDown ||
                   self.animationType == ZJNotifyHUDAnimationPopUpToDown ||
                   self.animationType == ZJNotifyHUDAnimationPopUpToUp) {
            self.frame = [self assemblyLastframe];
        }
    }

    if (animated) {
        self.showStartDate = [NSDate date];
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.30];
        self.alpha = 1.0f;
        if (self.animationType == ZJNotifyHUDAnimationZoomIn ||
            self.animationType == ZJNotifyHUDAnimationZoomOut) {
            self.transform = _rotationTransform;
        } else if (self.animationType == ZJNotifyHUDAnimationPopDownToUp ||
                   self.animationType == ZJNotifyHUDAnimationPopDownToDown ||
                   self.animationType == ZJNotifyHUDAnimationPopUpToDown ||
                   self.animationType == ZJNotifyHUDAnimationPopUpToUp) {
            self.zj_top = self.yPosEnd;
        }
        [UIView commitAnimations];
    } else {
        self.showStartDate = nil;
        self.alpha = 1.0f;
    }
}

- (void)hide:(BOOL)animated afterDelay:(NSTimeInterval)delay
{
    if (delay > 0) {
        [self performSelector:@selector(hideDelayed:) withObject:[NSNumber numberWithBool:animated] afterDelay:delay];        
    }
}

- (void)hideDelayed:(NSNumber *)animated
{
    if (self.minShowTime > 0.0 && self.showStartDate) {
        NSTimeInterval interv = [[NSDate date] timeIntervalSinceDate:self.showStartDate];
        if (interv < self.minShowTime) {
            if (_minShowTimer) {
                [self.minShowTimer invalidate];
                _minShowTimer = nil;
            }
            self.minShowTimer = [NSTimer scheduledTimerWithTimeInterval:(self.minShowTime - interv) target:self selector:@selector(handleMinShowTimer:) userInfo:nil repeats:NO];
            return;
        }
    }
    
    [self hideUsingAnimation:[animated boolValue]];
}

- (void)hide
{
    [self hideUsingAnimation:YES];
}

- (void)dismiss {
    [self hideUsingAnimation:NO];
}

- (void)handleMinShowTimer:(NSTimer *)theTimer
{
    [self hideUsingAnimation:self.showStartDate != nil ? YES : NO];
}

- (void)hideUsingAnimation:(BOOL)animated
{
    if (animated && self.showStartDate) {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.30];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector:@selector(animationFinished:finished:context:)];

        if (self.animationType == ZJNotifyHUDAnimationZoomIn) {
            self.transform = CGAffineTransformConcat(_rotationTransform, CGAffineTransformMakeScale(1.5f, 1.5f));
        } else if (self.animationType == ZJNotifyHUDAnimationZoomOut) {
            self.transform = CGAffineTransformConcat(_rotationTransform, CGAffineTransformMakeScale(0.5f, 0.5f));
        } else if (self.animationType == ZJNotifyHUDAnimationPopDownToUp ||
                   self.animationType == ZJNotifyHUDAnimationPopUpToUp) {
            self.zj_top = 0;
        } else if (self.animationType == ZJNotifyHUDAnimationPopDownToDown ||
                   self.animationType == ZJNotifyHUDAnimationPopUpToDown) {
            self.zj_top = ZJScreenHeight();
        }

        self.alpha = 0.02f;
        [UIView commitAnimations];
    } else {
        self.alpha = 0.0f;
        [self done];
    }
}

- (void)animationFinished:(NSString *)animationID finished:(BOOL)finished context:(void*)context
{
    [self done];
}

- (void)done
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];

    self.transform = self.rotationTransform = CGAffineTransformIdentity;
    self.alpha = 0.0f;
    if (self.superview) {
        [self removeFromSuperview];
        self.frame = [[UIScreen mainScreen] bounds];
    }
    
    if (self.mainWindow) {
        [self.mainWindow makeKeyAndVisible];
    }

    if (_overlayWindow) {
        self.overlayWindow.userInteractionEnabled = NO;
        if (self.isShowLan) {
            self.isShowLan = NO;
        }
        _overlayWindow.transform = CGAffineTransformIdentity;
        [self.overlayWindow resignKeyWindow];
        [self.overlayWindow removeFromSuperview];
        _overlayWindow = nil;
    }
    
    if (_rightOperationBtn) {
        [_rightOperationBtn removeFromSuperview];
        _rightOperationBtn = nil;
        _tapRightBtnUpInsideCompletion = nil;
    }
    _iconImage = nil;
    if (_iconImgView) {
        [_iconImgView removeFromSuperview];
        _iconImgView = nil;
    }
    
    if (self.showStartDate && _delegate && [self.delegate respondsToSelector:@selector(hudWasHidden:)]) {
        [self.delegate performSelector:@selector(hudWasHidden:) withObject:self];
    }
    self.showStartDate = nil;
}

- (void)configIconImage:(NSString *)iconImgName
{
    if (iconImgName) {
        self.iconImgView.image = [UIImage imageNamed:iconImgName];
        if (self.iconImage && !self.iconImgView.image) {
            self.iconImgView.image = self.iconImage;
        }
    } else if (self.iconImage) {
        self.iconImgView.image = self.iconImage;
    }
    if (!_iconImgView.image && _iconImgView) {
        [_iconImgView removeFromSuperview];
        _iconImgView = nil;
    }
}

#pragma mark -

- (void)configOverlay {
    if (self.superview) {
        [self removeFromSuperview];
    }
    [self.overlayWindow addSubview:self];
    [self.overlayWindow makeKeyAndVisible];
    if (self.isShowLan) {
        self.overlayWindow.transform = CGAffineTransformMakeRotation(M_PI_2);
    }
    
    if (self.rightViewStyle != ZJNotifyHUDRightViewStyleNone && _tapRightBtnUpInsideCompletion) {
        self.overlayWindow.userInteractionEnabled = YES;
    } else {
        self.overlayWindow.userInteractionEnabled = self.isMark;
    }
}

- (void)configWithIconName:(NSString *)iconName title:(NSString *)title duration:(NSTimeInterval)duration mark:(BOOL)isMark yOffset:(CGFloat)yOffset {
    self.isMark = isMark;
    [self configOverlay];

    self.yOffset = yOffset;
    self.titleLB.text = title;
    [self.titleLB sizeToFit];
    self.duration = duration;
    [self configHubPara];
    [self configIconImage:iconName];
}

- (void)showHubWithIconName:(NSString *)iconName title:(NSString *)title duration:(NSTimeInterval)duration mark:(BOOL)isMark yOffset:(CGFloat)yOffset
{
    [self configWithIconName:iconName title:title duration:duration mark:isMark yOffset:yOffset];

    [self show];
}

- (void)show {
    [self configOverlay];
    
    [self show:YES];
    [self hide:YES afterDelay:_rightOperationBtn ? 0: self.duration];
}

#pragma mark - 默认样式

/// 禁止
+ (instancetype)caveatWithTitle:(NSString *)title duration:(NSTimeInterval)duration
{
    [ZJNotifyHUD shared].font = [UIFont systemFontOfSize:14];
    [ZJNotifyHUD shared].titleColor = ZJColorFromRGB(0xF45C5C);
    [ZJNotifyHUD shared].cornerRadius = 4;
    [ZJNotifyHUD shared].backgroundColor = ZJColorFromRGB(0xFEECEE);
    [[ZJNotifyHUD shared] configWithIconName:nil title:title duration:duration mark:YES yOffset:0];
    
    return [ZJNotifyHUD shared];
}

+ (instancetype)showCaveatWithTitle:(NSString *)title duration:(NSTimeInterval)duration
{
    [ZJNotifyHUD shared].iconImage = [ZJBundleRes imageNamed:@"icon_uxkit_caveat"];
    [[ZJNotifyHUD caveatWithTitle:title duration:duration] show];
    return [ZJNotifyHUD shared];
}

/// 警告
+ (instancetype)warningWithTitle:(NSString *)title duration:(NSTimeInterval)duration
{
    [ZJNotifyHUD shared].font = [UIFont systemFontOfSize:14];
    [ZJNotifyHUD shared].titleColor = ZJColorFromRGB(0xFFBE20);
    [ZJNotifyHUD shared].cornerRadius = 4;
    [ZJNotifyHUD shared].backgroundColor = ZJColorFromRGB(0xFFF8E4);
    [[ZJNotifyHUD shared] configWithIconName:nil title:title duration:duration mark:YES yOffset:0];
    
    return [ZJNotifyHUD shared];
}

+ (instancetype)showWarningWithTitle:(NSString *)title duration:(NSTimeInterval)duration
{
    [ZJNotifyHUD shared].iconImage = [ZJBundleRes imageNamed:@"icon_uxkit_warning"];
    [[ZJNotifyHUD warningWithTitle:title duration:duration] show];
    return [ZJNotifyHUD shared];
}

/// 成功
+ (instancetype)successWithTitle:(NSString *)title duration:(NSTimeInterval)duration
{
    [ZJNotifyHUD shared].font = [UIFont systemFontOfSize:14];
    [ZJNotifyHUD shared].titleColor = ZJColorFromRGB(0x64DC4A);
    [ZJNotifyHUD shared].cornerRadius = 4;
    [ZJNotifyHUD shared].backgroundColor = ZJColorFromRGB(0xEEFAEC);
    [[ZJNotifyHUD shared] configWithIconName:nil title:title duration:duration mark:YES yOffset:0];
    
    return [ZJNotifyHUD shared];
}

+ (instancetype)showSuccessWithTitle:(NSString *)title duration:(NSTimeInterval)duration
{
    [ZJNotifyHUD shared].iconImage = [ZJBundleRes imageNamed:@"icon_uxkit_success"];
    [[ZJNotifyHUD successWithTitle:title duration:duration] show];
    return [ZJNotifyHUD shared];
}

+ (void)defaultHubWithIconName:(NSString * _Nullable)iconName title:(NSString *)title duration:(NSTimeInterval)duration mark:(BOOL)isMark yOffset:(CGFloat)yOffset
{
    [[ZJNotifyHUD shared] defaultConfig];
    [[ZJNotifyHUD shared] showHubWithIconName:iconName title:title duration:duration mark:isMark yOffset:yOffset];
}

@end
