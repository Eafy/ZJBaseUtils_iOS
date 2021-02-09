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

@interface ZJSettingScoreItem ()

@property (nonatomic,assign) CGFloat scoreT;

@end

@implementation ZJSettingScoreItem
@dynamic score;

- (ZJSettingItemType)type {
    return ZJSettingItemTypeRatingStar;
}

- (void)defaultData {
    _starSpace = 16;
}

- (UIView *)accessoryView {
    if (super.accessoryView.tag != self.type) {
        super.accessoryView = self.scoreStarView;
        super.accessoryView.tag = self.type;
    }
    
    return super.accessoryView;
}

- (ZJRatingView *)scoreStarView {
    if (!_scoreStarView) {
        _scoreStarView = [[ZJRatingView alloc] initWithStarCount:5 andSpace:15.0];
        
        __weak typeof(self) weakSelf = self;
        _scoreStarView.scoreHandle = ^(CGFloat score) {
            weakSelf.scoreT = score;
            if (weakSelf.scoreHandle) {
                weakSelf.scoreHandle(score);
            }
        };
        _scoreStarView.score = _scoreT;
    }
    
    return _scoreStarView;
}

- (void)setStarCount:(NSUInteger)starCount {
    _starCount = starCount;
    if (_scoreStarView) {
        _scoreStarView = nil;
    }
}

- (void)setStarSpace:(CGFloat)starSpace {
    _starSpace = starSpace;
    if (_scoreStarView) {
        _scoreStarView = nil;
    }
}

- (void)setScore:(CGFloat)score {
    _scoreT = score;
    if (_scoreStarView) {
        _scoreStarView.score = score;
    }
}

- (CGFloat)score {
    if (_scoreStarView) {
        return _scoreStarView.score;
    }
    return _scoreT;
}

- (void)setScoreHandle:(void (^)(CGFloat))scoreHandle {
    _scoreHandle = scoreHandle;
    if (_scoreStarView) {
        _scoreStarView.scoreHandle = scoreHandle;
    }
}

#pragma mark - 重载差异化

- (void)updateDiffDataWithCell:(ZJSettingTableViewCell *)cell
{
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
