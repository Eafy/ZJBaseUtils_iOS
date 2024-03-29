//
//  ZJStepBar.m
//  ZJBaseUtils
//
//  Created by eafy on 2020/8/3.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import <ZJBaseUtils/ZJStepBar.h>
#import <ZJBaseUtils/UIView+ZJFrame.h>
#import <ZJBaseUtils/UIColor+ZJExt.h>
#import <ZJBaseUtils/NSString+ZJExt.h>
#import <ZJBaseUtils/ZJBundleRes.h>
#import <ZJBaseUtils/UIView+ZJExt.h>

#define kZJStepsView_ProgressLineTagStart 10240
#define kZJStepsView_CircleTagStart 11240
#define kZJStepsView_TitleLBTagStart 12240
#define kZJStepsView_CircleAnmiTagStart 13240

@interface ZJStepBar ()

@property (nonatomic, strong) NSMutableArray *titleArr;

@property (nonatomic, strong) UIView *progressView;

@property (nonatomic, assign) BOOL isVertical;

@end

@implementation ZJStepBar

+ (instancetype)stepBarWithTitleArray:(NSArray *)titleArr {
    ZJStepBar *stepbar = [[ZJStepBar alloc] init];
    
    return stepbar;
}

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
        _circleAnimColor = ZJColorFromRgbWithAlpha(0x3D7DFF, 0.1);
        _progressNorColor = ZJColorFromRGB(0xBCC4D4);
        _progressSelColor = ZJColorFromRGB(0x3D7DFF);
        _progressLineHeight = 2.0;
        _titleTopSpace = 30.0;
        _circleWidth = 8.f;
        
        [self addSubview:self.progressView];
        [self addSubviews];
        
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
    if (self.titleArr.count <= 1 || self.progressView.zj_width == 0) return;
    
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
                imgView.image = self.selectImgName ? [UIImage imageNamed:self.selectImgName] : [ZJBundleRes imageNamed:@"icon_stepBar_selected"];
            }
            imgView.backgroundColor = self.circleSelColor;
            
            titleLabel.textColor = self.titleSelColor;
        } else if (i == self.index) {
            imgViewSize = CGSizeMake(self.circleWidth * 2, self.circleWidth * 2);
            imgView.backgroundColor = self.circleSelColor;
            
            titleLabel.textColor = self.titleSelColor;
            if (self.isVertical) {
                progressLine.frame = CGRectMake(0, 0, self.progressView.zj_width, perspace * self.index);
            } else {
                progressLine.frame = CGRectMake(0, 0, perspace * self.index, self.progressView.zj_height);
            }
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
    [self updateLayout];
}

- (void)setStyle:(ZJStepBarStyle)style {
    _style = style;
    [self updateLayout];
}

- (void)setCircleWidth:(CGFloat)circleWidth {
    _circleWidth = circleWidth;
    [self updateLayout];
}

- (void)setSelectImgName:(NSString *)selectImgName {
    _selectImgName = selectImgName;
    [self updateLayout];
}

- (void)setCircleNorColor:(UIColor *)circleNorColor {
    _circleNorColor = circleNorColor;
    [self updateLayout];
}

- (void)setCircleSelColor:(UIColor *)circleSelColor {
    _circleSelColor = circleSelColor;
    [self updateLayout];
}

- (void)setCircleAnimColor:(UIColor *)circleAnimColor {
    _circleAnimColor = circleAnimColor;
    [self updateLayout];
}

- (void)setProgressLineHeight:(CGFloat)progressLineHeight {
    _progressLineHeight = progressLineHeight;
    [self updateLayout];
}

- (void)setProgressNorColor:(UIColor *)progressNorColor {
    _progressNorColor = progressNorColor;
    [self updateLayout];
}

- (void)setProgressSelColor:(UIColor *)progressSelColor {
    _progressSelColor = progressSelColor;
    [self updateLayout];
}

- (void)setTitleNorColor:(UIColor *)titleNorColor {
    _titleNorColor = titleNorColor;
    [self updateLayout];
}

- (void)setTitleSelColor:(UIColor *)titleSelColor {
    _titleSelColor = titleSelColor;
    [self updateLayout];
}

- (void)setTitleFont:(UIFont *)titleFont {
    _titleFont = titleFont;
    for (NSInteger i = 0; i < self.titleArr.count; i++) {
        UILabel *titleLabel = [self viewWithTag:kZJStepsView_TitleLBTagStart + i];
        titleLabel.font = titleFont;
        [titleLabel sizeToFit];
    }
    
    [self updateLayout];
}

- (void)setTitleTopSpace:(CGFloat)titleTopSpace {
    _titleTopSpace = titleTopSpace;
    [self updateLayout];
}

#pragma mark -

- (void)setupTitleArray:(NSArray *)titleArr {
    if (_titleArr) {
        self.titleArr = [NSMutableArray arrayWithArray:titleArr];
        [self addSubviews];
    }
}

- (void)selectIndex:(NSInteger)index withTitle:(NSString *)title {
    if (index >= self.titleArr.count) return;
    _index = index;
    
    [self updateIndex:index title:title];
}

- (void)updateIndex:(NSInteger)index title:(NSString *)title {
    if (index >= self.titleArr.count) return;
    
    UILabel *titleLabel = [self viewWithTag:kZJStepsView_TitleLBTagStart + index];
    titleLabel.text = title;
    titleLabel.zj_size = [titleLabel.text zj_sizeWithFont:titleLabel.font maxSize:CGSizeZero];
    
    [self updateLayout];
}

@end
