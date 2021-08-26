//
//  ZJSettingRadioItem.m
//  ZJBaseUtils
//
//  Created by eafy on 2020/9/29.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import <ZJBaseUtils/ZJSettingRadioItem.h>
#import <ZJBaseUtils/UIView+ZJFrame.h>
#import <ZJBaseUtils/ZJScreen.h>
#import <ZJBaseUtils/UIButton+ZJExt.h>
#import <ZJBaseUtils/UIColor+ZJExt.h>
#import <ZJBaseUtils/ZJBaseTVConfig.h>
#import <ZJBaseUtils/ZJSettingTableViewCellExt.h>
#import <ZJBaseUtils/ZJBundleRes.h>

@interface ZJSettingRadioItem ()

@property (nonatomic,strong) NSMutableArray *btnArray;
@property (nonatomic,strong) NSMutableArray<NSNumber *> *stateBtnArray;
@property (nonatomic,assign) NSUInteger selectIndex;

@end

@implementation ZJSettingRadioItem

- (ZJSettingItemType)type
{
    return ZJSettingItemTypeRadio;
}

- (void)defaultData {
    _enable = YES;
}

- (void)setEnable:(BOOL)enable {
    _enable = enable;
    
    for (UIButton *btn in self.btnArray) {
        btn.enabled = enable;
    }
}

- (UIView *)accessoryView
{
    if (super.accessoryView.tag != self.type) {
        super.accessoryView = [[UIView alloc] init];
        super.accessoryView.tag = self.type;
        if (self.btnSpace == 0) {
            self.btnSpace = 24.0f;
        }
    }
    
    return super.accessoryView;
}

- (UIButton *)createRadioBtn
{
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100.0f, 44.0f)];
    btn.contentMode = UIViewContentModeRight;
    if (self.normalIcon) [btn setImage:[UIImage imageNamed:self.normalIcon] forState:UIControlStateNormal];
    else [btn setImage:[ZJBundleRes imageNamed:@"icon_radio_normal"] forState:UIControlStateNormal];
    if (self.selectIcon) [btn setImage:[UIImage imageNamed:self.selectIcon] forState:UIControlStateSelected];
    else [btn setImage:[ZJBundleRes imageNamed:@"icon_radio_selected"] forState:UIControlStateSelected];
    if (self.radioBtnTitleColor) [btn setTitleColor:self.radioBtnTitleColor forState:UIControlStateNormal];
    else [btn setTitleColor:ZJColorFromRGB(0x181E28) forState:UIControlStateNormal];
    if (self.radioBtnTitleFont) btn.titleLabel.font = self.radioBtnTitleFont;
    else btn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    
    if (self.selectDisIcon) [btn setImage:[UIImage imageNamed:self.selectDisIcon] forState:UIControlStateDisabled|UIControlStateSelected];
    else [btn setImage:[ZJBundleRes imageNamed:@"icon_radio_disabled_sel"] forState:UIControlStateDisabled|UIControlStateSelected];
    if (self.normalDisIcon) [btn setImage:[UIImage imageNamed:self.normalDisIcon] forState:UIControlStateDisabled|UIControlStateNormal];
    else [btn setImage:[ZJBundleRes imageNamed:@"icon_radio_disabled_nor"] forState:UIControlStateDisabled|UIControlStateNormal];
    
    [btn addTarget:self action:@selector(clickedRadioBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.accessoryView addSubview:btn];
    btn.enabled = self.enable;
    
    return btn;
}

- (NSMutableArray *)btnArray
{
    if (!_btnArray) {
        _btnArray = [NSMutableArray array];
    }
    return _btnArray;
}

- (NSMutableArray<NSNumber *> *)stateBtnArray {
    if (!_stateBtnArray) {
        _stateBtnArray = [NSMutableArray array];
    }
    
    return _stateBtnArray;
}

- (NSArray<NSNumber *> *)stateArray
{
    return self.stateBtnArray;
}

- (void)setStateArray:(NSArray<NSNumber *> *)stateArray
{
    _stateBtnArray = [NSMutableArray arrayWithArray:stateArray];
    [self clearBtnArray:stateArray.count];
}

- (void)setTitleArray:(NSArray<NSString *> *)titleArray
{
    _titleArray = titleArray.copy;
    
    [self clearBtnArray:titleArray.count];
    
    for (int i=0; i < titleArray.count; i++) {
        UIButton *btn = [self.btnArray objectAtIndex:i];
        [btn setTitle:[titleArray objectAtIndex:i] forState:UIControlStateNormal];
    }
}

- (void)clearBtnArray:(NSUInteger)count
{
    for (NSUInteger i=0; i < count; i++) {
        UIButton *btn = nil;
        if (i >= self.btnArray.count) {
            btn = [self createRadioBtn];
            [self.btnArray addObject:btn];
            btn.tag = i;
        } else {
            btn = [self.btnArray objectAtIndex:i];
        }
        if (i >= self.stateBtnArray.count) {
            [self.stateBtnArray addObject:@0];
        }
        btn.selected = [[self.stateBtnArray objectAtIndex:i] boolValue];
    }
    
    for (NSUInteger i=count; i<self.btnArray.count; i++) {
        [self.btnArray removeLastObject];
        if (i < self.stateBtnArray.count) {
            [self.stateBtnArray removeLastObject];
        }
    }
}

