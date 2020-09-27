//
//  ZJSettingTableViewCell.m
//  ZJBaseUtils
//
//  Created by eafy on 2020/9/14.
//  Copyright © 2020 ZJ<lizhijian_21@163.com>. All rights reserved.
//

#import "ZJSettingTableViewCell.h"
#import "ZJBaseTableViewConfig+ZJExt.h"
#import "ZJSettingItem.h"
#import "ZJSettingArrowItem.h"
#import "ZJSettingSwitchItem.h"
#import "ZJSettingLabelItem.h"
#import "ZJSettingCenterLableItem.h"
#import "ZJSettingCustomViewItem.h"
#import "UIColor+ZJExt.h"
#import "ZJSystem.h"
#import "ZJScreen.h"
#import "UIView+ZJFrame.h"
#import "NSString+ZJExt.h"
#import "ZJLocalizationTool.h"
#import "UIImageView+ZJExt.h"

@interface ZJSettingTableViewCell()

/// 表单全局配置参数
@property (nonatomic,strong) ZJBaseTableViewConfig *tableViewConfig;

@property (nonatomic, strong) UIImageView *arrowImgView;
@property (nonatomic, strong) UISwitch *switchBtn;
@property (nonatomic, strong) UILabel *subTitleLabel;
@property (nonatomic, strong) UIImageView *titleDetailImgView;

//缓存数据
@property (nonatomic, copy) NSString *arrowIcon;
@property (nonatomic, copy) NSString *titleDetailIcon;      //缓存Detail图片名称

@end

@implementation ZJSettingTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView item:(ZJSettingItem *)item config:(ZJBaseTableViewConfig *)config;
{
    static NSString *identifier = @"kZJBaseTableViewControllerCellIdentifier";
    ZJSettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell || ![cell.item isKindOfClass:[item class]]) {
        if ((item.subTitle && item.detailTitle)) {
            cell = [[ZJSettingTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
        } else {
            cell = [[ZJSettingTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
        }
        cell.item = item;
        cell.tableViewConfig = config;
        cell.tag = item.tag;
    } else {
        for (UIView *subView in cell.contentView.subviews) {
            [subView removeFromSuperview];
        }
    }
    
    return cell;
}

#pragma mark - 初始化样式

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.textLabel.backgroundColor = [UIColor clearColor];
        self.detailTextLabel.backgroundColor = [UIColor clearColor];
        
        self.detailTextLabel.numberOfLines = 0;
        self.textLabel.numberOfLines = 0;
    }
    
    return self;
}

- (void)setTableViewConfig:(ZJBaseTableViewConfig *)tableViewConfig
{
    _tableViewConfig = tableViewConfig;
    
    if (self.tableViewConfig.cellBgColor) self.backgroundColor = self.tableViewConfig.cellBgColor;
    if (self.tableViewConfig.cellSelectedBgColor) {
        UIView *selectView = [[UIView alloc] init];
        selectView.backgroundColor = self.tableViewConfig.cellSelectedBgColor;
        [self setSelectedBackgroundView:selectView];
    }
    
    if (self.tableViewConfig.cellTitleColor) [self.textLabel setTextColor:self.tableViewConfig.cellTitleColor];
    if (self.tableViewConfig.cellTitleFont) [self.textLabel setFont:self.tableViewConfig.cellTitleFont];
    
    if (self.item.subTitle) {
        if (self.tableViewConfig.cellSubTitleColor) [self.detailTextLabel setTextColor:self.tableViewConfig.cellSubTitleColor];
        if (self.tableViewConfig.cellSubTitleFont) [self.detailTextLabel setFont:self.tableViewConfig.cellSubTitleFont];
    } else {
        if (self.tableViewConfig.cellDetailTitleColor) [self.detailTextLabel setTextColor:self.tableViewConfig.cellDetailTitleColor];
        if (self.tableViewConfig.cellDetailTitleFont) [self.detailTextLabel setFont:self.tableViewConfig.cellDetailTitleFont];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
        
    if (_titleDetailImgView) {
        self.titleDetailImgView.zj_left = self.textLabel.zj_right + 5.0f;
        self.titleDetailImgView.zj_centerY = self.textLabel.zj_centerY;
    }
    
    if ([self.item isKindOfClass:[ZJSettingCenterLableItem class]]) {
        self.subTitleLabel.frame = self.contentView.bounds;
    } else if (_subTitleLabel) {   //有副标题
        [self.textLabel sizeToFit];
        [self.detailTextLabel sizeToFit];
        CGFloat fontHeight = self.textLabel.font.lineHeight - self.detailTextLabel.font.lineHeight;
        if (fontHeight > 0) {   //微调textLabel、detailTextLabel在垂直方向的位置
            self.textLabel.zj_bottom += fontHeight/2.0;
            self.detailTextLabel.zj_bottom += fontHeight/2.0;
        }
        self.subTitleLabel.zj_centerY = self.contentView.zj_centerY;
        self.subTitleLabel.zj_width = self.contentView.zj_width - self.textLabel.zj_right - 10.0f;
        if (self.accessoryView) {
            self.subTitleLabel.zj_right = self.accessoryView.zj_left - 5.0f;
        } else {
            self.subTitleLabel.zj_right = self.contentView.zj_right - 15.0f;
        }
    } else {
        self.detailTextLabel.zj_right = self.contentView.zj_right - 5.0f;
        self.detailTextLabel.zj_centerY = self.contentView.zj_centerY;
    }
}

- (void)dealloc
{
    _item = nil;
    if (_customView) {
        [self.customView removeFromSuperview];
        _customView = nil;
    }
}

#pragma mark - View懒加载

- (UILabel *)subTitleLabel
{
    if (!_subTitleLabel) {
        _subTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, self.zj_height)];
        _subTitleLabel.backgroundColor = [UIColor clearColor];
        _subTitleLabel.textAlignment = NSTextAlignmentRight;
        _subTitleLabel.numberOfLines = 0;
    }
    
    if (self.item.subTitle &&
        ![self.item isKindOfClass:[ZJSettingCenterLableItem class]]) {
        if (self.tableViewConfig.cellDetailTitleColor) [_subTitleLabel setTextColor:self.tableViewConfig.cellDetailTitleColor];
        if (self.tableViewConfig.cellDetailTitleFont) [_subTitleLabel setFont:self.tableViewConfig.cellDetailTitleFont];
    }
    
    return _subTitleLabel;
}

