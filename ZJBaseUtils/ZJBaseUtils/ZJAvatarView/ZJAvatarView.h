//
//  ZJAvatarView.h
//  ZJBaseUtils
//
//  Created by eafy on 2021/1/29.
//  Copyright © 2021 ZJ. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, ZJAvatarViewFrameStyle) {
    ZJAvatarViewFrameStyleSmall = 32,    //32
    ZJAvatarViewFrameStyleMedium = 40,   //40
    ZJAvatarViewFrameStyleLarge = 48,    //48
};

@interface ZJAvatarView : UIImageView

/// Frame样式
@property (nonatomic,assign) ZJAvatarViewFrameStyle frameStyle;

/// 生成头像对象（无frame）
/// @param imgName 头像图片
+ (instancetype)avatarWithName:(NSString *)imgName;

/// 生成头像对象(大头像)
/// @param imgName 头像图片
+ (instancetype)avatarLargeWithName:(NSString *)imgName;

/// 生成头像对象（中头像）
/// @param imgName 头像图片
+ (instancetype)avatarMediumWithName:(NSString *)imgName;

/// 生成头像对象（小头像）
/// @param imgName 头像图片
+ (instancetype)avatarSmallWithName:(NSString *)imgName;

@end

NS_ASSUME_NONNULL_END
