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

@interface ZJPickerView () <UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic,strong) UIView *backView;

@property (nonatomic,strong) NSMutableArray<UIPickerView *> *pickerViewArray;

@end

@implementation ZJPickerView
@dynamic delegate;

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:CGRectMake(0, 0, ZJScreenWidth(), ZJScreenHeight())]) {
        self.backgroundColor = [UIColor colorWithRed:40/255.0 green:43/255.0 blue:54/255.0 alpha:0.5];
        
        frame.size.height = 300;
        
        [self addSubview:self.backView];
        [self.backView addSubview:self.titleLB];
        [self.backView addSubview:self.okBtn];
        [self.backView addSubview:self.cancelBtn];
        
        [self setPickerFrame:frame];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickedCancelAction)];
        [self addGestureRecognizer:tap];
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

- (UILabel *)titleLB
{
    if (!_titleLB) {
        _titleLB = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ZJScreenWidth() - self.okBtn.zj_width * 2 - 50, self.okBtn.zj_height)];
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
        _okBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 56.0, 56.0)];
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
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = [UIColor whiteColor];
    }
    
    return _backView;
}

- (void)setPickerFrame:(CGRect)pickerFrame
{
    self.backView.frame = CGRectMake(0, self.zj_height - pickerFrame.size.height, pickerFrame.size.width, pickerFrame.size.height);
    
    self.titleLB.zj_centerX = self.backView.zj_centerX;
    self.okBtn.zj_right = self.zj_right- 15.0;
    self.cancelBtn.zj_left = 15.0;
}

#pragma mark -

- (void)clickedOKAction
{
    
}

- (void)clickedCancelAction
{
    [self hide];
}

- (void)setTitle:(NSString *)title
{
    self.titleLB.text = title;
}

- (NSString *)title
{
    return self.titleLB.text;
}

- (NSMutableArray<UIPickerView *> *)pickerViewArray
{
    if (!_pickerViewArray) {
        _pickerViewArray = [NSMutableArray array];
    }
    return _pickerViewArray;
}
    
- (void)setItemsArray:(NSArray<ZJPickerItem *> *)itemsArray
{
    _itemsArray = itemsArray;
    [self resetPickerView];
}

- (void)resetPickerView
{
    for (UIPickerView *pickerView in self.pickerViewArray) {
        [pickerView removeFromSuperview];
    }
    [self.pickerViewArray removeAllObjects];
    
    for (int i=0; i<self.itemsArray.count; i++) {
        UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, self.okBtn.zj_height, self.backView.zj_width/self.itemsArray.count, self.backView.zj_height - self.okBtn.zj_height)];
        pickerView.backgroundColor = [UIColor blueColor];
        pickerView.tag = i;
        pickerView.dataSource = self;
        pickerView.delegate = self;
        [self.backView addSubview:pickerView];
        
        [self.pickerViewArray addObject:pickerView];
    }
}

#pragma mark -

- (void)show
{
    @weakify(self);
    [UIView animateWithDuration:0.5 animations:^{
        @strongify(self);
//        [self.beginPickerView selectRow:self.startHour inComponent:0 animated:YES];
//        [self.beginPickerView selectRow:self.startMin inComponent:1 animated:YES];
//        [self.overPickerView selectRow:self.endHour inComponent:0 animated:YES];
//        [self.overPickerView selectRow:self.endMin inComponent:1 animated:YES];
        self.hidden = NO;
        self.backgroundColor = [UIColor colorWithRed:40/255.0 green:43/255.0 blue:54/255.0 alpha:0.5];
    } completion:^(BOOL finished) {
    }];
//    [((AppDelegate *)([UIApplication sharedApplication].delegate)).window addSubview:self];
}

- (void)hide
{
    @weakify(self);
    [UIView animateWithDuration:0.5 animations:^{
        @strongify(self);
        self.backgroundColor = [UIColor colorWithRed:40/255.0 green:43/255.0 blue:54/255.0 alpha:0];
//        self.timeView.frame = CGRectMake(0, kScreenHeight, kScreenWidth, 200);
    } completion:^(BOOL finished) {
        @strongify(self);
        self.hidden = YES;
    }];
}

#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return self.pickerViewArray.count;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component >= self.itemsArray.count) return 0;
    
    ZJPickerItem *item = [self.itemsArray objectAtIndex:component];
    return item.titleArray.count;
}

#pragma mark - UIPickerViewDelegate

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(pickerView:rowHeightForComponent:)]) {
        return [self.delegate pickerView:pickerView rowHeightForComponent:component];
    }
    return 56.0;
}

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component >= self.itemsArray.count) return nil;
    
    ZJPickerItem *item = [self.itemsArray objectAtIndex:component];
    if (component >= item.titleArray.count) return nil;
    return [item.titleArray objectAtIndex:row];
}


@end
