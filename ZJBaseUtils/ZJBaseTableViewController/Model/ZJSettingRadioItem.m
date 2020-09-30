//
//  ZJSettingRadioItem.m
//  ZJSmartUtils
//
//  Created by 李治健 on 2020/9/29.
//  Copyright © 2020 Jimi. All rights reserved.
//

#import "ZJSettingRadioItem.h"
#import "UIView+ZJFrame.h"
#import "ZJScreen.h"
#import "UIButton+ZJExt.h"
#import "UIColor+ZJExt.h"
#import "ZJBaseTableViewConfig+ZJExt.h"
#import "ZJSettingTableViewCellExt.h"

@interface ZJSettingRadioItem ()

@property (nonatomic,strong) NSMutableArray *btnArray;

@end

@implementation ZJSettingRadioItem

- (ZJSettingItemType)type
{
    return ZJSettingItemTypeRadio;
}

- (UIView *)accessoryView
{
    if (!super.accessoryView) {
        super.accessoryView = [[UIView alloc] init];
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
    if (self.selectIcon) [btn setImage:[UIImage imageNamed:self.selectIcon] forState:UIControlStateSelected];
    if (self.radioBtnTitleColor) [btn setTitleColor:self.radioBtnTitleColor forState:UIControlStateNormal];
    else [btn setTitleColor:ZJColorFromHex(@"#181E28") forState:UIControlStateNormal];
    if (self.radioBtnTitleFont) btn.titleLabel.font = self.radioBtnTitleFont;
    else btn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    
    [btn addTarget:self action:@selector(clickedRadioBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.accessoryView addSubview:btn];
    
    return btn;
}

- (NSMutableArray *)btnArray
{
    if (!_btnArray) {
        _btnArray = [NSMutableArray array];
    }
    return _btnArray;
}

- (void)setTitleArray:(NSArray<NSString *> *)titleArray
{
    _titleArray = titleArray.copy;
    for (int i=0; i < titleArray.count; i++) {
        UIButton *btn = nil;
        if (self.btnArray.count > i) {
             btn = [self.btnArray objectAtIndex:i];
        } else {
            btn = [self createRadioBtn];
            [self.btnArray addObject:btn];
        }
        btn.tag = i;
        [btn setTitle:[titleArray objectAtIndex:i] forState:UIControlStateNormal];
    }
    
    //删除多余的按钮
    NSInteger count = self.btnArray.count - titleArray.count;
    for (int i=0; i < count; i++) {
        [self.btnArray removeLastObject];
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
        
        if (self.stateArray.count > i) {
            [btn setSelected:[[self.stateArray objectAtIndex:i] boolValue]];
        } else {
            [btn setSelected:NO];
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
    for (UIButton *btn in btnArray) {
        if (preBtn) {
            btn.zj_right = preBtn.zj_left - self.btnSpace;
        } else {
            btn.zj_right = self.accessoryView.zj_width;
        }
        btn.zj_centerY = self.accessoryView.zj_centerY;
        preBtn = btn;
    }
}

- (void)updateDiffCinfigWithCell:(ZJSettingTableViewCell *)cell config:(ZJBaseTableViewConfig *)config
{
    if (!self.radioBtnTitleColor && config.radioBtnTitleColor) self.radioBtnTitleColor = config.textFieldTitleColor;
    if (!self.radioBtnTitleFont && config.radioBtnTitleFont) self.radioBtnTitleFont = config.textFieldTitleFont;
}

#pragma mark -

- (void)clickedRadioBtnAction:(UIButton *)btn
{
    [btn setSelected:!btn.selected];
    
    NSArray *btnArray = self.btnArray.copy;
    NSMutableArray *stateArray = [NSMutableArray array];
    if (self.radioModel) {  //单选模式
        for (UIButton *btnT in btnArray) {
            if (btnT.tag != btn.tag) {
                [btnT setSelected:!btn.selected];
            }
            [stateArray addObject:[NSNumber numberWithBool:btnT.selected]];
        }
    } else {
        [stateArray addObjectsFromArray:self.stateArray];
        [stateArray replaceObjectAtIndex:btn.tag withObject:[NSNumber numberWithBool:btn.selected]];
    }
    if (_radioBtnBlock) {
        self.radioBtnBlock(stateArray, btn.tag, btn.selected);
    }
}

@end
