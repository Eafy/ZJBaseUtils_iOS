//
//  ZJPickerView.m
//  ZJBaseUtils
//
//  Created by eafy on 2020/11/23.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import "ZJPickerView.h"
#import "UIColor+ZJExt.h"
#import "ZJScreen.h"
#import "UIView+ZJFrame.h"
#import "ZJUtilsDef.h"
#import "UIView+ZJExt.h"
#import "NSString+ZJExt.h"

@interface ZJPickerView () <UIPickerViewDataSource, UIPickerViewDelegate>

/// 背景视图
@property (nonatomic,strong) UIView *backView;
/// 遮罩视图
@property (nonatomic,strong) UIView *maskView;

@property (nonatomic,strong) NSMutableArray<UIPickerView *> *pickerViewArray;

@property (nonatomic,assign) CGRect pickerFrame;

/// 标题标签
@property (nonatomic,strong) UILabel *titleLB;
/// 确认按钮
@property (nonatomic,strong) UIButton *okBtn;
/// 取消按钮
@property (nonatomic,strong) UIButton *cancelBtn;

@property (nonatomic,assign) BOOL isRowLineSet;

@end

@implementation ZJPickerView

+ (instancetype)initWithFrame:(CGRect)frame itemsArray:(NSArray<ZJPickerItem *> *)itemsArray
{
    ZJPickerView *pickerView = [[ZJPickerView alloc] initWithFrame:frame];
    pickerView.itemsArray = itemsArray;
    return pickerView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:[UIScreen mainScreen].bounds]) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self setPickerFrame:frame];
        [self addSubview:self.maskView];
        [self addSubview:self.backView];
        [self.backView addSubview:self.titleLB];
        [self.backView addSubview:self.okBtn];
        [self.backView addSubview:self.cancelBtn];
    }
    
    return self;
}

- (void)setFrame:(CGRect)frame
{
    if (CGRectIsEmpty(self.frame) || self.zj_left < 0) {
        super.frame = [UIScreen mainScreen].bounds;
        [self deafaultData];
    }
    [self setPickerFrame:frame];
}

- (void)deafaultData
{
    _maskColor = ZJColorFromHex(@"#181E28B2");
    _rowLineColor = ZJColorFromHex(@"#DCE0E8");
    _btnOffset = 15;
    _topViewHeight = 56;
    _rowTitleColor = [UIColor blackColor];
    _rowTitleFont = [UIFont systemFontOfSize:18];
    _rowBackgroundColor = [UIColor clearColor];
    _rowLineHeight = 0.5;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.rowLineColor || !self.rowLineHeight) {
        for (UIPickerView *pickerView in self.pickerViewArray) {
            NSArray<UIView *> *views = pickerView.subviews;
            if (views.count >= 3 && !self.isRowLineSet) {
                self.isRowLineSet = YES;
                if (self.rowLineColor) {
                    views[1].backgroundColor = self.rowLineColor;
                    views[2].backgroundColor = self.rowLineColor;
                }
                if (!!self.rowLineHeight) {
                    views[1].zj_height = self.rowLineHeight;
                    views[2].zj_height = self.rowLineHeight;
                }
            }
        }
    }
}

- (NSMutableArray<UIPickerView *> *)pickerViewArray
{
    if (!_pickerViewArray) {
        _pickerViewArray = [NSMutableArray array];
    }
    return _pickerViewArray;
}

- (UILabel *)titleLB
{
    if (!_titleLB) {
        _titleLB = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ZJScreenWidth() - (self.okBtn.zj_width + self.btnOffset) * 2, self.okBtn.zj_height)];
        _titleLB.backgroundColor = [UIColor clearColor];
        _titleLB.textColor = ZJColorFromHex(@"#181E28");
        _titleLB.font = [UIFont boldSystemFontOfSize:16];
        _titleLB.textAlignment = NSTextAlignmentCenter;
    }
    
    return _titleLB;
}

- (UIButton *)okBtn
{
    if (!_okBtn) {
        _okBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.topViewHeight, self.topViewHeight)];
        _okBtn.backgroundColor = [UIColor clearColor];
        [_okBtn setTitle:NSLocalizedString(@"OK", nil) forState:UIControlStateNormal];
        [_okBtn setTitleColor:ZJColorFromHex(@"#3D7DFF") forState:UIControlStateNormal];
        _okBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        _okBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [_okBtn addTarget:self action:@selector(clickedOKAction) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _okBtn;
}