- (UIImageView *)arrowImgView
{
    if (self.item.arrowIcon && ![self.item.arrowIcon zj_isEmpty]) {
        if (![self.item.arrowIcon isEqualToString:self.arrowIcon]) {
            if (_arrowImgView) [_arrowImgView removeFromSuperview];
            UIImage *arrowImg = [UIImage imageNamed:self.item.arrowIcon];
            if (arrowImg) {
                _arrowImgView = [[UIImageView alloc] initWithImage:arrowImg];
            }
        }
    } else {
        if (_arrowImgView) {
            [_arrowImgView removeFromSuperview];
            _arrowImgView = nil;
        }
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    return _arrowImgView;
}

- (UISwitch *)switchBtn
{
    if (_switchBtn == nil) {
        _switchBtn = [[UISwitch alloc] init];
        [_switchBtn addTarget:self action:@selector(switchBtnChange:) forControlEvents:UIControlEventValueChanged];
    }
    return _switchBtn;
}

- (UIImageView *)titleDetailImgView
{
    if (self.item.titleDetailIcon && ![self.item.titleDetailIcon zj_isEmpty]) {
        if (![self.item.titleDetailIcon isEqualToString:self.titleDetailIcon]) {
            if (_titleDetailImgView) [_titleDetailImgView removeFromSuperview];
            _titleDetailImgView = [UIImageView zj_imageWithName:self.item.titleDetailIcon center:CGPointMake(0, 0) scale:1.0];
            self.titleDetailIcon = self.item.titleDetailIcon;
            _titleDetailImgView.image = [UIImage imageNamed:self.item.titleDetailIcon];
        }
    } else {
        self.titleDetailIcon = nil;
        if (_titleDetailImgView) {
            [_titleDetailImgView removeFromSuperview];
            _titleDetailImgView = nil;
        }
    }
    
    return _titleDetailImgView;
}

#pragma mark - 设置cell数据

- (void)setItem:(ZJSettingItem *)item
{
    _item = item;
    self.textLabel.text = item.title.localized;
    if (self.item.icon && ![self.item.icon zj_isEmpty]) {
        self.imageView.image = [UIImage imageNamed:_item.icon];
    }
    
    if ([self.item isKindOfClass:[ZJSettingCustomViewItem class]]) {
        self.imageView.image = nil;
        self.textLabel.text = nil;
        if (!self.customView.superview) {
            [self.contentView addSubview:self.customView];
        }
    } else if ([self.item isKindOfClass:[ZJSettingArrowItem class]] ||
               [self.item isKindOfClass:[ZJSettingLabelItem class]] ||
               [self.item isKindOfClass:[ZJSettingSwitchItem class]]) {
        if (self.item.subTitle && self.item.detailTitle) {
            self.subTitleLabel.text = self.item.detailTitle;
            self.detailTextLabel.text = self.item.subTitle;
            [self.subTitleLabel removeFromSuperview];
            [self.contentView addSubview:self.subTitleLabel];
        } else {
            self.detailTextLabel.text = self.item.detailTitle;
        }
        
        if ([self.item isKindOfClass:[ZJSettingLabelItem class]]) {
            self.accessoryType = UITableViewCellAccessoryNone;
            self.selectionStyle = UITableViewCellSelectionStyleNone;
        } else if ([self.item isKindOfClass:[ZJSettingSwitchItem class]]) {
            ZJSettingSwitchItem *itemT = (ZJSettingSwitchItem *)self.item;
            self.accessoryView = self.switchBtn;
            self.switchBtn.on = itemT.switchBtnValue;
            self.switchBtn.enabled = itemT.switchBtnEnable;
            self.selectionStyle = UITableViewCellSelectionStyleNone;
        } else {
            self.accessoryView = self.arrowImgView;
        }
    } else if ([self.item isKindOfClass:[ZJSettingCenterLableItem class]]) {
        self.textLabel.text = @"";
        self.detailTextLabel.text = @"";
        self.imageView.image = nil;
        [self.subTitleLabel removeFromSuperview];
        self.accessoryType = UITableViewCellAccessoryNone;
        
        ZJSettingCenterLableItem *itemT = (ZJSettingCenterLableItem *)self.item;
        if (itemT.titleColor) self.subTitleLabel.textColor = itemT.titleColor;
        if (itemT.titleFont) self.subTitleLabel.font = itemT.titleFont;

        self.subTitleLabel.textAlignment = NSTextAlignmentCenter;
        self.subTitleLabel.text = self.item.title.localized;
        [self.contentView addSubview:self.subTitleLabel];
    }
}

#pragma mark - SwitchBtnAction

- (void)switchBtnChange:(UISwitch *)switchBtn
{
    ZJSettingSwitchItem *itemT = (ZJSettingSwitchItem *)self.item;
    if (itemT.switchBtnBlock) {
        itemT.switchBtnBlock(switchBtn);
    }
}

@end
