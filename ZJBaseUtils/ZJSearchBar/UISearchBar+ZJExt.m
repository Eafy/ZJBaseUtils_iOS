//
//  UISearchBar+ZJExt.m
//  ZJUXKit
//
//  Created by eafy on 2020/8/6.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import "UISearchBar+ZJExt.h"


@implementation UISearchBar (ZJExt)

- (void)zj_setTextFont:(UIFont *)font {
    [UITextField appearanceWhenContainedInInstancesOfClasses:@[[UISearchBar class]]].font = font;
}

- (void)zj_setTextColor:(UIColor *)textColor {
    [UITextField appearanceWhenContainedInInstancesOfClasses:@[[UISearchBar class]]].textColor = textColor;
}

- (void)zj_setCancelButtonTitle:(NSString *)title {
    [[UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UISearchBar class]]] setTitle:title];
}

- (void)zj_setCancelButtonTitleColor:(UIColor *)textColor font:(UIFont *)font  {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if (textColor) {
        [dic setValue:textColor forKey:NSForegroundColorAttributeName];
    }
    if (font) {
        [dic setValue:font forKey:NSFontAttributeName];
    }
    [[UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UISearchBar class]]] setTitleTextAttributes:dic forState:UIControlStateNormal];
}

@end
