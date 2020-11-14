//
//  ZJBaseTBBadge.m
//  ZJBaseUtils
//
//  Created by eafy on 2020/11/14.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import "ZJBaseTBBadge.h"
#import "CAAnimation+ZJExt.h"
#import "UIView+ZJFrame.h"
#import "UIColor+ZJExt.h"

@implementation ZJBaseTBBadge

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initDefaultData];
        
        [self addSubview:self.badgeLB];
    }
    return self;
}

- (void)initDefaultData
{
    _textColor = [UIColor blackColor];
    self.backgroundColor = [UIColor zj_colorWithHexString:@"#FF4040"];
}

- (UILabel *)badgeLB
{
    if (!_badgeLB) {
        _badgeLB = [[UILabel alloc] initWithFrame:self.bounds];
        _badgeLB.textColor = self.textColor;
        _badgeLB.font = [UIFont systemFontOfSize:11.f];
        _badgeLB.textAlignment = NSTextAlignmentCenter;
        _badgeLB.layer.cornerRadius = 8.f;
        _badgeLB.layer.masksToBounds = YES;
    }
    return _badgeLB;
}

#pragma mark -

- (void)setType:(ZJBTBBadgeStyleType)type
{
    _type = type;
    if (type == ZJBTBBadgeStyleTypePoint) {
        self.badgeLB.zj_size = CGSizeMake(10, 10);
        self.badgeLB.layer.cornerRadius = 5.f;
        self.badgeLB.zj_left = 0;
        self.badgeLB.zj_top = self.zj_height * 0.5 - self.badgeLB.zj_height * 0.5;
    } else if (type == ZJBTBBadgeStyleTypeNew) {
        self.badgeLB.zj_size = CGSizeMake(self.zj_width, self.zj_height);
    } else if (type == ZJBTBBadgeStyleTypeNumber) {
        CGSize size = CGSizeZero;
        CGFloat radius = 8.f;
        if (self.badgeLB.text.length <= 1) {
            size = CGSizeMake(self.zj_height, self.zj_height);
            radius = self.zj_height * 0.5;
        } else if (self.badgeLB.text.length > 1) {
            size = self.bounds.size;
            radius = 8.f;
        }
        self.badgeLB.zj_size = size;
        self.badgeLB.layer.cornerRadius = radius;
    }

    if (self.animType == ZJBTBConfigBadgeAnimTypeShake) {   //抖动
        [self.badgeLB.layer addAnimation:[CAAnimation zj_shakeAnimationWithRepeatTimes:5.0f] forKey:@"shakeAnimation"];
    } else if (self.animType == ZJBTBConfigBadgeAnimTypeOpacity) { //透明过渡动画
        [self.badgeLB.layer addAnimation:[CAAnimation zj_opacityAnimatioinWithDurationTimes:0.3] forKey:@"opacityAniamtion"];
    } else if (self.animType == ZJBTBConfigBadgeAnimTypeScale) { //缩放动画
        [self.badgeLB.layer addAnimation:[CAAnimation zj_scaleAnimation] forKey:@"scaleAnimation"];
    }
}

- (CGSize)sizeWithAttribute:(NSString *)text {
    return [text sizeWithAttributes:@{NSFontAttributeName:self.badgeLB.font}];
}

#pragma mark -

- (void)setTextColor:(UIColor *)textColor {
    _textColor = textColor;
    self.badgeLB.textColor = textColor;
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
    _backgroundColor = backgroundColor;
    super.backgroundColor = backgroundColor;
    self.badgeLB.backgroundColor = backgroundColor;
}

- (void)setBadgeSize:(CGSize)badgeSize {
    _badgeSize = badgeSize;
    NSMutableArray *arrM = [self getTabBarButtons];
    for (ZJBaseTabBarButton *btn in arrM) {
        btn.badge.badgeLB.zj_size = badgeSize;
    }
}

- (void)setBadgeOffset:(CGPoint)badgeOffset {
    _badgeOffset = badgeOffset;
    NSMutableArray *arrM = [self getTabBarButtons];
    for (ZJBaseTabBarButton *btn in arrM) {
        btn.badge.badgeLB.zj_left += badgeOffset.x;
        btn.badge.badgeLB.zj_top += badgeOffset.y;
    }
}

- (void)setBadgeRadius:(CGFloat)badgeRadius {
    _badgeRadius = badgeRadius;
    NSMutableArray *arrM = [self getTabBarButtons];
    for (ZJBaseTabBarButton *btn in arrM) {
        btn.badge.badgeLB.layer.cornerRadius = badgeRadius;
    }
}

- (void)badgeRadius:(CGFloat)radius atIndex:(NSInteger)index {
    ZJBaseTabBarButton *tabBarButton = [self getTabBarButtonAtIndex:index];
    tabBarButton.badge.badgeLB.layer.cornerRadius = radius;
}


- (void)showPointBadgeAtIndex:(NSInteger)index{
    ZJBaseTabBarButton *tabBarButton = [self getTabBarButtonAtIndex:index];
    tabBarButton.badge.hidden = NO;
    tabBarButton.badge.type = ZJBTBBadgeValueTypePoint;
}

- (void)showNewBadgeAtIndex:(NSInteger)index {
    ZJBaseTabBarButton *tabBarButton = [self getTabBarButtonAtIndex:index];
    tabBarButton.badge.hidden = NO;
    tabBarButton.badge.badgeLB.text = @"new".localized;
    tabBarButton.badge.type = ZJBTBBadgeValueTypeNew;
}

- (void)showNumberBadgeValue:(NSString *)badgeValue AtIndex:(NSInteger)index {
    ZJBaseTabBarButton *tabBarButton = [self getTabBarButtonAtIndex:index];
    tabBarButton.badge.hidden = NO;
    tabBarButton.badge.badgeLB.text = badgeValue;
    tabBarButton.badge.type = ZJBTBBadgeValueTypeNumber;
}

- (void)hideBadgeAtIndex:(NSInteger)index {
    [self getTabBarButtonAtIndex:index].badge.hidden = YES;
}

@end
