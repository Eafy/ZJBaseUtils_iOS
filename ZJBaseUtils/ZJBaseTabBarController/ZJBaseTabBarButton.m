//
//  ZJBaseTabBarButton.m
//  ZJBaseUtils
//
//  Created by eafy on 2020/11/13.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import <ZJBaseUtils/ZJBaseTabBarButton.h>
#import <ZJBaseUtils/UIView+ZJFrame.h>
#import <ZJBaseUtils/CAAnimation+ZJExt.h>
#import <ZJBaseUtils/UIView+ZJExt.h>

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

- (CAShapeLayer *)waterRippleLayer {
    if (!_waterRippleLayer) {
        if (!self.config.animTyCustomLayerSize.height && !self.config.animTyCustomLayerSize.width) {
            self.config.animTyCustomLayerSize = CGSizeMake(self.imageView.zj_bottom + 10, self.imageView.zj_bottom + 10);
        }
        
        _waterRippleLayer = [CAShapeLayer layer];
        _waterRippleLayer.bounds = CGRectMake(0, 0, self.config.animTyCustomLayerSize.width, self.config.animTyCustomLayerSize.height);
        _waterRippleLayer.position = self.imageView.center;
        _waterRippleLayer.contentsScale = [UIScreen mainScreen].scale;
        if (self.config.animTyCustomLayerColor) {
            _waterRippleLayer.backgroundColor = self.config.animTyCustomLayerColor.CGColor;
        }
    }
    return _waterRippleLayer;
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

#pragma mark -

- (void)setSelected:(BOOL)selected
{
//    if (_selected == selected) return;
    super.selected = selected;
    
    _selected = selected;
    if (selected) {
        self.imageView.image = [UIImage imageNamed:self.item.selImageName];
        
        if (self.config.animType == ZJBTBConfigAnimTypeCustom && self.config.customAnimation) {
            [self.imageView.layer addAnimation:self.config.customAnimation forKey:@"customAnimation"];
            if (self.config.customLayerAnimation) {
                if (!_waterRippleLayer) {
                    [self.waterRippleLayer removeFromSuperlayer];
                }
                [self.waterRippleLayer addAnimation:self.config.customLayerAnimation forKey:@"layerAnimation"];
            }
        } else if (self.config.animType == ZJBTBConfigAnimTypeRotationY) {
             [self.imageView.layer addAnimation:[self rotationYAnimation] forKey:@"rotateAnimation"];
        } else if (self.config.animType == ZJBTBConfigAnimTypeEnlarge) {
            [self scaleEnlargeAnimation];
        } else if (self.config.animType == ZJBTBConfigAnimTypeBoundsMin) {
            [self.imageView.layer addAnimation:[self boundMinAnimation] forKey:@"min"];
        } else if (self.config.animType == ZJBTBConfigAnimTypeBoundsMax) {
            [self.imageView.layer addAnimation:[self boundMaxAnimation] forKey:@"max"];
        } else if (self.config.animType == ZJBTBConfigAnimTypeWaterRipple) {
            [self waterRippleAnimation];
        } else if (self.config.animType == ZJBTBConfigAnimTypeWaterRippleBoundsScale) {
            [self waterRippleAnimation];
            [self.imageView.layer addAnimation:[self boundMinToMaxAnimation] forKey:@"scaleAnimation"];
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

#pragma mark - Animation

/// Y轴翻转动画
- (CAAnimation *)rotationYAnimation {
    return [CAAnimation zj_rotationYAnimation:360];
}

/// 缩小
- (CAAnimation *)boundMinAnimation {
    return [CAAnimation zj_boundsAnimation:CGPointMake(12, 12)];
}

/// 放大
- (CAAnimation *)boundMaxAnimation {
    return [CAAnimation zj_boundsAnimation:CGPointMake(46, 46)];
}

/// 缩小再放大效果
- (CAAnimation *)boundMinToMaxAnimation {
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    anim.values = @[@1.0, @1.2, @0.8, @1.0];
    anim.duration = self.config.animTyDuration;
    anim.repeatCount = 1;
    return anim;
}

/// 放大效果
- (void)scaleEnlargeAnimation
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

/// 水波纹动画
- (void )waterRippleAnimation
{
    if (!_imageView || self.imageView.zj_height <= 0 || self.imageView.zj_centerX <= 0) {
        return;
    }
    if (_waterRippleLayer) {
        [self.waterRippleLayer removeFromSuperlayer];
    }
    self.waterRippleLayer.backgroundColor = [UIColor clearColor].CGColor;
    CGFloat pulseAnimationDuration = self.config.animTyDuration;
    
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
    [self.waterRippleLayer addAnimation:animationGroup forKey:@"layerAnimation"];
    [self.layer insertSublayer:self.waterRippleLayer below:self.imageView.layer];
}

- (UIImage*)haloImageWithRadius:(CGFloat)radius
{
    CGRect imageBounds = CGRectMake(0, 0, radius*2, radius*2);
    
    UIGraphicsBeginImageContextWithOptions(imageBounds.size, NO, UIScreen.mainScreen.scale);
    UIColor *ringColor = self.config.animTyCustomLayerColor ? self.config.animTyCustomLayerColor : [UIColor blueColor];
    [ringColor setFill];
    
    UIBezierPath *ringPath = [UIBezierPath bezierPathWithRoundedRect:imageBounds cornerRadius:imageBounds.size.height/2];
    ringPath.usesEvenOddFillRule = YES;
    [ringPath fill];
    
    UIImage *ringImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return ringImage;
}

/// 凸起效果
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

@end
