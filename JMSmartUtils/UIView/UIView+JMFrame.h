//
//  UIView+JMFrame.h
//  JMBaseUtils
//
//  Created by lzj<lizhijian_21@163.com> on 2020/8/18.
//  Copyright © 2020 Jimi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (JMFrame)

@property (nonatomic) CGFloat jm_width;
@property (nonatomic) CGFloat jm_height;
@property (nonatomic) CGFloat jm_left;
@property (nonatomic) CGFloat jm_top;
@property (nonatomic) CGFloat jm_right;
@property (nonatomic) CGFloat jm_bottom;
@property (nonatomic) CGFloat jm_centerX;
@property (nonatomic) CGFloat jm_centerY;
@property (nonatomic) CGPoint jm_origin;
@property (nonatomic) CGSize  jm_size;
@property (readonly) CGPoint jm_bottomLeft;
@property (readonly) CGPoint jm_bottomRight;
@property (readonly) CGPoint jm_topRight;

@end

NS_ASSUME_NONNULL_END
