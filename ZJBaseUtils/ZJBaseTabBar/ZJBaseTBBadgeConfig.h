//
//  ZJBaseTBBadgeConfig.h
//  ZJBaseUtils
//
//  Created by eafy on 2020/11/14.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// 动画类型
typedef NS_ENUM(NSInteger, ZJBTBConfigBadgeAnimType) {
    ZJBTBConfigBadgeAnimTypeNormal,     //无动画
    ZJBTBConfigBadgeAnimTypeShake,      //抖动动画
    ZJBTBConfigBadgeAnimTypeOpacity,    //透明过渡动画
    ZJBTBConfigBadgeAnimTypeScale,      //缩放动画
};

@interface ZJBaseTBBadgeConfig : NSObject

/// badge动画 ，默认：无动画
@property (nonatomic, assign) ZJBTBConfigBadgeAnimType badgeAnimType;
/// badge字体验证，默认：黑色
@property (nonatomic, strong) UIColor *badgeTextColor;
/// badge背景颜色，默认： #FF4040
@property (nonatomic, strong) UIColor *badgeBackgroundColor;
/// badge大小，仅layout后才生效
@property (nonatomic, assign) CGSize badgeSize;
/// badge偏移，仅layout后才生效
@property (nonatomic, assign) CGPoint badgeOffset;
/// badge圆角大小，仅layout后才生效
@property (nonatomic, assign) CGFloat badgeRadius;

@end

NS_ASSUME_NONNULL_END
