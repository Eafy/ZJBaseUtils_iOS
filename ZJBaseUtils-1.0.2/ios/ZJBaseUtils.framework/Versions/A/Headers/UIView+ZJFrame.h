//
//  UIView+ZJFrame.h
//  ZJBaseUtils
//
//  Created by eafy on 2020/8/18.
//  Copyright © 2020 ZJ<lizhijian_21@163.com>. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (ZJFrame)

@property (nonatomic) CGFloat zj_width;
@property (nonatomic) CGFloat zj_height;
@property (nonatomic) CGFloat zj_left;
@property (nonatomic) CGFloat zj_top;
@property (nonatomic) CGFloat zj_right;
@property (nonatomic) CGFloat zj_bottom;
@property (nonatomic) CGFloat zj_centerX;
@property (nonatomic) CGFloat zj_centerY;
@property (nonatomic) CGPoint zj_centerXY;
@property (nonatomic) CGPoint zj_origin;
@property (nonatomic) CGSize  zj_size;
@property (readonly) CGPoint zj_bottomLeft;
@property (readonly) CGPoint zj_bottomRight;
@property (readonly) CGPoint zj_topRight;

@end

NS_ASSUME_NONNULL_END
