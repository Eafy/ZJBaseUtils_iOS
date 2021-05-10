//
//  NSString+ZJIMGExt.h
//  ZJBaseUtils
//
//  Created by eafy on 2020/9/15.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (ZJIMGExt)

/// 将字符串转换成UIImage
- (UIImage *)zj_toImage;

@end

NS_ASSUME_NONNULL_END
