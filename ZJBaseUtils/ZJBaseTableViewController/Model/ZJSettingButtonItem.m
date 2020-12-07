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

- (void)setImageName:(NSString *)imageName
{
    _imageName = imageName;
    UIImage *img = imageName?[UIImage imageNamed:imageName]:nil;
    [self.detailBtn setImage:img forState:UIControlStateNormal];
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
        if (size.width == 0) {
            size.width = size.height * 2;
        }
        
        self.detailBtn.zj_width = size.width;
        self.detailBtn.zj_height = size.height;
    }
}

- (void)updateDiffConfigWithCell:(ZJSettingTableViewCell *)cell config:(ZJBaseTVConfig *)config
{
 
}

#pragma mark - btnAction

- (void)clickedDetailBtnAction:(UIButton *)btn
{
    if (_clickedBtnBlock) {
        self.clickedBtnBlock(btn);
    }
}

@end
