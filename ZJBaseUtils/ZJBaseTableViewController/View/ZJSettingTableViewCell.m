//
//  ZJSettingTableViewCell.m
//  ZJBaseUtils
//
//  Created by eafy on 2020/9/14.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import <ZJBaseUtils/ZJSettingTableViewCellExt.h>
#import <ZJBaseUtils/ZJBaseTVConfig.h>
#import <ZJBaseUtils/UIColor+ZJExt.h>
#import <ZJBaseUtils/ZJSystem.h>
#import <ZJBaseUtils/ZJScreen.h>
#import <ZJBaseUtils/UIView+ZJFrame.h>
#import <ZJBaseUtils/NSString+ZJExt.h>
#import <ZJBaseUtils/ZJLocalization.h>
#import <ZJBaseUtils/UIImageView+ZJExt.h>
#import <ZJBaseUtils/UIView+ZJExt.h>

@interface ZJSettingTableViewCell()

/// 表单全局配置参数
@property (nonatomic,strong) ZJBaseTVConfig *tableViewConfig;

/// 右边箭头视图
@property (nonatomic, strong) UIImageView *arrowImgView;
/// 标题详情图片(new)
@property (nonatomic, strong) UIImageView *titleDetailImgView;
/// 背景视图
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIView *multiArrowView;
@property (nonatomic, strong) UIView *lineView;

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
    
    cell.isShowLine = tableView.separatorStyle == UITableViewCellSeparatorStyleNone;
    cell.tableViewConfig = config;
    cell.multiArrowView = nil;
    cell.tag = item.tag;
    cell.cornerType = 0;
    cell.item = item;
    cell.accessoryType = item.accessoryType;
    
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
    
    if (tableViewConfig.cornerRadius > 0) { //圆角模式
        self.backgroundColor = [UIColor clearColor];
    } else {
        if (self.tableViewConfig.cellBgColor) self.backgroundColor = self.tableViewConfig.cellBgColor;
    }
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
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    if (self.tableViewConfig.cornerRadius > 0) {
        self.bgView.frame = CGRectMake(self.tableViewConfig.marginLeft, 0, self.zj_width-self.tableViewConfig.marginLeft-self.tableViewConfig.marginRight, self.zj_height);
        if (self.cornerType != 0) {
            [self.bgView zj_cornerWithRadii:CGSizeMake(self.tableViewConfig.cornerRadius, self.tableViewConfig.cornerRadius) rectCorner:self.cornerType];
        }
    }
    
    CGFloat detailTextSpace = 0;
    if (self.accessoryView || self.accessoryType != UITableViewCellAccessoryNone) {
        detailTextSpace = self.tableViewConfig.arrowLeftSpace;
    } else {
        detailTextSpace = self.tableViewConfig.marginRight;
    }
    
    if (self.item.iconView) {   //设置icon位置
        self.item.iconView.zj_left = self.tableViewConfig.iconLeftSpace + self.tableViewConfig.marginLeft;
        self.textLabel.zj_left = self.item.iconView.zj_right + self.tableViewConfig.iconRightSpace;
    } else if (self.imageView.image) {
        self.imageView.zj_left = self.tableViewConfig.iconLeftSpace + self.tableViewConfig.marginLeft;
        self.textLabel.zj_left = self.imageView.zj_right + self.tableViewConfig.iconRightSpace;
    } else {
        self.textLabel.zj_left = self.tableViewConfig.marginLeft + self.tableViewConfig.iconLeftSpace;
    }
    
    if (self.accessoryView) {
        self.accessoryView.zj_right = self.zj_width - self.tableViewConfig.marginRight - self.tableViewConfig.arrowRightSpace;
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
            CGFloat preRight = self.textLabel.zj_left + (self.textLabel.zj_width > self.detailTextLabel.zj_width ? self.textLabel.zj_width : self.detailTextLabel.zj_width) + self.tableViewConfig.iconRightSpace;  //计算子标题坐标   //适配iOS 15，不能使用self.detailTextLabel.zj_right，位置好像还没调整
            self.subTitleLabel.zj_left = preRight;
            if (self.accessoryView) {
                self.subTitleLabel.zj_width = self.accessoryView.zj_left - preRight - detailTextSpace;
            } else {
                self.subTitleLabel.zj_width = self.zj_width - self.tableViewConfig.marginRight - self.tableViewConfig.arrowRightSpace - preRight;
            }
            self.detailTextLabel.zj_left = self.textLabel.zj_left;
        } else {
            self.subTitleLabel.zj_left = self.textLabel.zj_left;
            self.subTitleLabel.textAlignment = NSTextAlignmentLeft;
            [self.subTitleLabel sizeToFit];
        }
    } else {
        [self.subTitleLabel removeFromSuperview];
        self.textLabel.zj_centerY = self.contentView.zj_centerY;
        if (self.accessoryView) {
            self.detailTextLabel.zj_right = self.accessoryView.zj_left - detailTextSpace;
        } else {
            self.detailTextLabel.zj_right = self.contentView.zj_right - detailTextSpace - (self.accessoryType != UITableViewCellAccessoryNone ? 0 : self.tableViewConfig.arrowRightSpace);
        }
        self.detailTextLabel.zj_centerY = self.contentView.zj_centerY;
    }
    
    //移除不相同的左侧多视图模式
    if (_multiArrowView && _multiArrowView != self.item.multiArrowView) {
        [_multiArrowView removeFromSuperview];
        _multiArrowView = nil;
    }
    
    //添加左侧多视图模式
    if (self.item.multiArrowView && !self.item.multiArrowView.superview) {
        _multiArrowView = self.item.multiArrowView;
        [self.contentView addSubview:_multiArrowView];
        
        if (self.multiArrowView.zj_height > self.zj_height) {
            self.multiArrowView.zj_height = self.zj_height - 2;
        }
        self.multiArrowView.zj_centerY = self.contentView.zj_centerY;
        self.multiArrowView.zj_right = self.accessoryView ? self.accessoryView.zj_left - self.tableViewConfig.arrowLeftSpace : self.contentView.zj_right - self.tableViewConfig.marginRight - self.tableViewConfig.arrowLeftSpace;
        if (!self.accessoryView && self.accessoryType != UITableViewCellAccessoryNone) {
            self.multiArrowView.zj_right = self.contentView.zj_right - self.tableViewConfig.arrowLeftSpace;
        }
    }
    
    if (!self.item.detailTitle && !self.accessoryView && self.accessoryType == UITableViewCellAccessoryNone && !self.item.multiArrowView) {
        self.textLabel.zj_width = self.contentView.zj_width - self.textLabel.zj_left - self.tableViewConfig.marginRight;
    }
    
    if (self.isShowLine) {
        self.lineView.zj_left = self.tableViewConfig.iconLeftSpace + self.tableViewConfig.marginLeft;
        self.lineView.zj_width = self.zj_width - self.tableViewConfig.marginRight - self.tableViewConfig.arrowRightSpace - self.lineView.zj_left;
        self.lineView.zj_top = self.contentView.zj_height - self.lineView.zj_height;
    } else if (_lineView) {
        [_lineView removeFromSuperview];
        _lineView = nil;
    }
    
    if (_titleDetailImgView) {
        self.titleDetailImgView.zj_left = self.textLabel.zj_right + self.tableViewConfig.iconRightSpace;
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
    } else if (self.item.arrowIcon || self.tableViewConfig.arrowIconName) {
        NSString *iconName = self.item.arrowIcon ? self.item.arrowIcon : self.tableViewConfig.arrowIconName;
        if (![NSString zj_isEmpty:iconName]) {
            if (![iconName isEqualToString:self.arrowIcon]) {
                if (_arrowImgView) [_arrowImgView removeFromSuperview];
                self.arrowIcon = iconName;
                UIImage *arrowImg = [UIImage imageNamed:iconName];
                if (arrowImg) {
                    _arrowImgView = [[UIImageView alloc] initWithImage:arrowImg];
                }
            }
        } else {
            if (_arrowImgView) {
                [_arrowImgView removeFromSuperview];
                _arrowImgView = nil;
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

- (UIView *)bgView
{
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = self.tableViewConfig.cellBgColor;
        [self.contentView insertSubview:_bgView atIndex:0];
    }
    return _bgView;
}

- (UIView *)lineView
{
    if (!_lineView && self.isShowLine) {
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, self.tableViewConfig.lineHeight)];
        _lineView.backgroundColor = self.tableViewConfig.lineColor;
        [self.contentView addSubview:_lineView];
    }
    return _lineView;
}

