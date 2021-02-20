//
//  ZJButton.h
//  ZJUXKit
//
//  Created by eafy on 2020/7/25.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ZJBaseUtils/UIButton+ZJExt.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, ZJButtonStyle) {
    ZJButtonStyleNormal,    //普通样式
    ZJButtonStyleColor,     //颜色样式
    ZJButtonStyleLine,      //线条框样式
};

typedef NS_ENUM(NSUInteger, ZJButtonColorStyle) {
    ZJButtonColorWhite,  //白色
    ZJButtonColorBlue,    //蓝色
    ZJButtonColorRed,    //红色
};

typedef NS_ENUM(NSUInteger, ZJButtonHeightStyle) {
    ZJButtonHeightNone,     //未定义
    ZJButtonHeightLarge,    //48
    ZJButtonHeightMedium,   //40
    ZJButtonHeightSmall,    //32
};

@interface ZJButton : UIButton

/// 获取按钮
/// @param style 按钮样式
+ (instancetype)buttonWithStyle:(ZJButtonStyle)style;

/// 获取按钮
/// @param style 按钮样式
/// @param frame frame
+ (instancetype)buttonWithStyle:(ZJButtonStyle)style frame:(CGRect)frame;

/// 按钮样式，默认普通
@property (nonatomic,assign) ZJButtonStyle style;
/// 颜色样式
@property (nonatomic,assign) ZJButtonColorStyle colorStyle;
/// 高度样式
@property (nonatomic,assign) ZJButtonHeightStyle heightStyle;

@property (nonatomic,copy) NSString *norTitle;
@property (nonatomic,copy) NSString *selTitle;

@property (nonatomic,strong) UIColor *norTitleColor;
@property (nonatomic,strong) UIColor *highTitleColor;
@property (nonatomic,strong) UIColor *selTitleColor;
@property (nonatomic,strong) UIColor *disTitleColor;

@property (nonatomic,copy) NSString *norImgName;
@property (nonatomic,copy) NSString *highImgName;
@property (nonatomic,copy) NSString *selImgName;
@property (nonatomic,copy) NSString *disImgName;

/// 图片和文字之间的间距，默认系统间距
@property (nonatomic,assign) CGFloat space;

/// 边框线条颜色
@property (nonatomic,strong) UIColor *lineColor;

/// 图片和按钮排布方式，默认Left
@property (nonatomic,assign) ZJButtonEdgeInsetsStyle edgeInsetsStyle;

@end

NS_ASSUME_NONNULL_END
