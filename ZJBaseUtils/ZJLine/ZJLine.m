//
//  ZJLine.m
//  ZJBaseUtils
//
//  Created by eafy on 2020/7/24.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import <ZJBaseUtils/ZJLine.h>
#import <ZJBaseUtils/UIColor+ZJExt.h>
#import <ZJBaseUtils/UIView+ZJExt.h>

@interface ZJLine ()

@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat space;
@property (nonatomic, strong) UIColor *bgColor;

@end

@implementation ZJLine

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = ZJColorFromRGB(0xDCE0E8);
        self.bgColor = self.backgroundColor;
        self.width = 8;
        self.space = 4;
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (self.style == ZJLineStyleDotted) {
        if (self.bounds.size.height > 0 && self.bounds.size.width > 0) {
            [self zj_dottedLineWithStartPoint:CGPointMake(0, 0) endPoint:CGPointMake(self.bounds.size.width, self.bounds.size.height) color:self.bgColor size:CGSizeMake(self.width, self.bounds.size.height) space:self.space];
        }        
    }
}

- (void)setStyle:(ZJLineStyle)style {
    _style = style;
    
    [self layoutIfNeeded];
}

- (void)setWidth:(CGFloat)width withSpace:(CGFloat)space {
    _width = width;
    _space = space;
    [self layoutIfNeeded];
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
    super.backgroundColor = backgroundColor;
    if (backgroundColor != [UIColor clearColor]) {
        _bgColor = backgroundColor;
    }
}

@end
