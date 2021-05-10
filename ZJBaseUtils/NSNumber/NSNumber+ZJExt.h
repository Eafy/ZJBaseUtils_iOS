//
//  NSNumber+ZJExt.h
//  ZJBaseUtils
//
//  Created by eafy on 2021/4/9.
//  Copyright © 2021 ZJ. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSNumber (ZJExt)

/// Float类型数据除法取余
/// @param value 被除数(原值)
/// @param divisor 除数(单倍值)
/// @return 剩余的余数
+ (CGFloat)remainderWithValue:(CGFloat)value divisor:(CGFloat)divisor;

@end

NS_ASSUME_NONNULL_END
