//
//  ZJSettingButtonItem.m
//  ZJBaseUtils
//
//  Created by eafy on 2020/12/2.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import <ZJBaseUtils/ZJSettingButtonItem.h>
#import <ZJBaseUtils/ZJBaseTVConfig.h>
#import <ZJBaseUtils/ZJSettingTableViewCellExt.h>
#import <ZJBaseUtils/UIView+ZJFrame.h>
#import <ZJBaseUtils/NSString+ZJExt.h>

@interface ZJSettingButtonItem()

@end

@implementation ZJSettingButtonItem

- (ZJSettingItemType)type {
    return ZJSettingItemTypeButton;
}

- (void)defaultData {
    _enable = YES;
}

- (UIButton *)detailBtn
{
    if (!_detailBtn) {
        _detailBtn = [[UIButton alloc] init];
        _detailBtn.enabled = self.enable;
        _detailBtn.backgroundColor = [UIColor clearColor];
        _detailBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        _detailBtn.contentMode = UIViewContentModeScaleAspectFit;
        if (self.btnTitleColor) [_detailBtn setTitleColor:self.btnTitleColor forState:UIControlStateNormal];
        if (self.btnTitleFont) _detailBtn.titleLabel.font = self.btnTitleFont;
        [_detailBtn addTarget:self action:@selector(clickedDetailBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _detailBtn;
}

- (UIView *)accessoryView {
    if (super.accessoryView.tag != self.type) {
        super.accessoryView = self.detailBtn;
        super.accessoryView.tag = self.type;
    }
    
    return super.accessoryView;
}

- (void)setEnable:(BOOL)enable {
    _enable = enable;
    self.detailBtn.enabled = enable;
}

- (void)setImageName:(NSString *)imageName {
    _imageName = imageName;
    UIImage *img = imageName?[UIImage imageNamed:imageName]:nil;
    [self.detailBtn setImage:img forState:UIControlStateNormal];
}

- (void)setBtnTitle:(NSString *)btnTitle {
    _btnTitle = btnTitle;
    [self.detailBtn setTitle:btnTitle forState:UIControlStateNormal];
}

- (void)setBtnTitleColor:(UIColor *)btnTitleColor {
    _btnTitleColor = btnTitleColor;
    [self.detailBtn setTitleColor:self.btnTitleColor forState:UIControlStateNormal];
}

- (void)setBtnTitleFont:(UIFont *)btnTitleFont {
    _btnTitleFont = btnTitleFont;
    self.detailBtn.titleLabel.font = self.btnTitleFont;
}

#pragma mark - 重载差异化

- (void)updateDiffDataWithCell:(ZJSettingTableViewCell *)cell
{
    CGSize size = self.detailBtn.zj_size;
    if (CGSizeEqualToSize(size, CGSizeZero)) {
        size = [self.detailBtn imageForState:UIControlStateNormal].size;
        if (size.height == 0 || size.height > cell.contentView.zj_height) {
            size.height = cell.contentView.zj_height;
        }
        NSInteger width = [[self.detailBtn titleForState:UIControlStateNormal] zj_sizeWithFont:self.detailBtn.titleLabel.font maxSize:CGSizeMake(cell.contentView.zj_width/2, cell.contentView.zj_height)].width;
        size.width = size.width + width;
        
        self.detailBtn.zj_width = size.width;
        self.detailBtn.zj_height = size.height;
    }
}

- (void)updateDiffConfigWithCell:(ZJSettingTableViewCell *)cell config:(ZJBaseTVConfig *)config
{
    if (!_btnTitleColor && config.cellDetailTitleColor) {
        [self.detailBtn setTitleColor:config.cellDetailTitleColor forState:UIControlStateNormal];
    }
    if (!_btnTitleFont && config.cellDetailTitleFont) {
        self.detailBtn.titleLabel.font = config.cellDetailTitleFont;
    }
}

#pragma mark - btnAction

- (void)clickedDetailBtnAction:(UIButton *)btn
{
    if (_clickedBtnBlock) {
        self.clickedBtnBlock(btn);
    }
}

@end
