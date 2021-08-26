//
//  ZJCalendarCollectionViewCell.m
//  ZJBaseUtils
//
//  Created by eafy on 2020/9/23.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import <ZJBaseUtils/ZJCalendarCollectionViewCell.h>
#import <ZJBaseUtils/UIColor+ZJExt.h>
#import <ZJBaseUtils/ZJLocalization.h>

@interface ZJCalendarCollectionViewCell()

@property (nonatomic, strong) UIView *selectView;
@property (nonatomic, strong) UIView *selectBgView;
@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, assign) ZJCalendarSelectedType type;
@property (nonatomic, assign) BOOL expiredEnable;
@property (nonatomic, assign) BOOL hasRangSelected;
@property (nonatomic, strong) ZJCalendarDay *day;

@end

@implementation ZJCalendarCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.selectBgView];
        [self addSubview:self.selectView];
        [self addSubview:self.titleLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.selectBgView.frame = CGRectMake(0, 4, self.bounds.size.width, self.bounds.size.height-4*2);
    self.selectView.frame = CGRectMake(6, 4, self.bounds.size.width-6*2, self.bounds.size.height-4*2);
    self.titleLabel.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    
    if (self.type == ZJCalendarSelectedTypeRang) {
        if (self.day.isSelected && self.hasRangSelected) {
            if (self.day.isBeginSelected) {
                self.selectBgView.frame = CGRectMake(20, 4, self.bounds.size.width-20, self.bounds.size.height-4*2);
            }
            if (self.day.isEndSelected) {
                self.selectBgView.frame = CGRectMake(0, 4, self.bounds.size.width-20, self.bounds.size.height-4*2);
            }
        }
    }

}

- (void)setupData:(ZJCalendarDay *)day type:(ZJCalendarSelectedType)type hasSelected:(BOOL)hasRangSelected expiredEnable:(BOOL)enable {
    
    self.type = type;
    self.hasRangSelected = hasRangSelected;
    self.expiredEnable = enable;
    self.day = day;
    
    if (!day.isSelected) {
        self.titleLabel.textColor = (day.diffTaday > 0) ? ZJColorFromRGB(0x181E28) : ZJColorFromRGB(0xBCC4D4);
    }
    
    if (day.diffTaday == 0 && day.day > 0) {
        self.titleLabel.textColor = day.isSelected ? UIColor.whiteColor:ZJColorFromRGB(0x3D7DFF);
        self.titleLabel.text = @"Today".localized;
    }
}

- (void)setDay:(ZJCalendarDay *)day {
    _day = day;
    self.titleLabel.text = @"";
    self.selectView.hidden = YES;
    self.selectBgView.hidden = YES;
    
    if (day.day <= 0) {
        return;
    }
    self.selectView.hidden = !day.isSelected;
    self.titleLabel.textColor = day.isSelected ? UIColor.whiteColor : ZJColorFromRGB(0x181E28);
    self.titleLabel.text = [NSString stringWithFormat:@"%lu",(unsigned long)day.day];
    
    if (self.type == ZJCalendarSelectedTypeRang) {
        if (self.day.isSelected && self.hasRangSelected) {
            self.selectBgView.hidden = NO;
            self.selectView.hidden = !(self.day.isBeginSelected || self.day.isEndSelected);
            self.titleLabel.textColor = !(self.day.isBeginSelected || self.day.isEndSelected) ? ZJColorFromRGB(0x181E28) : UIColor.whiteColor;
            [self setNeedsLayout];
        }
    }
}

// MARK:- GET
- (UIView *)selectView {
    if (!_selectView) {
        _selectView = [UIView new];
        _selectView.layer.cornerRadius = 8;
        _selectView.layer.masksToBounds = YES;
        _selectView.backgroundColor = ZJColorFromRGB(0x3D7DFF);
    }
    return _selectView;
}


- (UIView *)selectBgView {
    if (!_selectBgView) {
        _selectBgView = [UIView new];
        _selectBgView.backgroundColor = ZJColorFromRGB(0xD6E4FF);
    }
    return _selectBgView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textColor = ZJColorFromRGB(0x181E28);
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

@end
