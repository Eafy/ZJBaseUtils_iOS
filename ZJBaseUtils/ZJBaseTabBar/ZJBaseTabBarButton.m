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
    
    if (self.tag == self.config.scaleIndex) {
        [self scaleAnimation];
    }
}

#pragma mark -

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


- (void)setSelected:(BOOL)selected
{
    if (_selected == selected) return;
    
    _selected = selected;
    if (selected) {
        self.titleLB.textColor = self.config.selTitleColor;
        self.imageView.image = [UIImage imageNamed:self.item.selImageName];
        
        if (self.config.animType == ZJBTBConfigAnimTypeRotationY) {
             [self.imageView.layer addAnimation:[CAAnimation zj_rotationYAnimation:360] forKey:@"rotateAnimation"];
        } else if (self.config.animType == ZJBTBConfigAnimTypeScale) {
            if (self.config.scaleIndex < 0) {
                [self scaleAnimation];
            }
        } else if (self.config.animType == ZJBTBConfigAnimTypeBoundsMin) {
            [self.imageView.layer addAnimation:[CAAnimation zj_boundsAnimation:CGPointMake(12, 12)] forKey:@"min"];
        } else if (self.config.animType == ZJBTBConfigAnimTypeBoundsMax) {
            [self.imageView.layer addAnimation:[CAAnimation zj_boundsAnimation:CGPointMake(46, 46)] forKey:@"max"];
        }
    } else {
        self.titleLB.textColor = self.config.norTitleColor;
        self.imageView.image = [UIImage imageNamed:self.item.norImageName];
        if (self.config.scaleIndex < 0 || self.tag != self.config.scaleIndex) {
            [self.imageView.layer removeAllAnimations];
        }
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
    if (self.config.animType == ZJBTBConfigLayoutTypeImage) {
        imageY = self.zj_height * 0.5 - imageSize.height * 0.5;
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
    self.titleLB.hidden = self.config.animType == ZJBTBConfigLayoutTypeImage;
}

@end
