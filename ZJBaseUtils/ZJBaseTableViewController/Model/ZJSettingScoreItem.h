//
//  ZJSettingScoreItem.h
//  ZJBaseUtils
//
//  Created by eafy on 2020/11/23.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import "ZJSettingItem.h"
#import "ZJRatingView.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZJSettingScoreItem : ZJSettingItem

@property (nonatomic,strong) ZJRatingView *scoreStarView;

/// 星星个数（必填）
@property (nonatomic,assign) NSUInteger starCount;

/// 星星之间的间隔（必填）
@property (nonatomic,assign) CGFloat starSpace;

/// 星星分数
@property (nonatomic,assign) CGFloat score;

@property (nonatomic,copy) void(^ _Nullable scoreHandle)(CGFloat score);

@end

NS_ASSUME_NONNULL_END

#pragma mark - 使用方式

//ZJSettingScoreItem *item1 = [[ZJSettingScoreItem alloc] initWithIcon:nil title:@"评分".localized destClass:nil];
//item1.starCount = 5;
//item1.starSpace = 15.0f;
//item1.scoreStarView.defaultImage = [UIImage imageNamed:@"icon_rating_star_normal"]; //不设置使用默认图片
//item1.scoreStarView.frontImage = [UIImage imageNamed:@"icon_rating_star_highlighted"];  //不设置使用默认图片
//item1.scoreStarView.score = 5;
//item1.scoreStarView.scoreHandle = ^(CGFloat score) {
//    NSLog(@"----->%f", score);
//};
//[itemArray addObject:item1];
