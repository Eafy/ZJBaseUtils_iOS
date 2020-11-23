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

@end

NS_ASSUME_NONNULL_END
