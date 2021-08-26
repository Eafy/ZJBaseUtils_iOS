//
//  ZJRedDotView.m
//  ZJBaseUtils
//
//  Created by eafy on 2020/8/13.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import <ZJBaseUtils/ZJRedDotView.h>
#import <ZJBaseUtils/NSString+ZJExt.h>
#import <ZJBaseUtils/UIView+ZJFrame.h>
#import <ZJBaseUtils/UIColor+ZJExt.h>

@interface ZJRedDotView ()

@end

@implementation ZJRedDotView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.font = [UIFont systemFontOfSize:12];
        self.textColor = [UIColor whiteColor];
        self.textAlignment = NSTextAlignmentCenter;
        self.backgroundColor = ZJColorFromRGB(0xF45C5C);
        self.layer.cornerRadius = frame.size.height/2;
        self.layer.masksToBounds = YES;
    }
    return self;
}

- (void)setText:(NSString *)text {
    super.text = text;
    
    if (self.isAutoFrame) {
        CGSize size = [self.text zj_sizeWithFont:self.font maxSize:CGSizeZero];
        if (size.height >= self.zj_height) {
            size.height = size.height + 2;
        } else {
            size.height = self.zj_height;
        }
        self.layer.cornerRadius = size.height/2;
        self.layer.masksToBounds = YES;
        
        if (size.width + self.layer.cornerRadius > self.zj_width) {
            size.width += self.layer.cornerRadius;
        }
        if (size.width < size.height) {
            size.width = size.height;
        }
        
        self.zj_size = size;
    }
}

@end