- (UIButton *)cancelBtn
{
    if (!_cancelBtn) {
        _cancelBtn = [[UIButton alloc] initWithFrame:self.okBtn.bounds];
        _cancelBtn.backgroundColor = [UIColor clearColor];
        [_cancelBtn setTitle:NSLocalizedString(@"Cancel", nil) forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:ZJColorFromHex(@"#3D7DFF") forState:UIControlStateNormal];
        _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        _cancelBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_cancelBtn addTarget:self action:@selector(clickedCancelAction) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _cancelBtn;
}

- (UIView *)backView
{
    if (!_backView) {
        _backView = [[UIView alloc] initWithFrame:CGRectMake(0, self.zj_height, self.bounds.size.width, 0)];
        _backView.backgroundColor = [UIColor whiteColor];
    }
    
    return _backView;
}

- (UIView *)maskView
{
    if (!_maskView) {
        _maskView = [[UIView alloc] initWithFrame:self.bounds];
        _maskView.backgroundColor = [UIColor clearColor];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickedCancelAction)];
        [_maskView addGestureRecognizer:tap];
    }
    return _maskView;
}

- (void)setPickerFrame:(CGRect)pickerFrame
{
    _pickerFrame = pickerFrame;
    self.backView.zj_height = pickerFrame.size.height;
    
    self.titleLB.zj_centerX = self.backView.zj_centerX;
    self.okBtn.zj_right = self.zj_right - self.btnOffset;
    self.cancelBtn.zj_left = self.btnOffset;
}

/// 设置选择行背景颜色
/// @param pickerView 选择器
- (void)changeSpearatorLineColor:(UIPickerView *)pickerView
{
    for (UIView *speartorView in pickerView.subviews) {
        if (speartorView.frame.size.height < 80) {  //找出当前的View
            if (speartorView.subviews.count == 0) {
                if (self.rowLineHeight > 0 && !self.isRowLineSet) {
                    self.isRowLineSet = YES;
                    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, speartorView.zj_width, self.rowLineHeight)];
                    line.backgroundColor = self.rowLineColor;
                    [speartorView addSubview:line];

                    CGFloat height = [self pickerView:pickerView rowHeightForComponent:0];
                    line = [[UIView alloc] initWithFrame:CGRectMake(0, height-self.rowLineHeight, speartorView.zj_width, self.rowLineHeight)];
                    line.backgroundColor = self.rowLineColor;
                    [speartorView addSubview:line];
                }
                speartorView.backgroundColor = self.rowBackgroundColor;
            }
        }
    }
}

#pragma mark -

- (void)setTitle:(NSString *)title
{
    self.titleLB.text = title;
}

- (NSString *)title
{
    return self.titleLB.text;
}

- (void)setTitleColor:(UIColor *)titleColor
{
    _titleColor = titleColor;
    self.titleLB.textColor = titleColor;
}

- (void)setTitleFont:(UIFont *)titleFont
{
    _titleFont = titleFont;
    self.titleLB.font = titleFont;
}

- (void)setOkTitle:(NSString *)okTitle
{
    _okTitle = okTitle;
    [self.okBtn setTitle:okTitle forState:UIControlStateNormal];
}

- (void)setOkTitleColor:(UIColor *)okTitleColor
{
    _okTitleColor = okTitleColor;
    [self.okBtn setTitleColor:okTitleColor forState:UIControlStateNormal];
}

- (void)setOkTitleFont:(UIFont *)okTitleFont
{
    _okTitleFont = okTitleFont;
    self.okBtn.titleLabel.font = okTitleFont;
}

- (void)setCancelTitle:(NSString *)cancelTitle
{
    _cancelTitle = cancelTitle;
    [self.cancelBtn setTitle:cancelTitle forState:UIControlStateNormal];
}

- (void)setCancelTitleColor:(UIColor *)cancelTitleColor
{
    _cancelTitleColor = cancelTitleColor;
    [self.cancelBtn setTitleColor:cancelTitleColor forState:UIControlStateNormal];
}

- (void)setCancelTitleFont:(UIFont *)cancelTitleFont
{
    _cancelTitleFont = cancelTitleFont;
    self.cancelBtn.titleLabel.font = cancelTitleFont;
}

- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    self.backView.backgroundColor = backgroundColor;
}

- (void)setCornerRadius:(CGFloat)cornerRadius
{
    _cornerRadius = cornerRadius;
    if (cornerRadius >= 0) {
        [self.backView zj_drawCircularWithCornerRadii:CGSizeMake(cornerRadius, cornerRadius) rectCorner:(UIRectCornerTopLeft | UIRectCornerTopRight)];
    }
}

- (void)setTopViewHeight:(CGFloat)topViewHeight
{
    _topViewHeight = topViewHeight;
    self.okBtn.zj_height = topViewHeight;
    self.cancelBtn.zj_height = topViewHeight;
    self.titleLB.zj_height = topViewHeight;
    
    for (UIPickerView *pickerView in self.pickerViewArray) {
        pickerView.zj_top = self.okBtn.zj_height;
        pickerView.zj_height = self.backView.zj_height - topViewHeight;
    }
}

- (void)setBtnOffset:(CGFloat)btnOffset
{
    _btnOffset = btnOffset;
    self.cancelBtn.zj_left = btnOffset;
    self.okBtn.zj_right = self.zj_width - btnOffset;
    self.titleLB.zj_width = self.zj_width - (self.okBtn.zj_width + btnOffset) * 2;
}
    
- (void)setItemsArray:(NSArray<ZJPickerItem *> *)itemsArray
{
    _itemsArray = itemsArray;

    for (UIPickerView *pickerView in self.pickerViewArray) {
        pickerView.delegate = nil;
        pickerView.dataSource = nil;
        [pickerView removeFromSuperview];
    }
    [self.pickerViewArray removeAllObjects];
    if (self.itemsArray.count == 0) return;
    
    CGFloat width = self.backView.zj_width/self.itemsArray.count;
    for (int i=0; i<self.itemsArray.count; i++) {
        ZJPickerItem *item = [self.itemsArray objectAtIndex:i];
        UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(width * i, self.okBtn.zj_height, width, self.backView.zj_height - self.okBtn.zj_height)];
        pickerView.backgroundColor = [UIColor clearColor];
        pickerView.dataSource = self;
        pickerView.delegate = self;
        pickerView.showsSelectionIndicator = NO;
        pickerView.tag = i;
        
        [self.pickerViewArray addObject:pickerView];
        [self.backView addSubview:pickerView];
        
        if (item.selectIndex < item.titleArray.count) { //选中默认行
            [pickerView selectRow:item.selectIndex inComponent:0 animated:YES];
        }
    }
}

- (void)setDelegate:(id<ZJPickerViewDelegate>)delegate
{
    _delegate = delegate;
    self.isRowLineSet = NO;
    [self setItemsArray:self.itemsArray];
}

#pragma mark -

- (void)clickedOKAction
{
    if (_delegate && [self.delegate respondsToSelector:@selector(pickerView:didConfirmWithRows:titles:)]) {
        NSMutableArray *selectArray = [NSMutableArray array];
        NSMutableArray *titleArray = [NSMutableArray array];
        for (ZJPickerItem *item in self.itemsArray) {
            [selectArray addObject:[NSNumber numberWithUnsignedInteger:item.selectIndex]];
            if (item.selectIndex < item.titleArray.count) {
                [titleArray addObject:item.titleArray[item.selectIndex]];
            } else {
                [titleArray addObject:@""];
            }
        }
        [self.delegate pickerView:self didConfirmWithRows:selectArray titles:titleArray];
    }
    [self dismiss];
}

- (void)clickedCancelAction
{
    [self dismiss];
}

- (void)show
{
    [ZJScreen.keyWindow addSubview:self];
    @weakify(self);
    [UIView animateWithDuration:0.3 animations:^{
        @strongify(self);
        self.hidden = NO;
        self.maskView.backgroundColor = self.maskColor;
        self.backView.zj_top = self.zj_height - self.pickerFrame.size.height;
    } completion:^(BOOL finished) {
    }];
}

- (void)dismiss
{
    @weakify(self);
    [UIView animateWithDuration:0.3 animations:^{
        @strongify(self);
        self.maskView.backgroundColor = [UIColor clearColor];
        self.backView.zj_top = self.zj_height;
    } completion:^(BOOL finished) {
        @strongify(self);
        [self setItemsArray:nil];
        self.delegate = nil;
        [self removeFromSuperview];
    }];
}

