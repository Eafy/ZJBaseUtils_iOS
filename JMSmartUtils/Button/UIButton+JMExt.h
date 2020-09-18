//
//  UIButton.h
//  JMSmartUtils
//
//  Created by 李治健 on 2020/9/14.
//  Copyright © 2020 Jimi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, JMButtonEdgeInsetsStyle) {
    JMButtonEdgeInsetsStyleTop,     // image在上，label在下
    JMButtonEdgeInsetsStyleLeft,    // image在左，label在右
    JMButtonEdgeInsetsStyleBottom,  // image在下，label在上
    JMButtonEdgeInsetsStyleRight    // image在右，label在左
};

@interface UIButton (JMExt)

/// 设置button的titleLabel和imageView的布局样式及间距
/// @param style 布局样式
/// @param space 标题和图片的间距
- (void)jm_layoutWithEdgeInsetsStyle:(JMButtonEdgeInsetsStyle)style imageTitleSpace:(CGFloat)space;

/// 设置button的titleLabel和imageView布局位置
/// @param imgPoint imageView左上角顶点位置
/// @param labelPoint titleLabel左上角顶点位置
- (void)jm_layoutWithEdgeInsets:(CGPoint)imgPoint labelPoint:(CGPoint)labelPoint;

@end

NS_ASSUME_NONNULL_END
