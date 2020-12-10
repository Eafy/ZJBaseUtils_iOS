//
//  ZJAlertAction.m
//  ZJBaseUtils
//
//  Created by eafy on 2020/12/10.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import "ZJAlertAction.h"
#import "UIColor+ZJExt.h"
#import "UIView+ZJExt.h"

@implementation ZJAlertAction

#pragma mark -

- (void)setStyle:(UIAlertActionStyle)style
{
    _style = style;
    if (style == UIAlertActionStyleDefault) {
        self.titleColor = ZJColorFromRGB(0x3D7DFF);
        self.titleFont = [UIFont boldSystemFontOfSize:16];
    } else if (style == UIAlertActionStyleCancel) {
        self.titleColor = ZJColorFromRGB(0x5A6482);
        self.titleFont = [UIFont systemFontOfSize:16];
    } else {
        self.titleColor = ZJColorFromRGB(0xF45C5C);
        self.titleFont = [UIFont systemFontOfSize:16];
    }
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    [self setTitle:title forState:UIControlStateNormal];
}

- (void)setTitleColor:(UIColor *)titleColor
{
    _titleColor = titleColor;
    [self setTitleColor:titleColor forState:UIControlStateNormal];
}

- (void)setTitleFont:(UIFont *)titleFont
{
    _titleFont = titleFont;
    self.titleLabel.font = titleFont;
}

#pragma mark -

+ (instancetype)action {
    return [ZJAlertAction actionWithTitle:nil style:UIAlertActionStyleDefault handler:nil];
}

+ (instancetype)actionWithTitle:(nullable NSString *)title style:(UIAlertActionStyle)style handler:(void (^ __nullable)(ZJAlertAction *action))handler {
    ZJAlertAction *btn = [[ZJAlertAction alloc] init];
    btn.title = title;
    btn.style = style;
    btn.handler = handler;
    return btn;
}

+ (instancetype)actionDefaultWithTitle:(nullable NSString *)title handler:(void (^ __nullable)(ZJAlertAction *action))handler {
    return [ZJAlertAction actionWithTitle:title style:UIAlertActionStyleDefault handler:handler];
}

+ (instancetype)actionCancelWithTitle:(nullable NSString *)title handler:(void (^ __nullable)(ZJAlertAction *action))handler {
    return [ZJAlertAction actionWithTitle:title style:UIAlertActionStyleCancel handler:handler];
}

+ (instancetype)actionDestructiveWithTitle:(nullable NSString *)title handler:(void (^ __nullable)(ZJAlertAction *action))handler {
    return [ZJAlertAction actionWithTitle:title style:UIAlertActionStyleDestructive handler:handler];
}

@end
