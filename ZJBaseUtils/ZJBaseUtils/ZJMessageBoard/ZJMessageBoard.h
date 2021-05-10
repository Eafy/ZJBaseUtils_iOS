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
/// 是否自动调整宽高，默认NO
@property (nonatomic,assign) BOOL isAutoFrame;

/// 留言内容输入栏
@property (nonatomic,strong) ZJTextView *msgTextView;
/// 默认(12, 8, 12, 16)
@property (nonatomic,assign) UIEdgeInsets msgEdgeInsets;
/// 默认0，即不检测
@property (nonatomic,assign) NSUInteger msgMaxCount;

/// 是否隐藏计数统计
@property (nonatomic,assign) BOOL isHideCount;
/// 统计字数正常颜色，默认：0x8690A9
@property (nonatomic,strong) UIColor *countColor;
/// 统计字数特殊颜色，默认：0xF45C5C
@property (nonatomic,strong) UIColor *countSpecialColor;
/// 统计字数正常字体，常规14
@property (nonatomic,strong) UIFont *countFont;
/// 是否最大值才警告，默认YES
@property (nonatomic,assign) BOOL isCountMaxWarning;

@end

NS_ASSUME_NONNULL_END
