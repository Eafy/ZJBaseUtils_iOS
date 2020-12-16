//
//  ZJStepsView.m
//  ZJBaseUtils
//
//  Created by eafy on 2020/8/3.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import "ZJStepsView.h"
#import "UIView+ZJFrame.h"
#import "UIColor+ZJExt.h"
#import "NSString+ZJExt.h"
#import "ZJBaseUtils.h"
#import "UIView+ZJExt.h"

#define kZJStepsView_ProgressLineTagStart 10240
#define kZJStepsView_CircleTagStart 11240
#define kZJStepsView_TitleLBTagStart 12240
#define kZJStepsView_CircleAnmiTagStart 13240

@interface ZJStepsView ()

@property (nonatomic, strong) NSMutableArray *titleArr;

@property (nonatomic, strong) UIView *progressView;

@property (nonatomic, assign) CGFloat bigCircleWidth;

@property (nonatomic, assign) CGRect rect;

@property (nonatomic, assign) BOOL isVertical;

@property (nonatomic,strong) NSMutableArray *circleArray;

@end

@implementation ZJStepsView

- (instancetype)initWithTitleArray:(NSArray *)titleArr {
    if (self = [super init]) {
        self.titleArr = [NSMutableArray arrayWithArray:titleArr];
        self.isVertical = NO;
        
        _index = -1;
        _titleNorColor = ZJColorFromRGB(0xBCC4D4);
        _titleSelColor = ZJColorFromRGB(0x8690A8);
        _titleFont = [UIFont systemFontOfSize:14.f];
        _circleNorColor = ZJColorFromRGB(0x8690A8);
        _circleSelColor = ZJColorFromRGB(0x3D7DFF);
        _circleAnimColor = ZJColorFromRrgWithAlpha(0x3D7DFF, 0.1);
        _progressNorColor = ZJColorFromRGB(0xBCC4D4);
        _progressSelColor = ZJColorFromRGB(0x3D7DFF);
        _progressLineHeight = 2.0;
        _titleTopSpace = 30.0;
        
        [self addSubview:self.progressView];
        [self addSubviews];
        
        self.circleWidth = 8.f;
    }
    return self;
}

- (instancetype)initHorizontaWithFrame:(CGRect)frame titleArray:(NSArray *)titleArray {
    if (self = [self initWithTitleArray:titleArray]) {
        self.frame = frame;
    }
    return self;
}

- (instancetype)initVerticalWithFrame:(CGRect)frame titleArray:(NSArray *)titleArray {
    if (self = [self initWithTitleArray:titleArray]) {
        self.frame = frame;
        self.isVertical = YES;
    }
    return self;
}

- (UIView *)progressView {
    if (!_progressView) {
        _progressView = [[UIView alloc] initWithFrame:CGRectZero];
        _progressView.backgroundColor = self.progressNorColor;
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
        view.tag = kZJStepsView_ProgressLineTagStart;
        view.backgroundColor = self.progressSelColor;
        [_progressView addSubview:view];
        
        UIView *aniView = [[UIView alloc] initWithFrame:CGRectZero];
        aniView.tag = kZJStepsView_CircleAnmiTagStart;
        aniView.backgroundColor = self.circleAnimColor;
        [self.progressView addSubview:aniView];
    }
    return _progressView;
}

