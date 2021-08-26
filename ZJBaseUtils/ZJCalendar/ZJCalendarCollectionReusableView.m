//
//  ZJCalendarCollectionReusableView.m
//  ZJBaseUtils
//
//  Created by eafy on 2020/9/25.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import <ZJBaseUtils/ZJCalendarCollectionReusableView.h>
#import <ZJBaseUtils/UIColor+ZJExt.h>

@implementation ZJCalendarCollectionReusableView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.titleLabel];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.titleLabel.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont boldSystemFontOfSize:16];
        _titleLabel.textColor = ZJColorFromRGB(0x181E28);
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

@end
