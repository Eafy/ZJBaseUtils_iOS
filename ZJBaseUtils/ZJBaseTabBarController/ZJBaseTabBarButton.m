//
//  ZJBaseTabBarButton.m
//  ZJBaseUtils
//
//  Created by eafy on 2020/11/13.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import "ZJBaseTabBarButton.h"
#import "UIView+ZJFrame.h"
#import "CAAnimation+ZJExt.h"
#import "UIView+ZJExt.h"

@interface ZJBaseTabBarButton ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *titleLB;
@property (nonatomic, strong) CAShapeLayer *waterRippleLayer;

@end

@implementation ZJBaseTabBarButton
@synthesize selected = _selected;

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.imageView = [[UIImageView alloc] init];
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:self.imageView];
    
        self.titleLB = [[UILabel alloc] init];
        self.titleLB.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.titleLB];
        
        [self addSubview:self.badge];
    }
    return self;
}

- (ZJBaseTBBadge *)badge {
    if (!_badge) {
        _badge = [[ZJBaseTBBadge alloc] init];
        _badge.hidden = YES;
    }
    return _badge;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self setConfig:self.config];
    
    CGFloat badgeX = CGRectGetMaxX(self.imageView.frame) - 2;
    CGFloat badgeY = 0;
    CGFloat badgeH = 16;
    CGFloat badgeW = 28;
    self.badge.frame = CGRectMake(badgeX, badgeY, badgeW, badgeH);
    
    if (self.isCenter) {
//        [self raisedEffectAnimation];
    }
}

- (void)scaleAnimation
{
    CABasicAnimation *anim1 = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
    CGPoint point = self.imageView.frame.origin;
    point.y = -self.imageView.zj_height * self.config.imageScaleRatio / 2.0 + self.imageView.zj_top;
    anim1.toValue = [NSNumber numberWithFloat:point.y];
    
    CABasicAnimation *anim2 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    anim2.toValue = [NSNumber numberWithFloat:self.config.imageScaleRatio];
    
    CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
    groupAnimation.fillMode = kCAFillModeForwards;
    groupAnimation.removedOnCompletion = NO;
    groupAnimation.animations = [NSArray arrayWithObjects:anim1, anim2, nil];
    
    [self.imageView.layer addAnimation:groupAnimation forKey:@"groupAnimation"];
}

- (void)raisedEffectAnimation
{
    UIControl *roundView = [[UIControl alloc] initWithFrame:CGRectMake(self.imageView.zj_left -5, self.imageView.zj_top - 5, self.imageView.zj_width + 10, self.imageView.zj_top * 2*-1)];
    roundView.tag = 123456;
    roundView.layer.cornerRadius = roundView.zj_width * 0.5 - 10;
    roundView.clipsToBounds = YES;
    roundView.backgroundColor = [UIColor whiteColor];
//    [roundView addTarget:self action:@selector(tapControl:) forControlEvents:UIControlEventTouchUpInside];
    [self insertSubview:roundView atIndex:0];
}

- (void )waterRippleAnimation
{
    if (!_imageView || self.imageView.zj_height <= 0 || self.imageView.zj_centerX <= 0) {
        return;
    }
    if (!self.config.animTyWaterRippleSize.height && !self.config.animTyWaterRippleSize.width) {
        self.config.animTyWaterRippleSize = CGSizeMake(self.imageView.zj_bottom + 10, self.imageView.zj_bottom + 10);
    }
    [self.waterRippleLayer removeFromSuperlayer];
    _waterRippleLayer = [CAShapeLayer layer];
    _waterRippleLayer.bounds = CGRectMake(0, 0, self.config.animTyWaterRippleSize.width, self.config.animTyWaterRippleSize.height);
    _waterRippleLayer.position = self.imageView.center;
    _waterRippleLayer.contentsScale = [UIScreen mainScreen].scale;
    CGFloat pulseAnimationDuration = 0.3;

    
    CAKeyframeAnimation *imageAnimation = [CAKeyframeAnimation animationWithKeyPath:@"contents"];
    imageAnimation.values = @[(id)[[self haloImageWithRadius:self.waterRippleLayer.bounds.size.width/2.0] CGImage]];    //可调整脉冲宽度
    imageAnimation.duration = pulseAnimationDuration;
    imageAnimation.calculationMode = kCAAnimationLinear;    //kCAAnimationDiscrete，kCAAnimationLinear;
    
    CABasicAnimation *pulseAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    pulseAnimation.fromValue = @0.2;   //调整脉冲起始大小
    pulseAnimation.toValue = @1.0;
    pulseAnimation.duration = pulseAnimationDuration;
    
//    CABasicAnimation *fadeOutAnim = [CABasicAnimation animationWithKeyPath:@"opacity"];
//    fadeOutAnim.fromValue = @1.0;
//    fadeOutAnim.toValue = @0.0;
//    fadeOutAnim.duration = pulseAnimationDuration;
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.duration = pulseAnimationDuration;
    animationGroup.repeatCount = 1.0;
    animationGroup.animations = @[imageAnimation, pulseAnimation];
    animationGroup.removedOnCompletion = YES;
    animationGroup.fillMode = kCAFillModeForwards;
    [self.waterRippleLayer addAnimation:animationGroup forKey:nil];
    [self.layer insertSublayer:self.waterRippleLayer below:self.imageView.layer];
}

