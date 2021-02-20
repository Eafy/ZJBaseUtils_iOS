//
//  ZJSegmentedControl.m
//  ZJUXKit
//
//  Created by eafy on 2020/8/13.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import "ZJSegmentedControl.h"
#import "UIColor+ZJExt.h"
#import "UIImage+ZJExt.h"
#import "UIView+ZJFrame.h"
#import "UIButton+ZJExt.h"
#import "UIView+ZJGradient.h"

#define kZJSegmentedControlItemIndexStart 1024

@interface ZJSegmentedControl () <UIScrollViewDelegate>

@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIView *maskRightView;

@property (nonatomic,assign) ZJSegmentedControlStyle style;
@property (nonatomic,strong) NSMutableArray *itemsArray;

@property (nonatomic,strong) UIColor *selColor;
@property (nonatomic,strong) UIColor *selBgColor;
@property (nonatomic,strong) UIFont *selFont;
@property (nonatomic,strong) UIColor *norColor;
@property (nonatomic,strong) UIColor *norBgColor;
@property (nonatomic,strong) UIFont *norFont;

@end

@implementation ZJSegmentedControl

- (void)defaultInitData
{
    self.backgroundColor = [UIColor whiteColor];
    
    _norColor = ZJColorFromRGB(0x8690A9);
    _norFont = [UIFont systemFontOfSize:14];
    _selColor = ZJColorFromRGB(0x181E28);
    _selFont = [UIFont boldSystemFontOfSize:16];
    _selBgColor = [UIColor whiteColor];
    _selectLineBottomMargin = 4;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:CGRectZero]) {
        [self defaultInitData];
    }
    
    return self;
}

- (instancetype)initWithItems:(nullable NSArray *)items
{
    if (self = [super initWithFrame:CGRectZero]) {
        [self defaultInitData];
        
        for (NSString *title in items) {
            [self insertSegmentWithTitle:title norImg:nil selImg:nil atIndex:0xFFFFFFFF animated:NO];
        }
    }
    
    return self;
}

- (instancetype)initWithStyle:(ZJSegmentedControlStyle)style titleItems:(NSArray *)items
{
    if (self = [super initWithFrame:CGRectZero]) {
        [self defaultInitData];
        self.style = style;
        
        for (NSString *title in items) {
            [self insertSegmentWithTitle:title norImg:nil selImg:nil atIndex:0xFFFFFFFF animated:YES];
        }
    }
    
    return self;
}

- (instancetype)initWithTitleItems:(NSArray *)items norImgItems:(nullable NSArray *)norImgItems selImgItems:(nullable NSArray *)selImgItems {
    if (self = [super initWithFrame:CGRectZero]) {
        [self defaultInitData];
        
        for (int i=0; i<items.count; i++) {
            NSString *title = [items objectAtIndex:i];
            UIImage *norImg = nil;
            UIImage *selImg = nil;
            if (norImgItems && i < norImgItems.count) {
                norImg = [UIImage imageNamed:[norImgItems objectAtIndex:i]];
            }
            if (selImgItems && i < selImgItems.count) {
                selImg = [UIImage imageNamed:[selImgItems objectAtIndex:i]];
            }

            [self insertSegmentWithTitle:title norImg:norImg selImg:selImg atIndex:0xFFFFFFFF animated:YES];
        }
    }
    
    return self;
}

