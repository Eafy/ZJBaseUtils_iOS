//
//  ZJSettingScoreItem.m
//  ZJBaseUtils
//
//  Created by eafy on 2020/11/23.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import "ZJSettingScoreItem.h"
#import "UIView+ZJFrame.h"
#import "ZJSettingTableViewCellExt.h"

@implementation ZJSettingScoreItem

- (ZJSettingItemType)type
{
    return ZJSettingItemTypeRatingStar;
}

- (UIView *)accessoryView
{
    if (super.accessoryView.tag != self.type) {
        super.accessoryView = self.scoreStarView;
        super.accessoryView.tag = self.type;
    }
    
    return super.accessoryView;
}

- (ZJRatingView *)scoreStarView
{
    if (!_scoreStarView) {
        _scoreStarView = [[ZJRatingView alloc] initWithStarCount:5 andSpace:15.0];
    }
    
    return _scoreStarView;
}

- (void)setStarCount:(NSUInteger)starCount
{
    _starCount = starCount;
    if (_scoreStarView) {
        _scoreStarView = nil;
    }
}

- (void)setStarSpace:(CGFloat)starSpace
{
    _starSpace = starSpace;
    if (_scoreStarView) {
        _scoreStarView = nil;
    }
}

#pragma mark - 重载差异化

- (void)updateDiffDataWithCell:(ZJSettingTableViewCell *)cell
{
    [cell.textLabel sizeToFit];
    if (self.scoreStarView.zj_width == 0) {
        CGFloat width = self.scoreStarView.defaultImage.size.width*self.starCount + self.starSpace * (self.starCount - 1);
        self.scoreStarView.zj_width = width;
    }
    self.scoreStarView.zj_height = cell.zj_height/3*2;
}

- (void)updateDiffConfigWithCell:(ZJSettingTableViewCell *)cell config:(ZJBaseTVConfig *)config
{
 
}

@end
