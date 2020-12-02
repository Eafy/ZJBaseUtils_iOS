//
//  ZJSettingButtonItem.m
//  ZJBaseUtils
//
//  Created by eafy on 2020/12/2.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import "ZJSettingButtonItem.h"
#import "ZJBaseTVConfig.h"
#import "ZJSettingTableViewCellExt.h"
#import "UIView+ZJFrame.h"

@interface ZJSettingButtonItem()

@property (nonatomic,assign) CGSize size;

@end

@implementation ZJSettingButtonItem

- (ZJSettingItemType)type
{
    _enable = YES;
    return ZJSettingItemTypeButton;
}

- (UIButton *)detailBtn
{
    if (!_detailBtn) {
        _detailBtn = [[UIButton alloc] init];
        _detailBtn.enabled = self.enable;
        _detailBtn.backgroundColor = [UIColor clearColor];
        _detailBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        _detailBtn.contentMode = UIViewContentModeScaleAspectFit;
        [_detailBtn addTarget:self action:@selector(clickedDetailBtnAction:) forControlEvents:UIControlEventValueChanged];
    }
    return _detailBtn;
}

- (UIView *)accessoryView
{
    if (super.accessoryView.tag != self.type) {
        super.accessoryView = self.detailBtn;
        super.accessoryView.tag = self.type;
    }
    
    return super.accessoryView;
}

- (void)setEnable:(BOOL)enable
{
    _enable = enable;
    self.detailBtn.enabled = enable;
}

- (void)setDetailTitle:(NSString *)detailTitle
{
    super.detailTitle = detailTitle;
    [self.detailBtn setTitle:super.detailTitle forState:UIControlStateNormal];
}

- (void)setImageName:(NSString *)imageName
{
    _imageName = imageName;
    UIImage *img = imageName?[UIImage imageNamed:imageName]:nil;
    [self.detailBtn setImage:img forState:UIControlStateNormal];
    
    self.size = img ? img.size : CGSizeZero;
}

#pragma mark - 重载差异化

- (void)updateDiffDataWithCell:(ZJSettingTableViewCell *)cell
{
    if (CGSizeEqualToSize(self.size, CGSizeZero)) {
        self.size = [self.detailBtn imageForState:UIControlStateNormal].size;
    }
    
    if (self.size.height == 0 || self.size.height > cell.contentView.zj_height) {
        _size.height = cell.contentView.zj_height;
    }
    
    self.detailBtn.zj_width = self.size.height * 2;
    self.detailBtn.zj_height = self.size.height;
}

- (void)updateDiffConfigWithCell:(ZJSettingTableViewCell *)cell config:(ZJBaseTVConfig *)config
{
    if (!self.titleColor && config.cellDetailTitleColor) [self.detailBtn setTitleColor:config.cellDetailTitleColor forState:UIControlStateNormal];
    if (!self.titleFont && config.cellDetailTitleFont) self.detailBtn.titleLabel.font = config.cellDetailTitleFont;
}

#pragma mark - btnAction

- (void)clickedDetailBtnAction:(UIButton *)btn
{
    if (_clickedBtnBlock) {
        self.clickedBtnBlock(btn);
    }
}

@end
