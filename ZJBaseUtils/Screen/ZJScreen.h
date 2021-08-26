//
//  ZJScreen.h
//  ZJBaseUtils
//
//  Created by eafy on 2020/8/18.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <ZJBaseUtils/ZJSingleton.h>

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

/// 屏幕的Frame
extern CGRect ZJScreenFrame(void);
/// 屏幕高度
extern CGFloat ZJScreenHeight(void);
/// 屏幕宽度
extern CGFloat ZJScreenWidth(void);
/// 状态栏高度（包含安全区域）
extern CGFloat ZJStatusBarHeight(void);
/// 导航栏高度
extern CGFloat ZJNavBarHeight(void);
/// 导航栏+状态栏（包含安全区域）
extern CGFloat ZJNavStatusBarHeight(void);
/// Tabar高度（包含安全区域）
extern CGFloat ZJTabarBarHeight(void);
/// 顶部和底部的安全区域总高度，44.0+34.0
extern CGFloat ZJSafeAreaInsetsHeight(void);
/// 顶部安全区域，24.0
extern CGFloat ZJSafeAreaTop(void);
/// 底部安全区域，34.0
extern CGFloat ZJSafeAreaBottom(void);
/// 屏幕参考机型类型
extern ZJScreenSizeType ZJscreenSizeType(void);
extern BOOL ZJIsIPad(void);
/// 垂直高缩放比，等同于ZJScaleV（注意设置scaleStandard）
extern CGFloat ZJScale(void);
/// 垂直（高）缩放比（注意设置scaleStandard）
extern CGFloat ZJScaleV(void);
/// 水平（宽）缩放比（注意设置scaleStandard）
extern CGFloat ZJScaleH(void);

#ifndef kZJScreen
#define kZJScreen
#define kZJScreenFrame ZJScreen.shared.screenFrame
#define kZJScreenHeight ZJScreen.shared.screenHeight
#define kZJScreenWidth ZJScreen.shared.screenWidth
#define kZJStatusBarHeight ZJScreen.shared.statusBarHeight
#define kZJNavBarHeight ZJScreen.shared.navBarHeight
#define kZJNavStatusBarHeight ZJScreen.shared.navStatusBarHeight
#define kZJTabarBarHeight ZJScreen.shared.tabarBarHeight
#define kZJSafeAreaInsetsHeight ZJScreen.shared.safeAreaInsetsHeight
#define kZJSafeAreaTop ZJScreen.shared.safeAreaTop
#define kZJSafeAreaBottom ZJScreen.shared.safeAreaBottom
#define kZJscreenSizeType ZJScreen.shared.screenSizeType
#define kZJIsIPad ZJScreen.shared.isIPad
extern CGFloat kZJScale;
extern CGFloat kZJScaleV;
extern CGFloat kZJScaleH;
#endif

@interface ZJScreen : NSObject
singleton_h();

@property (nonatomic, assign, readonly) CGRect screenFrame;     //屏幕尺寸
@property (nonatomic, assign, readonly) CGFloat screenHeight;   //屏幕高度
@property (nonatomic, assign, readonly) CGFloat screenWidth;    //屏幕宽度
@property (nonatomic, assign, readonly) CGFloat statusBarHeight;    //状态栏高度
@property (nonatomic, assign, readonly) CGFloat navBarHeight;       //导航栏高度
@property (nonatomic, assign, readonly) CGFloat navStatusBarHeight; //导航栏和状态栏高度
@property (nonatomic, assign, readonly) CGFloat tabarBarHeight;     //TabarBar高度
@property (nonatomic, assign, readonly) CGFloat safeAreaInsetsHeight;  //安全区域底部总高度(44.0+34.0)
@property (nonatomic, assign, readonly) CGFloat safeAreaTop;     //安全区域底部顶部高度=24.0
@property (nonatomic, assign, readonly) CGFloat safeAreaBottom;  //安全区域底部底部高度=34.0

@property (nonatomic, assign, readonly) ZJScreenSizeType screenSizeType;    //屏幕尺寸类型
@property (nonatomic, assign, readonly) BOOL isIPad;    //是否是IPAD

/// 缩放标准类型，默认ZJScreenSizeType8
@property (nonatomic, assign) ZJScreenSizeType scaleStandard;
/// 缩放基准长度（高度）
@property (nonatomic, assign, readonly) CGFloat scaleStandardHeight;
/// 缩放基准长度（宽度）
@property (nonatomic, assign, readonly) CGFloat scaleStandardWidth;

/// 获取当前的KeyWindow窗口（主Window，不一定是最前面的）
+ (UIWindow * _Nullable)keyWindow;

/// 获取当前最前面的Window（仅当frame为全屏时）
+ (UIWindow * _Nullable)frontWindow;

@end

NS_ASSUME_NONNULL_END
