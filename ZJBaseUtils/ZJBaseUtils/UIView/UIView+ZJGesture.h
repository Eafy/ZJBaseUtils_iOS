//
//  UIView+ZJGesture.h
//  ZJBaseUtils
//
//  Created by eafy on 2020/8/18.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (ZJGesture)

/// 添加单击手势
/// @param tapAction 手势回调
- (void)zj_addSingleTap:(void(^)(UITapGestureRecognizer *obj))tapAction;

/// 添加双击手势
/// @param tapAction 手势回调
- (void)zj_addDoubleTap:(void(^)(UITapGestureRecognizer *obj))tapAction;

/// 添加多次点击手势
/// @param clickCount 点击次数
/// @param tapAction 手势回调
- (void)zj_addManyTimesTap:(NSInteger)clickCount completion:(void(^)(UITapGestureRecognizer *obj))tapAction;

/// 长按手势
/// @param longPressAction 手势回调
- (void)zj_addLongPressTap:(void(^)(UILongPressGestureRecognizer *obj))longPressAction;

/// 左滑手势
/// @param leftSwipAction 手势回调
- (void)zj_addLeftSwip:(void(^)(UISwipeGestureRecognizer *obj))leftSwipAction;

/// 右滑手势
/// @param rightSwipAction 手势回调
- (void)zj_addRightSwip:(void(^)(UISwipeGestureRecognizer *obj))rightSwipAction;

@end

NS_ASSUME_NONNULL_END
