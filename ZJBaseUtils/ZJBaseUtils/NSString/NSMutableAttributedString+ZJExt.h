//
//  NSMutableAttributedString+ZJExt.h
//  ZJBaseUtils
//
//  Created by eafy on 2020/12/15.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableAttributedString (ZJExt)

/// 移除特殊颜色
- (void)zj_removeSpecialColor;

@end

NS_ASSUME_NONNULL_END
