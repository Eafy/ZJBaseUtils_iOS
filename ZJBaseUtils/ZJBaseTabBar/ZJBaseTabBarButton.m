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
        [self addSubview:self.imageView];
    
        self.titleLB = [[UILabel alloc] init];
        self.titleLB.textAlignment = NSTextAlignmentCenter;
        self.titleLB.font = [UIFont systemFontOfSize:self.item.titleFont];
        [self addSubview:self.titleLB];
        
        self.badge = [[ZJBaseTBBadge alloc] init];
        self.badge.hidden = YES;
        [self addSubview:self.badge];
        
        if (self.item.animType == ZJBTBConfigLayoutTypeImage) {
            self.titleLB.hidden = YES;
            
            CGSize imageSize = self.item.imageSize;
            CGFloat imageX = self.zj_width * 0.5 - imageSize.width * 0.5;
            CGFloat imageY = self.zj_height * 0.5 - imageSize.height * 0.5;
            self.imageView.frame = CGRectMake(imageX, imageY, imageSize.width, imageSize.height);
        }
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGSize imageSize = self.item.imageSize;
    CGFloat imageY = self.item.imageOffset;
    if (self.item.animType == ZJBTBConfigLayoutTypeImage) {
        imageY = self.zj_height * 0.5 - imageSize.height * 0.5;
    }
    CGFloat iamgeX = self.zj_width * 0.5 - imageSize.width * 0.5;
    self.imageView.frame = CGRectMake(iamgeX, imageY, imageSize.width, imageSize.height);
    
    CGFloat titleX = 4;
    CGFloat titleH = 14.f;
    CGFloat titleW = self.zj_width - 8;
    CGFloat titleY = self.zj_height - titleH - self.item.titleOffset;
    self.titleLB.frame = CGRectMake(titleX, titleY, titleW, titleH);
    
    CGFloat badgeX = CGRectGetMaxX(self.imageView.frame) - 6;
    CGFloat badgeY = CGRectGetMinY(self.imageView.frame) - 2;
    CGFloat badgeH = 16;
    CGFloat badgeW = 24;
    self.badge.frame = CGRectMake(badgeX, badgeY, badgeW, badgeH);
}

- (void)setSelected:(BOOL)selected
{
    if (_selected == selected) return;
    
    _selected = selected;
    if (selected) {
        self.titleLB.textColor = self.item.selTitleColor;
        self.imageView.image = [UIImage imageNamed:self.item.selImageName];
        
        if (self.item.animType == ZJBTBConfigAnimTypeRotationY) {
             [self.imageView.layer addAnimation:[CAAnimation zj_rotationYAnimation:360] forKey:@"rotateAnimation"];
        } else if (self.item.animType == ZJBTBConfigAnimTypeScale) {
            
            CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
            CGPoint point = self.imageView.frame.origin;
            point.y -= 15;
            anim.toValue = [NSNumber numberWithFloat:point.y];
            
            CABasicAnimation *anim1 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
            anim1.toValue = [NSNumber numberWithFloat:1.3f];
            
            CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
            groupAnimation.fillMode = kCAFillModeForwards;
            groupAnimation.removedOnCompletion = NO;
            groupAnimation.animations = [NSArray arrayWithObjects:anim,anim1, nil];
            
            [self.imageView.layer addAnimation:groupAnimation forKey:@"groupAnimation"];
        } else if (self.item.animType == ZJBTBConfigAnimTypeBoundsMin) {
            [self.imageView.layer addAnimation:[CAAnimation zj_boundsAnimation:CGPointMake(12, 12)] forKey:@"min"];
        } else if (self.item.animType == ZJBTBConfigAnimTypeBoundsMax) {
            [self.imageView.layer addAnimation:[CAAnimation zj_boundsAnimation:CGPointMake(46, 46)] forKey:@"max"];
        }
    } else {
        self.titleLB.textColor = self.item.norTitleColor;
        self.imageView.image = [UIImage imageNamed:self.item.norImageName];
        [self.imageView.layer removeAllAnimations];
    }
}

@end
