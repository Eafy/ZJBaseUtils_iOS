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
    self.backgroundColor = [UIColor clearColor];
    _badgeTextColor = [UIColor blackColor];
    _badgeBackgroundColor = [UIColor zj_colorWithHexString:@"#FF4040"];
}

- (UILabel *)badgeLB
{
    if (!_badgeLB) {
        _badgeLB = [[UILabel alloc] initWithFrame:self.bounds];
        _badgeLB.textColor = self.badgeTextColor;
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
        [self.badgeLB.layer addAnimation:[CAAnimation zj_scaleAnimation:1.3f] forKey:@"scaleAnimation"];
    }
}

- (CGSize)sizeWithAttribute:(NSString *)text {
    return [text sizeWithAttributes:@{NSFontAttributeName:self.badgeLB.font}];
}

#pragma mark -

- (void)setBadgeTextColor:(UIColor *)badgeTextColor {
    _badgeTextColor = badgeTextColor;
    self.badgeLB.textColor = badgeTextColor;
}

- (void)setBadgeBackgroundColor:(UIColor *)badgeBackgroundColor {
    _badgeBackgroundColor = badgeBackgroundColor;
    self.badgeLB.backgroundColor = badgeBackgroundColor;
}

- (void)setBadgeSize:(CGSize)badgeSize {
    _badgeSize = badgeSize;
    self.badgeLB.zj_size = badgeSize;
}

- (void)setBadgeOffset:(CGPoint)badgeOffset {
    _badgeOffset = badgeOffset;
    self.badgeLB.zj_left += badgeOffset.x;
    self.badgeLB.zj_top += badgeOffset.y;
}

- (void)setBadgeRadius:(CGFloat)badgeRadius {
    _badgeRadius = badgeRadius;
    self.badgeLB.layer.cornerRadius = badgeRadius;
}

@end