- (void)addSubviews
{
    for (NSInteger i = 0; i < self.titleArr.count; i++) {
        UIImageView *view = [[UIImageView alloc] init];
        view.contentMode = UIViewContentModeCenter;
        view.tag = kZJStepsView_CircleTagStart + i;
        [self.progressView addSubview:view];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textColor = self.titleNorColor;
        titleLabel.textAlignment = self.isVertical ? NSTextAlignmentLeft : NSTextAlignmentCenter;
        titleLabel.font = self.titleFont;
        titleLabel.tag = kZJStepsView_TitleLBTagStart + i;
        titleLabel.text = self.titleArr[i];
        [titleLabel sizeToFit];
        titleLabel.zj_size = [titleLabel.text zj_sizeWithFont:titleLabel.font maxSize:CGSizeZero];
        [self addSubview:titleLabel];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (self.isVertical) {
        self.progressView.frame = CGRectMake(self.circleWidth * 1.5, self.circleWidth * 1.5, self.progressLineHeight, self.zj_height-self.circleWidth*3);
    } else {
        self.progressView.frame = CGRectMake(self.circleWidth * 1.5, self.circleWidth * 1.5, self.zj_width-self.circleWidth*3, self.progressLineHeight);
    }
    [self updateLayout];
}

- (void)updateLayout
{
    CGFloat width = self.isVertical ? self.progressView.zj_height : self.progressView.zj_width;
    CGFloat center = self.isVertical ? self.progressView.zj_width/2 : self.progressView.zj_height/2;
    CGFloat perspace = width / (self.titleArr.count - 1);
    
    UIView *progressLine = [self.progressView viewWithTag:kZJStepsView_ProgressLineTagStart];
    progressLine.frame = CGRectZero;
    
    for (NSInteger i = 0; i < self.titleArr.count; i++) {
        UIImageView *imgView = [self.progressView viewWithTag:i + kZJStepsView_CircleTagStart];
        UILabel *titleLabel = [self viewWithTag:kZJStepsView_TitleLBTagStart + i];
        UIView *anmigView = [self.progressView viewWithTag:kZJStepsView_CircleAnmiTagStart];
        
        CGSize imgViewSize = CGSizeMake(self.circleWidth, self.circleWidth);
        imgView.image = nil;
        
        if (i < self.index) {
            if (self.style == ZJStepBarStyleImage) {
                imgViewSize = CGSizeMake(self.circleWidth * 2, self.circleWidth * 2);
                imgView.image = self.selectImgName ? [UIImage imageNamed:self.selectImgName] : [ZJBaseUtils imageNamed:@"icon_stepBar_selected"];
            }
            imgView.backgroundColor = self.circleSelColor;
            
            titleLabel.textColor = self.titleSelColor;
        } else if (i == self.index) {
            imgViewSize = CGSizeMake(self.circleWidth * 2, self.circleWidth * 2);
            imgView.backgroundColor = self.circleSelColor;
            
            titleLabel.textColor = self.titleSelColor;
            progressLine.frame = CGRectMake(0, 0, perspace * self.index, self.progressView.zj_height);
        } else {
            imgView.backgroundColor = self.circleNorColor;
            titleLabel.textColor = self.titleNorColor;
        }
        
        imgView.zj_size = imgViewSize;
        imgView.zj_centerXY = self.isVertical ? CGPointMake(center, i * perspace) : CGPointMake(i * perspace, center);
        [imgView zj_cornerWithRadius:imgView.zj_height];
        if (i == self.index) {
            anmigView.zj_size = CGSizeMake(self.circleWidth * 3, self.circleWidth * 3);
            anmigView.zj_centerXY = imgView.zj_centerXY;
            [anmigView zj_cornerWithRadius:anmigView.zj_height];
        }
        
        if (self.isVertical) {
            titleLabel.zj_left = self.progressView.zj_right + self.titleTopSpace;
            titleLabel.zj_centerY = perspace * i + self.progressView.zj_top;
        } else {
            titleLabel.zj_top = self.progressView.zj_bottom + self.titleTopSpace;
            titleLabel.zj_centerX = perspace * i + self.progressView.zj_left;
        }
    }
}

#pragma mark -

- (void)setIndex:(NSInteger)index {
    if (index >= self.titleArr.count) return;
        
    _index = index;
    [self layoutIfNeeded];
}

- (void)setStyle:(ZJStepBarStyle)style {
    _style = style;
    [self layoutIfNeeded];
}

@end