- (void)setNormalIcon:(NSString *)normalIcon
{
    if (![_normalIcon isEqualToString:normalIcon]) {
        _normalIcon = normalIcon;
        for (UIButton *btn in self.btnArray) {
            [btn setImage:[UIImage imageNamed:self.normalIcon] forState:UIControlStateNormal];
        }
    }
}

- (void)setSelectIcon:(NSString *)selectIcon
{
    if (![_selectIcon isEqualToString:selectIcon]) {
        _selectIcon = selectIcon;
        for (UIButton *btn in self.btnArray) {
            [btn setImage:[UIImage imageNamed:self.selectIcon] forState:UIControlStateSelected];
        }
    }
}

#pragma mark - 重载差异化

- (void)updateDiffDataWithCell:(ZJSettingTableViewCell *)cell
{
    CGFloat width = 0;  //计算所有按钮的宽度和按钮之间间隔的总和
    UIButton *preBtn = nil;
    NSArray *btnArray = self.btnArray.copy;
    for (int i=0; i<btnArray.count; i++) {  //这里主要为了计算accessoryView的宽度
        UIButton *btn = [btnArray objectAtIndex:i];
        [btn zj_layoutWithEdgeInsetsStyle:ZJButtonEdgeInsetsStyleLeft imageTitleSpace:5.0f];
        btn.zj_width = btn.imageView.zj_width + btn.titleLabel.zj_width + 5.0f;
        if (preBtn) {
            btn.zj_right = preBtn.zj_left - self.btnSpace;
            width += self.btnSpace;
        }
        width += btn.zj_width;
        preBtn = btn;
        
        [btn setSelected:[[self.stateBtnArray objectAtIndex:i] boolValue]];
        if (btn.selected) {
            self.selectIndex = i;
        }
    }
    self.accessoryView.zj_width = width;
}

- (void)layoutDiffSubviewWithCell:(ZJSettingTableViewCell *)cell
{
    self.accessoryView.zj_height = cell.contentView.zj_height;
    self.accessoryView.zj_centerY = cell.contentView.zj_centerY;
    
    //这里为了调整所有按钮的位置；
    UIButton *preBtn = nil;
    NSArray *btnArray = self.btnArray.copy;
    for (int i=(int)btnArray.count-1; i>=0; i--) {
        UIButton *btn = [self.btnArray objectAtIndex:i];
        if (preBtn) {
            btn.zj_right = preBtn.zj_left - self.btnSpace;
        } else {
            btn.zj_right = self.accessoryView.zj_width;
        }
        btn.zj_centerY = self.accessoryView.zj_centerY;
        preBtn = btn;
    }
}

- (void)updateDiffConfigWithCell:(ZJSettingTableViewCell *)cell config:(ZJBaseTVConfig *)config
{
    if (!self.radioBtnTitleColor && config.radioBtnTitleColor) self.radioBtnTitleColor = config.cellDetailTitleColor;
    if (!self.radioBtnTitleFont && config.radioBtnTitleFont) self.radioBtnTitleFont = config.cellDetailTitleFont;
}

#pragma mark -

- (void)clickedRadioBtnAction:(UIButton *)btn
{
    [btn setSelected:!btn.selected];
    
    NSArray *btnArray = self.btnArray.copy;
    if (self.radioModel) {  //单选模式
        for (UIButton *btnT in btnArray) {
            if (btnT.tag != btn.tag) {
                [btnT setSelected:!btn.selected];
            }
            [self.stateBtnArray replaceObjectAtIndex:btn.tag withObject:[NSNumber numberWithBool:btn.selected]];
        }
    } else {
        [self.stateBtnArray replaceObjectAtIndex:btn.tag withObject:[NSNumber numberWithBool:btn.selected]];
    }
    
    if (_radioBtnBlock) {
        BOOL selectedOld = btn.selected;
        BOOL selectedNew = btn.selected;
        self.radioBtnBlock([btn titleForState:UIControlStateNormal], self.stateBtnArray, btn.tag, &selectedNew);
        if (selectedOld != selectedNew) {   //外部不接受，还原之前的选项
            btn.selected = selectedNew;
            [self.stateBtnArray replaceObjectAtIndex:btn.tag withObject:[NSNumber numberWithBool:btn.selected]];
            if (self.radioModel) {  //单选框，还原之前的选择
                UIButton * btnT = [self.btnArray objectAtIndex:self.selectIndex];
                btnT.selected = YES;
                [self.stateBtnArray replaceObjectAtIndex:btnT.tag withObject:@YES];
            }
        } else {
            self.selectIndex = btn.tag;
        }
    }
}

- (void)selected:(NSUInteger)index
{
    if (index >= self.btnArray.count) return;
    
    if (self.radioModel) {
        for (int i=0; i<self.btnArray.count; i++) {
            UIButton *btn = [self.btnArray objectAtIndex:i];
            btn.selected = i == index;
            [self.stateBtnArray replaceObjectAtIndex:i withObject:@(i == index)];
        }
    } else {
        UIButton *btn = [self.btnArray objectAtIndex:index];
        btn.selected = YES;
        [self.stateBtnArray replaceObjectAtIndex:index withObject:@YES];
    }
}

@end
