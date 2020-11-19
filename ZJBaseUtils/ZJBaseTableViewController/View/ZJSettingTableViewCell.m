//
//  ZJSettingTableViewCell.m
//  ZJBaseUtils
//
//  Created by eafy on 2020/9/14.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import "ZJSettingTableViewCellExt.h"
#import "ZJBaseTVConfig.h"
#import "UIColor+ZJExt.h"
#import "ZJSystem.h"
#import "ZJScreen.h"
#import "UIView+ZJFrame.h"
#import "NSString+ZJExt.h"
#import "ZJLocalizationTool.h"
#import "UIImageView+ZJExt.h"

@interface ZJSettingTableViewCell()

/// 表单全局配置参数
@property (nonatomic,strong) ZJBaseTVConfig *tableViewConfig;

@property (nonatomic, strong) UIImageView *arrowImgView;
@property (nonatomic, strong) UIImageView *titleDetailImgView;

//缓存数据
@property (nonatomic, copy) NSString *arrowIcon;
@property (nonatomic, copy) NSString *titleHintIcon;      //缓存Detail图片名称

@end

@implementation ZJSettingTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView item:(ZJSettingItem *)item config:(ZJBaseTVConfig *)config;
{
    NSString *identifier = [NSString stringWithFormat:@"kZJBaseTableViewCellIdentifier_%lu", (unsigned long)item.type];
    ZJSettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        if (item.subTitle) {
            cell = [[ZJSettingTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
        } else {
            cell = [[ZJSettingTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    cell.tableViewConfig = config;
    cell.item = item;
    cell.tag = item.tag;
    
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

- (void)dealloc
{
    _item = nil;
}

- (void)setTableViewConfig:(ZJBaseTVConfig *)tableViewConfig
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
    if (self.tableViewConfig.cellDetailTitleColor) [self.detailTextLabel setTextColor:self.tableViewConfig.cellDetailTitleColor];
    if (self.tableViewConfig.cellDetailTitleFont) [self.detailTextLabel setFont:self.tableViewConfig.cellDetailTitleFont];
    if (self.tableViewConfig.cellSubTitleColor) [self.subTitleLabel setTextColor:self.tableViewConfig.cellSubTitleColor];
    if (self.tableViewConfig.cellSubTitleFont) [self.subTitleLabel setFont:self.tableViewConfig.cellSubTitleFont];
    
    if (self.item.subTitle && self.item.detailTitle) {
        if (self.tableViewConfig.cellSubTitleColor) [self.detailTextLabel setTextColor:self.tableViewConfig.cellSubTitleColor];
        if (self.tableViewConfig.cellSubTitleFont) [self.detailTextLabel setFont:self.tableViewConfig.cellSubTitleFont];
        if (self.tableViewConfig.cellDetailTitleColor) [self.subTitleLabel setTextColor:self.tableViewConfig.cellDetailTitleColor];
        if (self.tableViewConfig.cellSubTitleFont) [self.subTitleLabel setFont:self.tableViewConfig.cellDetailTitleFont];
    }
    
    [self.item updateDiffConfigWithCell:self config:tableViewConfig];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
        
    CGFloat detailTextSpace = 0;
    if (self.accessoryView || self.accessoryType != UITableViewCellAccessoryNone) {
        detailTextSpace = 5.0f;
    } else {
        detailTextSpace = 15.0f;
    }
    
    if (self.item.iconView) {
        self.textLabel.zj_left = self.item.iconView.zj_right + 5.0f;
    }
    if (self.item.subTitle) {   //有副标题
        [self.textLabel sizeToFit];
        [self.detailTextLabel sizeToFit];
        CGFloat fontHeight = self.textLabel.font.lineHeight - (self.item.detailTitle ? self.detailTextLabel.font.lineHeight : self.subTitleLabel.font.lineHeight);
        if (fontHeight > 0) {   //微调textLabel、detailTextLabel在垂直方向的位置
            self.textLabel.zj_bottom = self.contentView.zj_height/2.0;
            self.detailTextLabel.zj_top = self.textLabel.zj_bottom + fontHeight;
            self.subTitleLabel.zj_top = self.detailTextLabel.zj_top;
        }
        
        if (self.item.detailTitle) {    //有详细
            self.subTitleLabel.zj_centerY = self.contentView.zj_centerY;
            CGFloat preRight = (self.textLabel.zj_right > self.detailTextLabel.zj_right ? self.textLabel.zj_right : self.detailTextLabel.zj_right) + 5.0f;  //计算子标题坐标
            self.subTitleLabel.zj_left = preRight;
            if (self.accessoryView) {
                self.subTitleLabel.zj_width = self.accessoryView.zj_left - preRight - detailTextSpace;
            } else {
                self.subTitleLabel.zj_width = self.contentView.zj_right - preRight - detailTextSpace;
            }
        } else {
            self.subTitleLabel.zj_left = self.textLabel.zj_left;
            self.subTitleLabel.textAlignment = NSTextAlignmentLeft;
            [self.subTitleLabel sizeToFit];
        }
    } else {
         if (self.accessoryView) {
                   self.detailTextLabel.zj_right = self.accessoryView.zj_right - detailTextSpace;
               } else {
                   self.detailTextLabel.zj_right = self.contentView.zj_right - detailTextSpace;
               }
        self.detailTextLabel.zj_centerY = self.contentView.zj_centerY;
    }
    
    if (_titleDetailImgView) {
        self.titleDetailImgView.zj_left = self.textLabel.zj_right + 5.0f;
        self.titleDetailImgView.zj_centerY = self.textLabel.zj_centerY;
    }
    
    [self.item layoutDiffSubviewWithCell:self];
}

#pragma mark - View懒加载

- (UILabel *)subTitleLabel
{
    if (!_subTitleLabel) {
        _subTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, self.zj_height)];
        _subTitleLabel.backgroundColor = [UIColor clearColor];
        _subTitleLabel.textAlignment = NSTextAlignmentRight;
        _subTitleLabel.numberOfLines = 0;
        [self.contentView addSubview:_subTitleLabel];
    }
    
    return _subTitleLabel;
}

- (UIImageView *)arrowImgView
{
    if (self.item.accessoryView && _arrowImgView != self.item.accessoryView) {
        _arrowImgView = (UIImageView *)self.item.accessoryView;
    } else if (self.item.arrowIcon) {
        if (![NSString zj_isEmpty:self.item.arrowIcon]) {
            if (![self.item.arrowIcon isEqualToString:self.arrowIcon]) {
                if (_arrowImgView) [_arrowImgView removeFromSuperview];
                UIImage *arrowImg = [UIImage imageNamed:self.item.arrowIcon];
                if (arrowImg) {
                    _arrowImgView = [[UIImageView alloc] initWithImage:arrowImg];
                }
            }
        }
    } else if (_arrowImgView != self.item.accessoryView && [NSString zj_isEmpty:self.item.arrowIcon]){
        if (_arrowImgView) {
            [_arrowImgView removeFromSuperview];
            _arrowImgView = nil;
        }
    }
    
    return _arrowImgView;
}

- (UIImageView *)titleDetailImgView
{
    if (![NSString zj_isEmpty:self.item.titleHintIcon]) {
        if (![self.item.titleHintIcon isEqualToString:self.titleHintIcon]) {
            if (_titleDetailImgView) [_titleDetailImgView removeFromSuperview];
            _titleDetailImgView = [UIImageView zj_imageWithName:self.item.titleHintIcon center:CGPointMake(0, 0) scale:1.0];
            self.titleHintIcon = self.item.titleHintIcon;
            _titleDetailImgView.image = [UIImage imageNamed:self.item.titleHintIcon];
        }
    } else {
        self.titleHintIcon = nil;
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
    self.textLabel.text = item.title.localized;
    if (!_item.iconView && item.iconView != _item.iconView) {
        [_item.iconView removeFromSuperview];
        _item.iconView = nil;
    }
    if (![NSString zj_isEmpty:item.icon]) {
        self.imageView.image = [UIImage imageNamed:item.icon];
    } else if (item.iconView && item.iconView != _item.iconView) {
        self.imageView.image = nil;
        item.iconView.zj_left = 15.0f;
        item.iconView.zj_width = item.iconView.zj_height + 10.0f;
        item.iconView.zj_centerY = self.tableViewConfig.rowHeight/2.0;
        [self.contentView addSubview:item.iconView];
    }
    _item = item;
    
    self.accessoryView = self.arrowImgView;
    [self addSubview:self.titleDetailImgView];
    
    if (self.item.subTitle) {
        if (self.item.detailTitle) {
            self.subTitleLabel.text = self.item.detailTitle;
            self.detailTextLabel.text = self.item.subTitle;
        } else {
            self.subTitleLabel.text = self.item.subTitle;
        }
        if (!self.subTitleLabel.superview) [self.contentView addSubview:self.subTitleLabel];
    } else {
        self.detailTextLabel.text = self.item.detailTitle;
    }
    
    // 更新差异化数据
    [self.item updateDiffDataWithCell:self];
    
    if (self.item.isSelection) {
        self.selectionStyle = UITableViewCellSelectionStyleDefault;
    } else {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
}

@end
