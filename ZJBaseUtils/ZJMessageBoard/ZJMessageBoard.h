//
//  ZJMessageBoard.h
//  ZJBaseUtils
//
//  Created by eafy on 2020/12/14.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZJTextView.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZJMessageBoard : UIView

/// 留言标签
@property (nonatomic,strong) UILabel *titleLB;
/// 默认(18, 16, 0, 16)
@property (nonatomic,assign) UIEdgeInsets titleEdgeInsets;

/// 留言内容输入栏
@property (nonatomic,strong) ZJTextView *msgTextView;
/// 默认(12, 8, 12, 16)
@property (nonatomic,assign) UIEdgeInsets msgEdgeInsets;
/// 默认0，即不检测
@property (nonatomic,assign) NSUInteger msgMaxCount;

/// 是否隐藏计数统计
@property (nonatomic,assign) BOOL isHideCount;

@end

NS_ASSUME_NONNULL_END
