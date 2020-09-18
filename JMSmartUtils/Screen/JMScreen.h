//
//  JMScreen.h
//  JMBaseUtils
//
//  Created by lzj<lizhijian_21@163.com> on 2020/8/18.
//  Copyright © 2020 Jimi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "JMSingleton.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, JMScreenSizeType) {
    JMScreenSizeType4S = 0,    //320*480
    JMScreenSizeType5S,        //320*568
    JMScreenSizeType8,         //375*667
    JMScreenSizeType8P,        //414*736
    JMScreenSizeTypeX,         //375*812
    JMScreenSizeTypeXr,        //414*896
    JMScreenSizeTypeXsMax = JMScreenSizeTypeXr,     //414*896
};

extern CGRect JMScreenFrame(void);
extern CGFloat JMScreenHeight(void);
extern CGFloat JMScreenWidth(void);
extern CGFloat JMStatusBarHeight(void);
extern CGFloat JMNavBarHeight(void);
extern JMScreenSizeType JMscreenSizeType(void);
extern BOOL JMIsIPad(void);
extern CGFloat JMScale(void);   //针对于8的缩放比

@interface JMScreen : NSObject
singleton_h();

@property (nonatomic, assign, readonly) CGRect screenFrame;     //屏幕尺寸
@property (nonatomic, assign, readonly) CGFloat screenHeight;   //屏幕高度
@property (nonatomic, assign, readonly) CGFloat screenWidth;    //屏幕宽度
@property (nonatomic, assign, readonly) CGFloat statusBarHeight;    //状态栏高度
@property (nonatomic, assign, readonly) CGFloat navBarHeight;       //导航栏高度

@property (nonatomic, assign, readonly) JMScreenSizeType screenSizeType;    //屏幕尺寸类型
@property (nonatomic, assign, readonly) BOOL isIPad;    //是否是IPAD

#pragma mark -

+ (CGRect)screenFrame;

+ (CGFloat)height;

+ (CGFloat)width;

+ (CGFloat)statusBarHeight;

+ (CGFloat)navBarHeight;

+ (JMScreenSizeType)screenSizeType;

+ (BOOL)isIPad;

@end

NS_ASSUME_NONNULL_END
