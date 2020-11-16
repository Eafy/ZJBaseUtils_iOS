//
//  ZJBaseTabBarTopLineConfig.h
//  ZJBaseUtils
//
//  Created by eafy on 2020/11/16.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
/// 顶部线条样式
typedef NS_ENUM(NSInteger, ZJBTBConfigTopLineType) {
    ZJBTBConfigTopLineTypeNormal,         //无效果（系统默认）
    ZJBTBConfigTopLineTypeClear,          //清除
    ZJBTBConfigTopLineTypeColor,          //自定义颜色
    ZJBTBConfigTopLineTypeShadow,         //自定义阴影
};

@interface ZJBaseTabBarTopLineConfig : NSObject

/// tabBar顶部线条样式，默认：ZJBTBConfigTopLineTypeColor
@property (nonatomic, assign) ZJBTBConfigTopLineType type;

/// 线条宽度，默认0.5，仅ZJBTBConfigTopLineTypeColor生效
@property (nonatomic, assign) CGFloat lineWidth;

/// 颜色，默认：lightGrayColor
@property (nonatomic, strong) UIColor *shadowColor;

/// 透明度，默认0，仅ZJBTBConfigTopLineTypeShadow生效
@property (nonatomic, assign) CGFloat shadowOpacity;

/// 偏移度，默认：(0, -2)，仅ZJBTBConfigTopLineTypeShadow生效
@property (nonatomic, assign) CGSize shadowOffset;

/// 模糊半径，默认：3
@property (nonatomic, assign) CGFloat shadowRadius;

/// 阴影线路，仅ZJBTBConfigTopLineTypeShadow生效
@property (nonatomic, assign) CGPathRef shadowPath;

@end

NS_ASSUME_NONNULL_END
