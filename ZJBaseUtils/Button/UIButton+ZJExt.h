//
//  UIButton+ZJExt.h
//  ZJBaseUtils
//
//  Created by eafy on 2020/9/14.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, ZJButtonEdgeInsetsStyle) {
    ZJButtonEdgeInsetsStyleTop,     // image在上，label在下
    ZJButtonEdgeInsetsStyleLeft,    // image在左，label在右
    ZJButtonEdgeInsetsStyleBottom,  // image在下，label在上
    ZJButtonEdgeInsetsStyleRight    // image在右，label在左
};

@interface UIButton (ZJExt)

/// 设置button的titleLabel和imageView的布局样式及间距
/// @param style 布局样式
/// @param space 标题和图片的间距
- (void)zj_layoutWithEdgeInsetsStyle:(ZJButtonEdgeInsetsStyle)style imageTitleSpace:(CGFloat)space;

/// 设置button的titleLabel和imageView布局位置
/// @param imgPoint imageView左上角顶点位置
/// @param labelPoint titleLabel左上角顶点位置
- (void)zj_layoutWithEdgeInsets:(CGPoint)imgPoint labelPoint:(CGPoint)labelPoint;

@end

NS_ASSUME_NONNULL_END