- (UIImage*)haloImageWithRadius:(CGFloat)radius
{
    CGRect imageBounds = CGRectMake(0, 0, radius*2, radius*2);
    
    UIGraphicsBeginImageContextWithOptions(imageBounds.size, NO, UIScreen.mainScreen.scale);
    UIColor *ringColor = self.config.animTyWaterRippleColor ? self.config.animTyWaterRippleColor : [UIColor blueColor];
    [ringColor setFill];
    
    UIBezierPath *ringPath = [UIBezierPath bezierPathWithRoundedRect:imageBounds cornerRadius:imageBounds.size.height/2];
    ringPath.usesEvenOddFillRule = YES;
    [ringPath fill];
    
    UIImage *ringImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return ringImage;
}

#pragma mark -

- (void)setSelected:(BOOL)selected
{
    if (_selected == selected) return;
    super.selected = selected;
    
    _selected = selected;
    if (selected) {
        self.imageView.image = [UIImage imageNamed:self.item.selImageName];
        
        if (self.config.animType == ZJBTBConfigAnimTypeRotationY) {
             [self.imageView.layer addAnimation:[CAAnimation zj_rotationYAnimation:360] forKey:@"rotateAnimation"];
        } else if (self.config.animType == ZJBTBConfigAnimTypeEnlarge) {
            [self scaleAnimation];
        } else if (self.config.animType == ZJBTBConfigAnimTypeBoundsMin) {
            [self.imageView.layer addAnimation:[CAAnimation zj_boundsAnimation:CGPointMake(12, 12)] forKey:@"min"];
        } else if (self.config.animType == ZJBTBConfigAnimTypeBoundsMax) {
            [self.imageView.layer addAnimation:[CAAnimation zj_boundsAnimation:CGPointMake(46, 46)] forKey:@"max"];
        } else if (self.config.animType == ZJBTBConfigAnimTypeWaterRipple) {
            [self waterRippleAnimation];
        }
    } else {
        [self.imageView.layer removeAllAnimations];
        self.imageView.image = [UIImage imageNamed:self.item.norImageName];
    }
    
    self.titleLB.textColor = self.selected ? self.config.selTitleColor : self.config.norTitleColor;
    self.titleLB.font = self.selected ? self.config.selTitleFont : self.config.nolTitleFont;
}

- (void)setItem:(ZJBaseTarbarItem *)item
{
    _item = item;
    self.titleLB.text = item.norTitleName;
    if (self.selected) {
        self.imageView.image = [UIImage imageNamed:item.selImageName];
    } else {
        self.imageView.image = [UIImage imageNamed:item.norImageName];        
    }
}

- (void)setConfig:(ZJBaseTabBarConfig *)config
{
    _config = config;
    
    CGSize imageSize = self.config.imageSize;
    CGFloat imageY = self.config.imageOffset;
    if (self.config.layoutType == ZJBTBConfigLayoutTypeImage) {
        imageY = self.zj_height * 0.5 - imageSize.height * 0.5;
    }
    
    if (self.config.effectType == ZJBTBConfigSelectEffectTypeRaised && self.isCenter) {
        imageSize = CGSizeMake(self.config.centerImageSize.width, self.config.centerImageSize.height);
        imageY = self.config.centerImageOffset;
    }
    CGFloat iamgeX = self.zj_width * 0.5 - imageSize.width * 0.5;
    self.imageView.frame = CGRectMake(iamgeX, imageY, imageSize.width, imageSize.height);
    
    CGFloat titleX = 4;
    CGFloat titleH = 14.f;
    CGFloat titleW = self.zj_width - 8;
    CGFloat titleY = self.zj_height - titleH - self.config.titleOffset;
    self.titleLB.frame = CGRectMake(titleX, titleY, titleW, titleH);
    self.titleLB.font = self.selected ? self.config.selTitleFont : self.config.nolTitleFont;
    self.titleLB.textColor = self.selected ? self.config.selTitleColor : self.config.norTitleColor;
    self.titleLB.hidden = self.config.layoutType == ZJBTBConfigLayoutTypeImage;
}

@end