#pragma mark - 设置cell数据

- (void)setItem:(ZJSettingItem *)item
{
    self.textLabel.text = item.title.localized;
    if (item.titleAttributed) {
        self.textLabel.attributedText = item.titleAttributed;
    }
    if (_item.iconView && item.iconView != _item.iconView) {
        if (_item.iconView.superview == self) {
            [_item.iconView removeFromSuperview];
        }
    }
    if (![NSString zj_isEmpty:item.icon]) {
        self.imageView.image = [UIImage imageNamed:item.icon];
    } else if (item.iconView && item.iconView != _item.iconView) {
        self.imageView.image = nil;
        item.iconView.zj_left = 15.0f;
        if (item.iconView.zj_height > self.tableViewConfig.rowHeight) {
            item.iconView.zj_height = self.tableViewConfig.rowHeight;
        }
        item.iconView.zj_centerY = self.tableViewConfig.rowHeight/2.0;
        [self.contentView addSubview:item.iconView];
    } else if (self.imageView.image) {
        self.imageView.image = nil;
    }
    if (_item && _item.customView) {
        [_item.customView removeFromSuperview];
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
    [self.textLabel sizeToFit];
    [self.detailTextLabel sizeToFit];
    if (_subTitleLabel) {
        [self.subTitleLabel sizeToFit];
    }
    [self.item updateDiffDataWithCell:self];
    [self.item updateDiffConfigWithCell:self config:self.tableViewConfig];
    
    self.selectionStyle = self.item.selectionStyle;
    if (self.item.subTitle && self.item.detailTitle) {
        if (self.tableViewConfig.cellSubTitleColor) [self.detailTextLabel setTextColor:self.tableViewConfig.cellSubTitleColor];
        if (self.tableViewConfig.cellSubTitleFont) [self.detailTextLabel setFont:self.tableViewConfig.cellSubTitleFont];
        if (self.tableViewConfig.cellDetailTitleColor) [self.subTitleLabel setTextColor:self.tableViewConfig.cellDetailTitleColor];
        if (self.tableViewConfig.cellSubTitleFont) [self.subTitleLabel setFont:self.tableViewConfig.cellDetailTitleFont];
    }
    
    if (item.customView) {
        [self.contentView addSubview:item.customView];
    }
}

- (void)setIsShowLine:(BOOL)isShowLine
{
    _isShowLine = isShowLine;
}

@end
