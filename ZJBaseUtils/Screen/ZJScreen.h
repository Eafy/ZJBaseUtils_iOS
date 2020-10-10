//
//  ZJScreen.h
//  ZJBaseUtils
//
//  Created by eafy on 2020/8/18.
//  Copyright © 2020 ZJ<lizhijian_21@163.com>. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ZJSingleton.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, ZJScreenSizeType) {
    ZJScreenSizeType4S = 0,    //320*480
    ZJScreenSizeType5S,        //320*568
    ZJScreenSizeType8,         //375*667
    ZJScreenSizeType8P,        //414*736
    ZJScreenSizeTypeX,         //375*812
    ZJScreenSizeTypeXr,        //414*896
    ZJScreenSizeTypeXsMax = ZJScreenSizeTypeXr,     //414*896
};

extern CGRect ZJScreenFrame(void);
extern CGFloat ZJScreenHeight(void);
extern CGFloat ZJScreenWidth(void);
extern CGFloat ZJStatusBarHeight(void);
extern CGFloat ZJNavBarHeight(void);
extern CGFloat ZJSafeAreaInsetsHeight(void);
extern ZJScreenSizeType ZJscreenSizeType(void);
extern BOOL ZJIsIPad(void);
extern CGFloat ZJScale(void);   //针对于8的缩放比

@interface ZJScreen : NSObject
singleton_h();

@property (nonatomic, assign, readonly) CGRect screenFrame;     //屏幕尺寸
@property (nonatomic, assign, readonly) CGFloat screenHeight;   //屏幕高度
@property (nonatomic, assign, readonly) CGFloat screenWidth;    //屏幕宽度
@property (nonatomic, assign, readonly) CGFloat statusBarHeight;    //状态栏高度
@property (nonatomic, assign, readonly) CGFloat navBarHeight;       //导航栏高度
@property (nonatomic, assign, readonly) CGFloat safeAreaInsetsHeight;       //安全区域底部高度

@property (nonatomic, assign, readonly) ZJScreenSizeType screenSizeType;    //屏幕尺寸类型
@property (nonatomic, assign, readonly) BOOL isIPad;    //是否是IPAD

#pragma mark -

+ (CGRect)screenFrame;

+ (CGFloat)screenWidth;

+ (CGFloat)screenHeight;

+ (CGFloat)statusBarHeight;

+ (CGFloat)navBarHeight;

+ (CGFloat)safeAreaInsetsHeight;

+ (ZJScreenSizeType)screenSizeType;

+ (BOOL)isIPad;

@end

NS_ASSUME_NONNULL_END
