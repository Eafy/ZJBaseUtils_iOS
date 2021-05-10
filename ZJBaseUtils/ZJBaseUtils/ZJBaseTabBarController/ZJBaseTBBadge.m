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
#import "NSString+ZJExt.h"

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
    self.badgeTextColor = [UIColor whiteColor];
    self.badgeBackgroundColor = ZJColorFromRGB(0xFF4040);
}

- (UILabel *)badgeLB
{
    if (!_badgeLB) {
        _badgeLB = [[UILabel alloc] initWithFrame:self.bounds];
        _badgeLB.textColor = self.badgeTextColor;
        _badgeLB.font = [UIFont systemFontOfSize:12.f];
        _badgeLB.textAlignment = NSTextAlignmentCenter;
    }
    return _badgeLB;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.type == ZJBTBBadgeStyleTypePoint) {
        self.badgeLB.zj_size = CGSizeMake(6, 6);
        self.badgeLB.zj_left = 0;
        self.badgeLB.zj_top = self.zj_height * 0.5 - self.badgeLB.zj_height * 0.5;
    } else if (self.type == ZJBTBBadgeStyleTypeNew) {
        self.badgeLB.zj_size = CGSizeMake(self.zj_width, self.zj_height);
    } else if (self.type == ZJBTBBadgeStyleTypeNumber) {
        CGSize size = CGSizeZero;
        if (self.badgeLB.text.length <= 1) {
            size = CGSizeMake(self.zj_height, self.zj_height);
        } else if (self.badgeLB.text.length > 1) {
            size = [self.badgeLB.text zj_sizeWithFont:self.badgeLB.font maxSize:CGSizeZero];
            if (size.width >= self.zj_width) {
                self.zj_width = size.width + 2;
            } else if (size.width < self.zj_height) {
                size.width = self.zj_height;
            }
        }
        self.badgeLB.zj_height = self.zj_height;
        self.badgeLB.zj_width = size.width;
    }
    
    self.badgeLB.layer.cornerRadius = self.badgeLB.zj_height/2;
    self.badgeLB.layer.masksToBounds = YES;

    if (self.animType == ZJBTBConfigBadgeAnimTypeShake) {   //抖动
        [self.badgeLB.layer addAnimation:[CAAnimation zj_shakeAnimationWithRepeatTimes:5.0f] forKey:@"shakeAnimation"];
    } else if (self.animType == ZJBTBConfigBadgeAnimTypeOpacity) { //透明过渡动画
        [self.badgeLB.layer addAnimation:[CAAnimation zj_opacityAnimatioinWithDurationTimes:0.3] forKey:@"opacityAniamtion"];
    } else if (self.animType == ZJBTBConfigBadgeAnimTypeScale) { //缩放动画
        [self.badgeLB.layer addAnimation:[CAAnimation zj_scaleAnimation:1.3f] forKey:@"scaleAnimation"];
    }
}

#pragma mark -

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
