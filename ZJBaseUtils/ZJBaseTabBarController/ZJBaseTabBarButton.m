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

@interface ZJBaseTabBarButton ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *titleLB;

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
        
        self.badge = [[ZJBaseTBBadge alloc] init];
        self.badge.hidden = YES;
        [self addSubview:self.badge];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self setConfig:self.config];
    
    CGFloat badgeX = CGRectGetMaxX(self.imageView.frame) - 6;
    CGFloat badgeY = CGRectGetMinY(self.imageView.frame) - 2;
    CGFloat badgeH = 16;
    CGFloat badgeW = 24;
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

#pragma mark -

- (void)setSelected:(BOOL)selected
{
    if (_selected == selected) return;
    super.selected = selected;
    
    _selected = selected;
    if (selected) {
        self.titleLB.textColor = self.config.selTitleColor;
        self.imageView.image = [UIImage imageNamed:self.item.selImageName];
        
        if (self.config.animType == ZJBTBConfigAnimTypeRotationY) {
             [self.imageView.layer addAnimation:[CAAnimation zj_rotationYAnimation:360] forKey:@"rotateAnimation"];
        } else if (self.config.animType == ZJBTBConfigAnimTypeScale) {
            [self scaleAnimation];
        } else if (self.config.animType == ZJBTBConfigAnimTypeBoundsMin) {
            [self.imageView.layer addAnimation:[CAAnimation zj_boundsAnimation:CGPointMake(12, 12)] forKey:@"min"];
        } else if (self.config.animType == ZJBTBConfigAnimTypeBoundsMax) {
            [self.imageView.layer addAnimation:[CAAnimation zj_boundsAnimation:CGPointMake(46, 46)] forKey:@"max"];
        }
    } else {
        self.titleLB.textColor = self.config.norTitleColor;
        self.imageView.image = [UIImage imageNamed:self.item.norImageName];
        [self.imageView.layer removeAllAnimations];
    }
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
    self.titleLB.font = [UIFont systemFontOfSize:self.config.titleFont];
    self.titleLB.textColor = self.selected ? self.config.selTitleColor : self.config.norTitleColor;
    self.titleLB.hidden = self.config.layoutType == ZJBTBConfigLayoutTypeImage;
}

@end
