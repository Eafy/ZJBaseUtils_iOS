//
//  ZJLine.h
//  ZJUXKit
//
//  Created by eafy on 2020/7/24.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, ZJLineStyle) {
    ZJLineStyleSolid,          //实线
    ZJLineStyleDotted,      //虚线
};

@interface ZJLine : UIView

@property (nonatomic, assign) ZJLineStyle style;

- (void)setWidth:(CGFloat)width withSpace:(CGFloat)space;

@end

NS_ASSUME_NONNULL_END
