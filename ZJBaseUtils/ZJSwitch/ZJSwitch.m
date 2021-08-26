//
//  ZJSwitch.m
//  ZJBaseUtils
//
//  Created by eafy on 2020/7/25.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import <ZJBaseUtils/ZJSwitch.h>
#import <ZJBaseUtils/UIColor+ZJExt.h>

@implementation ZJSwitch

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {

        self.thumbTintColor = ZJColorFromRGB(0xFFFFFF);
        self.tintColor = ZJColorFromRGB(0xBCC4D4);
        self.onTintColor = ZJColorFromRGB(0x3D7DFF);
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)setEnabled:(BOOL)enabled
{
    [super setEnabled:enabled];
    if (!enabled) {
        self.thumbTintColor = ZJColorFromRGB(0xFFFFFF);
        self.tintColor = ZJColorFromRGB(0xDCE0E8);
    } else {
        self.thumbTintColor = ZJColorFromRGB(0xFFFFFF);
        self.tintColor = ZJColorFromRGB(0xBCC4D4);
    }
}

@end
