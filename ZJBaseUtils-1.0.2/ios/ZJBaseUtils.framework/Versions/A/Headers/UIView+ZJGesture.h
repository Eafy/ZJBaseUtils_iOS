//
//  UIView+ZJGesture.h
//  ZJBaseUtils
//
//  Created by eafy on 2020/8/18.
//  Copyright © 2020 ZJ<lizhijian_21@163.com>. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (ZJGesture)

/// 添加单击手势
/// @param tapAction 手势回调
- (void)zj_addSingleTap:(void(^)(id obj))tapAction;

/// 添加双击手势
/// @param tapAction 手势回调
- (void)zj_addDoubleTap:(void(^)(id obj))tapAction;

/// 添加多次点击手势
/// @param clickCount 点击次数
/// @param tapAction 手势回调
- (void)zj_addManyTimesTap:(NSInteger)clickCount completion:(void(^)(id obj))tapAction;

///  长按手势
/// @param longPressAction 手势回调
- (void)zj_addlongPressTap:(void(^)(id obj))longPressAction;

@end

NS_ASSUME_NONNULL_END
