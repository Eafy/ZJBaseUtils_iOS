//
//  UISearchBar+ZJExt.h
//  ZJBaseUtils
//
//  Created by eafy on 2020/8/6.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UISearchBar (ZJExt)

- (void)zj_setTextFont:(UIFont *)font;

- (void)zj_setTextColor:(UIColor *)textColor;

- (void)zj_setCancelButtonTitle:(NSString *)title;

- (void)zj_setCancelButtonTitleColor:(UIColor *)textColor font:(UIFont *)font;

@end

NS_ASSUME_NONNULL_END