- (instancetype)initWithStyle:(ZJSegmentedControlStyle)style titleItems:(NSArray *)items norImgItems:(nullable NSArray *)norImgItems selImgItems:(nullable NSArray *)selImgItems {
    if (self = [super initWithFrame:CGRectZero]) {
        [self defaultInitData];
        self.style = style;
        
        for (int i=0; i<items.count; i++) {
            NSString *title = [items objectAtIndex:i];
            UIImage *norImg = nil;
            UIImage *selImg = nil;
            if (norImgItems && i < norImgItems.count) {
                norImg = [UIImage imageNamed:[norImgItems objectAtIndex:i]];
            }
            if (selImgItems && i < selImgItems.count) {
                selImg = [UIImage imageNamed:[selImgItems objectAtIndex:i]];
            }

            [self insertSegmentWithTitle:title norImg:norImg selImg:selImg atIndex:0xFFFFFFFF animated:YES];
        }
    }
    
    return self;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.pagingEnabled = YES;
        _scrollView.scrollEnabled = YES;
        _scrollView.bounces = NO;
//        _scrollView.delegate = self;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.backgroundColor = [UIColor clearColor];
        if (@available(iOS 11.0, *)) {
            _scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    
    return _scrollView;
}

- (UIView *)selectLineView
{
    if (!_selectLineView) {
        _selectLineView = [[UILabel alloc] initWithFrame:CGRectMake(-64, 0, 16.0f, 4.0)];
        _selectLineView.backgroundColor = ZJColorFromRGB(0x3D7DFF);
        _selectLineView.layer.cornerRadius = _selectLineView.zj_height/2;
        _selectLineView.layer.masksToBounds = YES;
        
        [self addSubview:_selectLineView];
    }
    
    return _selectLineView;
}

- (UIView *)maskRightView {
    if (!_maskRightView) {
        _maskRightView = [[UIView alloc] init];
        _maskRightView.userInteractionEnabled = NO;
        [self addSubview:_maskRightView];
    }
    return _maskRightView;
}

- (NSMutableArray *)itemsArray {
    if (!_itemsArray) {
        _itemsArray = [NSMutableArray array];
    }
    return _itemsArray;
}

- (void)insertSegmentWithTitle:(nullable NSString *)title norImg:(nullable UIImage *)norImg selImg:(nullable UIImage *)selImg atIndex:(NSUInteger)segment animated:(BOOL)animated {
    UIButton *btn = [[UIButton alloc] init];
    btn.backgroundColor = [UIColor clearColor];
    [btn setTitle:title forState:UIControlStateNormal];
    if (norImg) [btn setImage:norImg forState:UIControlStateNormal];
    if (selImg) [btn setImage:selImg forState:UIControlStateSelected];
    [btn addTarget:self action:@selector(didZJSegmentedIndexChange:) forControlEvents:UIControlEventTouchUpInside];
    [self updateItemsData:btn];
    if (self.visibleCount > 0) {
        [self.scrollView addSubview:btn];
    } else {
        [self addSubview:btn];
    }
    
    if (segment < self.itemsArray.count) {
        [self.itemsArray insertObject:btn atIndex:segment];
    } else {
        [self.itemsArray addObject:btn];
    }
    [self updateItemsIndex];
}

- (void)removeSegmentAtIndex:(NSUInteger)segment animated:(BOOL)animated {
    if (segment < self.itemsArray.count) {
        UIButton *btn = [self.itemsArray objectAtIndex:segment];
        [btn removeFromSuperview];
        
        [self.itemsArray removeObjectAtIndex:segment];
        [self updateItemsIndex];
    }
}

- (void)removeAllSegments {
    for (UIButton *btn in self.itemsArray) {
        [btn removeFromSuperview];
    }
    [self.itemsArray removeAllObjects];
    
    [self updateItemsIndex];
}

- (void)updateItemsData:(UIButton *)btn
{
    [btn setTitleColor:self.norColor forState:UIControlStateNormal];
    [btn setTitleColor:self.selColor ? self.selColor : self.norColor forState:UIControlStateSelected];
    if (_norBgColor) {
        [btn setBackgroundImage:[UIImage zj_imageWithColor:self.norBgColor] forState:UIControlStateNormal];
    }
    if (_selBgColor) {
        [btn setBackgroundImage:[UIImage zj_imageWithColor:self.selBgColor] forState:UIControlStateSelected];
    } else {
        [btn setBackgroundImage:[UIImage zj_imageWithColor:self.norBgColor ? self.norBgColor : self.backgroundColor] forState:UIControlStateSelected];
    }
    btn.titleLabel.font = self.norFont;
}

- (void)updateItemsIndex
{
    for (int i=0; i<self.itemsArray.count; i++) {
        UIButton *btn = [self.itemsArray objectAtIndex:i];
        btn.tag = kZJSegmentedControlItemIndexStart + i;
    }
    
    if (self.selectedIndex >= self.itemsArray.count) {
        self.selectedIndex = self.itemsArray.count - 1;
    }
}

#pragma mark -

- (void)layoutSubviews
{
    [super layoutSubviews];
    if (!self.itemsArray.count) return;
    
    CGFloat width = self.zj_width/self.itemsArray.count;
    if (self.visibleCount > 0) {
        self.scrollView.frame = self.bounds;
        width = self.zj_width/self.visibleCount;
        self.scrollView.contentSize = CGSizeMake(width * self.itemsArray.count, self.zj_height);
    }
    
    for (int i=0; i<self.itemsArray.count; i++) {
        UIButton *btn = [self.itemsArray objectAtIndex:i];
        if (self.style == ZJSegmentedControlStyleGroup) {
            btn.zj_top = 1;
            btn.zj_size = CGSizeMake(width-2, self.zj_height-2);
        } else {
            btn.zj_top = 0;
            btn.zj_size = CGSizeMake(width, self.zj_height);
        }
        btn.zj_centerX = width * (i + 0.5);
        if ([btn imageForState:UIControlStateNormal]) {
            [btn zj_layoutWithEdgeInsetsStyle:ZJButtonEdgeInsetsStyleRight imageTitleSpace:8];
        }
    }
    
    self.selectLineView.zj_bottom = self.zj_height - self.selectLineBottomMargin;
    if (self.selectLineView.zj_left <= 0) {
        [self changeSelectLineView];
    }
    
    if (self.isShowRightMask) {
        self.maskRightView.zj_width = width/4.0 * 3;
        self.maskRightView.zj_right = self.zj_width;
        self.maskRightView.zj_height = self.zj_height;
        [self.maskRightView zj_gradientWithColors:@[ZJColorFromRrgWithAlpha(0xFFFFFF, 0.35), ZJColorFromRrgWithAlpha(0xFFFFFF, 1)] percents:@[@0, @1] opacity:1 type:ZJGradientTypeFromLeftToRight];
    }
}

- (void)setSelectedColor:(UIColor *)color bgColor:(UIColor *)bgColor font:(UIFont *)font {
    self.selColor = color;
    self.selBgColor = bgColor;
    self.selFont = font;
    
    for (UIButton *btn in self.itemsArray) {
        [self updateItemsData:btn];
    }
}

- (void)setNormalColor:(UIColor *)color bgColor:(UIColor *)bgColor font:(UIFont *)font {
    self.norColor = color;
    self.norBgColor = bgColor;
    self.norFont = font;
    
    for (UIButton *btn in self.itemsArray) {
        [self updateItemsData:btn];
    }
}

- (void)setStyle:(ZJSegmentedControlStyle)style
{
    _style = style;
    if (_maskRightView) {
        [_maskRightView removeFromSuperview];
        _maskRightView = nil;
    }
    
    if (style == ZJSegmentedControlStylePlain) {
        self.backgroundColor = [UIColor whiteColor];
        self.selectCornerRadius = 0;
        self.layer.cornerRadius = 0;
        self.layer.masksToBounds = NO;
    } else {
        self.backgroundColor = ZJColorFromRGB(0xDCE0E8);
        self.selectCornerRadius = 8;
        self.layer.cornerRadius = 8;
        self.layer.masksToBounds = YES;
    }
    
    for (UIButton *btn in self.itemsArray) {
        [self updateItemsData:btn];
    }
    
    self.selectedIndex = self.selectedIndex;
}


- (void)setHideSelectLine:(BOOL)hideSelectLine {
    _hideSelectLine = hideSelectLine;
    self.selectLineView.hidden = hideSelectLine;
}

- (void)setVisibleCount:(NSUInteger)visibleCount {
    if (self.style != ZJSegmentedControlStylePlain) {
        return;
    }
    _visibleCount = visibleCount;
    _isShowRightMask = visibleCount > 0;
    
    [self.selectLineView removeFromSuperview];
    if (visibleCount > 0) {
        if (!_scrollView.superview) {
            [self addSubview:self.scrollView];
        }
        for (UIButton *btn in self.itemsArray) {
            [btn removeFromSuperview];
            [self.scrollView addSubview:btn];
        }
        [self.scrollView addSubview:self.selectLineView];
    } else {
        if (_maskRightView) {
            [_maskRightView removeFromSuperview];
            _maskRightView = nil;
        }
        if (_scrollView) {
            [self.scrollView removeFromSuperview];
            _scrollView = nil;
        }
        for (UIButton *btn in self.itemsArray) {
            [btn removeFromSuperview];
            [self addSubview:btn];
        }
        [self addSubview:self.selectLineView];
    }
    [self layoutIfNeeded];
}

#pragma mark -

- (void)changeSelectLineView
{
    if (!self.hideSelectLine) {
        self.selectLineView.hidden = self.itemsArray.count == 0;
    }
    if (self.selectLineView.hidden) return;
    
    __block CGFloat xOffset = -self.selectLineView.zj_width;
    if (self.selectedIndex < self.itemsArray.count) {
        UIButton *btn = [self.itemsArray objectAtIndex:self.selectedIndex];
        xOffset = btn.zj_centerX;
    }
     
    [UIView animateWithDuration:0.15f animations:^{
        self.selectLineView.zj_centerX = xOffset;
    }];
}

- (void)didZJSegmentedIndexChange:(UIButton *)btn
{
    if (btn.selected && self.selectedIndex == (btn.tag - kZJSegmentedControlItemIndexStart)) return;
    btn.selected = YES;
    btn.titleLabel.font = self.selFont;
    if (self.selectCornerRadius > 0) {
        btn.layer.cornerRadius = self.selectCornerRadius;
        btn.layer.masksToBounds = YES;
    }
    
    NSUInteger selectedIndex = btn.tag - kZJSegmentedControlItemIndexStart;
    if (self.selectedIndex != selectedIndex && self.selectedIndex < self.itemsArray.count) {
        UIButton *btnT = [self.itemsArray objectAtIndex:self.selectedIndex];
        btnT.selected = NO;
        btnT.titleLabel.font = self.norFont;
        btnT.layer.cornerRadius = 0;
    }
    _selectedIndex = selectedIndex;
    
    [self changeSelectLineView];
    
    if (_delegate && [self.delegate respondsToSelector:@selector(segmentedControl:didSelectIndex:)]) {
        [self.delegate segmentedControl:self didSelectIndex:self.selectedIndex];
    }
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex
{
    if (selectedIndex < self.itemsArray.count) {
        UIButton *btn = [self.itemsArray objectAtIndex:selectedIndex];
        [btn sendActionsForControlEvents:UIControlEventTouchUpInside];
    }
}

@end
