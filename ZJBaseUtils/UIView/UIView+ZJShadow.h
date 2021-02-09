//
//  UIView+ZJShadow.h
//  ZJBaseUtils
//
//  Created by eafy on 2020/12/9.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (ZJShadow)

/// 设置阴影
/// @param shadowOpacity 透明度
/// @param shadowRadius 阴影半径
/// @param cornerRadius 剪辑半径
- (void)zj_shadowWithOpacity:(float)shadowOpacity shadowRadius:(CGFloat)shadowRadius andCornerRadius:(CGFloat)cornerRadius;

@end

NS_ASSUME_NONNULL_END
