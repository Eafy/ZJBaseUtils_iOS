//
//  ZJRatingStarView.h
//  ZJBaseUtils
//
//  Created by eafy on 2020/11/23.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZJRatingStarView : UIView

/// 星星的默认图片
@property (nonatomic,copy) NSString *starImgName;

/// 初始化✨视图
/// @param starCount 星星个数
/// @param starSpace 星星间隔
- (instancetype)initWithStarCount:(NSInteger)starCount andSpace:(CGFloat)starSpace;

/// 更新布局
- (void)updateViewConstrains;

/// 转换坐标
/// @param touchPoint 触摸和点击的坐标
/// @param completion 回调
- (CGPoint)transformPointWithTouchPoint:(CGPoint)touchPoint completion:(void(^)(CGPoint transformPoint, CGFloat score))completion;

@end

NS_ASSUME_NONNULL_END
