//
//  ZJCalendarWeekTitleView.m
//  ZJUXKit
//
//  Created by eafy on 2020/9/25.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import "ZJCalendarWeekTitleView.h"
#import "ZJLocalization.h"
#import "UIColor+ZJExt.h"

@implementation ZJCalendarWeekTitleView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.titleLabel];
        [self addWeekTitles];
    }
    return self;
}

- (void)addWeekTitles {
    NSArray *titles = @[@"Sun".localized,  @"Mon".localized, @"Tue".localized, @"Wed".localized, @"Thu".localized, @"Fri".localized, @"Sat".localized];
    for (int i = 1; i <= titles.count; i ++) {
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:12];
        label.textColor = ZJColorFromRGB(0x5A6482);
        if (i==1 || i==7) {
            label.textColor = ZJColorFromRGB(0x3D7DFF);
        }
        label.textAlignment = NSTextAlignmentCenter;
        label.tag = i;
        label.text = titles[i-1];
        [self addSubview:label];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat width = floor(self.bounds.size.width/7);
    for (UIView *label in self.subviews) {
        NSInteger i = label.tag;
        if (i>=1 && i<=7) {
            label.frame = CGRectMake((width*(i-1)), 0, width, self.bounds.size.height-26);
        }
    }
    self.titleLabel.frame = CGRectMake(0, self.bounds.size.height-26, self.bounds.size.width, 20);
    
    self.layer.shadowColor = [UIColor colorWithRed:24/255.0 green:30/255.0 blue:40/255.0 alpha:0.04].CGColor;
    self.layer.shadowOffset = CGSizeMake(0,8);
    self.layer.shadowOpacity = 1;
    self.layer.shadowRadius = 8;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont boldSystemFontOfSize:16];
        _titleLabel.textColor = ZJColorFromRGB(0x181E28);
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

@end
