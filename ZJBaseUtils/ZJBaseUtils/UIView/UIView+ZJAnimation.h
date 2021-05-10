//
//  UIView+ZJAnimation.h
//  ZJBaseUtils
//
//  Created by eafy on 2020/12/22.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (ZJAnimation)

/// 添加自动旋转动画
- (CABasicAnimation *)zj_addLoopRotateAnimation;

/// 删除自动旋转动画
- (void)zj_removeLoopRotateAnimation;

@end

NS_ASSUME_NONNULL_END