- (void)selectComponent:(NSInteger)component row:(NSInteger)row animated:(BOOL)animated
{
    if (component >= self.itemsArray.count || component >= self.pickerViewArray.count) return;
    
    ZJPickerItem *item = [self.itemsArray objectAtIndex:component];
    if (row >= item.titleArray.count) return;
    UIPickerView *pickerView = [self.pickerViewArray objectAtIndex:component];
    [pickerView selectRow:row inComponent:0 animated:animated];
}

#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return self.itemsArray.count > 0 ? 1 : 0;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (pickerView.tag >= self.itemsArray.count) return 0;
    if (_delegate && [self.delegate respondsToSelector:@selector(pickerView:numberOfRowsInComponent:)]) {
        return [self.delegate pickerView:self numberOfRowsInComponent:pickerView.tag];
    }
    
    ZJPickerItem *item = [self.itemsArray objectAtIndex:pickerView.tag];
    return item.titleArray.count;
}


#pragma mark - UIPickerViewDelegate

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    if (_delegate && [self.delegate respondsToSelector:@selector(pickerView:rowHeightForComponent:)]) {
        return [self.delegate pickerView:self rowHeightForComponent:pickerView.tag];
    }
    return 56.0;
}

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (pickerView.tag >= self.itemsArray.count) return nil;
    if (_delegate && [self.delegate respondsToSelector:@selector(pickerView:titleForRow:forComponent:)]) {
        return [self.delegate pickerView:self titleForRow:row forComponent:pickerView.tag];
    }
    
    ZJPickerItem *item = [self.itemsArray objectAtIndex:pickerView.tag];
    if (component >= item.titleArray.count) return nil;
    return [item.titleArray objectAtIndex:row];
}

- (nullable NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    [self changeSpearatorLineColor:pickerView];
    if (_delegate && [self.delegate respondsToSelector:@selector(pickerView:attributedTitleForRow:forComponent:)]) {
        return [self.delegate pickerView:self attributedTitleForRow:row forComponent:pickerView.tag];
    }
    
    if (self.rowTitleFont && self.rowTitleColor) {
        if (pickerView.tag >= self.itemsArray.count) return nil;
        
        ZJPickerItem *item = [self.itemsArray objectAtIndex:pickerView.tag];
        if (component >= item.titleArray.count) return nil;
        NSString *title = [item.titleArray objectAtIndex:row];
        return [title zj_stringWithColor:self.rowTitleColor font:self.rowTitleFont];
    }
    
    return nil;
}

//- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view
//{
//    [self changeSpearatorLineColor:pickerView];
//
//    /// 未选中颜色
//    UILabel* pickerLabel = (UILabel*)view;
//    if (!pickerLabel) {
//        pickerLabel = [[UILabel alloc] init];
//        pickerLabel.adjustsFontSizeToFitWidth = YES;
//        pickerLabel.textAlignment = NSTextAlignmentCenter;
//        pickerLabel.font = self.rowTitleFont;
//        pickerLabel.textColor = self.rowTitleColor;
//        pickerLabel.backgroundColor = self.rowBackgroundColor;
//    }
//
//    NSAttributedString *attr = [self pickerView:pickerView attributedTitleForRow:row forComponent:component];
//    if (attr) {
//        pickerLabel.attributedText = attr;
//    } else {
//        pickerLabel.text = [self pickerView:pickerView titleForRow:row forComponent:component];
//    }
//
//    return pickerLabel;
//}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (pickerView.tag >= self.itemsArray.count) return;
    ZJPickerItem *item = [self.itemsArray objectAtIndex:pickerView.tag];
    item.selectIndex = row;
    
    if (_delegate && [self.delegate respondsToSelector:@selector(pickerView:didSelectRow:inComponent:)]) {
        return [self.delegate pickerView:self didSelectRow:row inComponent:pickerView.tag];
    }
    
    //重置下一列
    if (self.isResetNext) {
        if (pickerView.tag < self.itemsArray.count - 1) {
            [self selectComponent:pickerView.tag + 1 row:0 animated:YES];
        }
    }
}

@end
