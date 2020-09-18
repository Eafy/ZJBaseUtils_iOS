//
//  UIView+JMGesture.h
//  JMBaseUtils
//
//  Created by lzj<lizhijian_21@163.com> on 2020/8/18.
//  Copyright © 2020 Jimi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (JMGesture)

/// 添加单击手势
/// @param tapAction 手势回调
- (void)jm_addSingleTap:(void(^)(id obj))tapAction;

/// 添加双击手势
/// @param tapAction 手势回调
- (void)jm_addDoubleTap:(void(^)(id obj))tapAction;

/// 添加多次点击手势
/// @param clickCount 点击次数
/// @param tapAction 手势回调
- (void)jm_addManyTimesTap:(NSInteger)clickCount completion:(void(^)(id obj))tapAction;

///  长按手势
/// @param longPressAction 手势回调
- (void)jm_addlongPressTap:(void(^)(id obj))longPressAction;

@end

NS_ASSUME_NONNULL_END
