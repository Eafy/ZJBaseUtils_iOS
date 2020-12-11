//
//  ZJTextView.h
//  ZJBaseUtils
//
//  Created by eafy on 2020/12/9.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZJTextView : UITextView

/// 占位文字
/// #不能使用placeholder，否则和IQKeyboardManager冲突
@property (nonatomic,strong) NSAttributedString * _Nullable placeholderString;
/// 占位文字左边间距，默认8.0
@property (nonatomic,assign) CGFloat placeLeftSpace;
/// 占位文字顶部间距，默认8.0
@property (nonatomic,assign) CGFloat placeTopSpace;

/// 设置占位文字的属性
/// @param str 字符串
/// @param color 颜色
/// @param font 字体
- (void)placeholderWithText:(NSString *)str color:(UIColor * _Nullable)color font:(UIFont * _Nullable)font;

@end

NS_ASSUME_NONNULL_END
