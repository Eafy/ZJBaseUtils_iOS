//
//  ZJRatingView.h
//  ZJBaseUtils
//
//  Created by eafy on 2020/11/23.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, ZJRatingStyle) {
    ZJRatingStyleStarHalf,    //半星打分
    ZJRatingStyleStarFull    //满星打分
};

@interface ZJRatingView : UIView

/// 初始化评分视图
/// @param starCount 星星个数
/// @param starSpace 星星间隔
- (instancetype)initWithStarCount:(NSInteger)starCount andSpace:(CGFloat)starSpace;

/// 评分（手动设置的评分不回调）
@property (nonatomic,assign) CGFloat score;

/// 评分回调
@property (nonatomic,copy) void(^ _Nullable scoreHandle)(CGFloat score);

#pragma mark -

/// 星星的默认背景图片
@property (nonatomic,copy) NSString *imgBackgroundName;

/// 画笔模式的填充背景颜色，默认使用grayColor
@property (nonatomic,strong) UIColor *brushBgColor;

/// 画笔模式的填充颜色，默认使用redColor
@property (nonatomic,strong) UIColor *brushColor;

/// 星星的前置图片，不写默认画笔模式，否则使用图片模式
@property (nonatomic,copy) NSString *imgFrontName;

@end

NS_ASSUME_NONNULL_END
