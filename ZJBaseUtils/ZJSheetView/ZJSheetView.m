//
//  ZJSheetView.m
//  ZJBaseUtils
//
//  Created by eafy on 2020/12/14.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import "ZJSheetView.h"
#import "UIView+ZJFrame.h"
#import "UIColor+ZJExt.h"
#import "ZJScreen.h"
#import "NSString+ZJExt.h"
#import "ZJUtilsDef.h"
#import "ZJLocalization.h"

@interface ZJSheetView ()

/// 遮罩视图
@property (nonatomic,strong) UIView *maskView;
/// 背景视图
@property (nonatomic,strong) UIView *bgView;
/// 选择框视图
@property (nonatomic,strong) UIView *topSheetView;
/// 标题
@property (nonatomic,strong) UILabel *titleLB;

@property (nonatomic,strong) NSMutableArray<ZJSheetAction *> *btnArray;
@property (nonatomic,strong) NSMutableArray<UIView *> *lineViewArray;

@end

@implementation ZJSheetView

+ (instancetype)sheetView {
    ZJSheetView *sheetView = [[ZJSheetView alloc] init];
    return sheetView;
}

+ (instancetype)sheetViewWithTitle:(NSString * _Nullable)title {
    ZJSheetView *sheetView = [self sheetView];
    sheetView.title = title;
    return sheetView;
}

#pragma mark -

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:[UIScreen mainScreen].bounds]) {
        super.backgroundColor = [UIColor clearColor];
        _cornerRadius = 8;
        _maskAlpha = 0.7;
        
        [self addSubview:self.maskView];
    }
    return self;
}

- (NSMutableArray<ZJSheetAction *> *)btnArray {
    if (!_btnArray) {
        _btnArray = [NSMutableArray array];
    }
    return _btnArray;
}

- (NSMutableArray<UIView *> *)lineViewArray {
    if (!_lineViewArray) {
        _lineViewArray = [NSMutableArray array];
    }
    return _lineViewArray;
}

- (UIView *)maskView
{
    if (!_maskView) {
        _maskView = [[UIView alloc] initWithFrame:self.bounds];
        _maskView.backgroundColor = ZJColorFromRgbWithAlpha(0x0, self.maskAlpha);
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickedTapMaskView)];
        [_maskView addGestureRecognizer:tap];
    }
    return _maskView;
}

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, ZJScreenHeight(), ZJScreenWidth(), 0)];
        _bgView.backgroundColor = [UIColor clearColor];
        [self.maskView addSubview:_bgView];
    }
    return _bgView;
}

- (UIView *)topSheetView {
    if (!_topSheetView) {
        _topSheetView = [[UIView alloc] initWithFrame:CGRectMake(16, 0, self.bgView.zj_width-32, 0)];
        _topSheetView.backgroundColor = [UIColor clearColor];
        _topSheetView.layer.cornerRadius = self.cornerRadius;
        _topSheetView.layer.masksToBounds = YES;
        [self.bgView addSubview:_topSheetView];
    }
    return _topSheetView;
}

- (UILabel *)titleLB {
    if (!_titleLB) {
        _titleLB = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.topSheetView.zj_width, 48)];
        _titleLB.backgroundColor = [UIColor whiteColor];
        _titleLB.textColor = ZJColorFromRGB(0x181E28);
        _titleLB.font = [UIFont boldSystemFontOfSize:16];
        _titleLB.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLB;
}

#pragma mark -

- (void)layoutSubviews
{
    [super layoutSubviews];
    ZJSheetAction *cancelBtn = nil;
    CGFloat bottom = _titleLB ? _titleLB.zj_bottom : 0;
    
    for (int i=0; i<self.btnArray.count; i++) {
        UIView *line = [self.lineViewArray objectAtIndex:i];
        line.zj_top = bottom;
        if ((i == 0 && _titleLB) || i > 0) {
            line.hidden = NO;
        }
        bottom = line.zj_bottom;

        ZJSheetAction *btn = [self.btnArray objectAtIndex:i];
        if (btn.style == ZJSheetActionStyleCancel) {
            if (cancelBtn) {
                [btn removeFromSuperview];
            }
            cancelBtn = btn;
        } else {
            btn.frame = CGRectMake(0, bottom, self.topSheetView.zj_width, btn.zj_height);
            bottom = btn.zj_bottom;
        }
    }
    self.topSheetView.zj_height = bottom;
    bottom += 8;
    
    if (cancelBtn) {
        cancelBtn.frame = CGRectMake(self.topSheetView.zj_left, bottom, self.topSheetView.zj_width, cancelBtn.zj_height);
        bottom = cancelBtn.zj_bottom;
        bottom += 8;
    }
    bottom += 8;
    
    self.bgView.zj_height = bottom;
    
    if (_topCustomView) {
        if (CGRectEqualToRect(_topCustomView.frame, CGRectZero)) {
            self.topCustomView.zj_top = ZJStatusBarHeight() + 20;
            self.topCustomView.zj_left = 20;
            self.topCustomView.zj_width = ZJScreenWidth() - 40;
            self.topCustomView.zj_height = ZJScreenHeight() - bottom - self.topCustomView.zj_top - 60;
        }
    }
}

- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    self.topSheetView.backgroundColor = backgroundColor;
}

- (void)setCornerRadius:(CGFloat)cornerRadius
{
    _cornerRadius = cornerRadius;
    self.topSheetView.layer.cornerRadius = cornerRadius;
    
    for (ZJSheetAction *btn in self.btnArray) {
        if (btn.style == ZJSheetActionStyleCancel) {
            btn.layer.cornerRadius = cornerRadius;
        }
    }
}

- (void)setMaskAlpha:(CGFloat)maskAlpha {
    _maskAlpha = maskAlpha;
    self.maskView.backgroundColor = ZJColorFromRgbWithAlpha(0x0, maskAlpha);
}

- (void)setTitle:(NSString *)title {
    _title = title;
    if (title) {
        self.titleLB.text = self.title;
        if (!self.titleLB.superview) {
            [self.topSheetView addSubview:self.titleLB];
        }
    } else if (_titleLB) {
        [self.titleLB removeFromSuperview];
        _titleLB = nil;
    }
}

- (void)setTitleColor:(UIColor *)titleColor {
    _titleColor = titleColor;
    self.titleLB.textColor = titleColor;
}

- (void)setTitleFont:(UIFont *)titleFont {
    _titleFont = titleFont;
    self.titleLB.font = titleFont;
}

- (void)setTopCustomView:(UIView *)topCustomView {
    if (_topCustomView) {
        [_topCustomView removeFromSuperview];
    }
    _topCustomView = topCustomView;
    [self.maskView addSubview:topCustomView];
}


#pragma mark -

- (void)addAction:(ZJSheetAction *)action {
    [self.btnArray addObject:action];
    [action addTarget:self action:@selector(clickedSheetAction:) forControlEvents:UIControlEventTouchUpInside];
    if (action.style == ZJSheetActionStyleCancel) {
        action.layer.cornerRadius = self.cornerRadius;
        action.layer.masksToBounds = true;
        [self.bgView addSubview:action];
    } else {
        [self.topSheetView addSubview:action];
    }
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.topSheetView.zj_width, 0.5)];
    lineView.hidden = YES;
    lineView.backgroundColor = ZJColorFromRGB(0xDCE0E8);
    [self.lineViewArray addObject:lineView];
    [self.topSheetView addSubview:lineView];
}

- (ZJSheetAction *)addCancelAction {
    ZJSheetAction *act = [ZJSheetAction actionCancellWithTitle:@"Cancel".localized handler:nil];
    [self addAction:act];
    return act;
}

- (void)clickedSheetAction:(ZJSheetAction *)action {
    if (action.handler) {
        action.handler(action);
    }
    [self dismiss];
}

/// 显示
- (void)show {
    [self layoutIfNeeded];
    self.alpha = 0;
    [ZJScreen.keyWindow addSubview:self];
    
    @weakify(self);
    [UIView animateWithDuration:0.3 animations:^{
        @strongify(self);
        self.alpha = 1;
        self.bgView.zj_top = ZJScreenHeight() - self.bgView.zj_height;
    } completion:^(BOOL finished) {
        
    }];
}

/// 移除
- (void)dismiss {
     @weakify(self);
     [UIView animateWithDuration:0.25 animations:^{
         @strongify(self);
         self.alpha = 0;
         self.bgView.zj_top = ZJScreenHeight();
     } completion:^(BOOL finished) {
         @strongify(self);
         [self.topCustomView removeFromSuperview];
         [self removeFromSuperview];
         [self.btnArray removeAllObjects];
         [self.lineViewArray removeAllObjects];
     }];
}

- (void)clickedTapMaskView {
    if (self.isTapMaskHide) {
        [self dismiss];
    }
}

@end
