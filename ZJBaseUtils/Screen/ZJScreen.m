//
//  ZJScreen.m
//  ZJBaseUtils
//
//  Created by eafy on 2020/8/18.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import "ZJScreen.h"

CGFloat kZJScale = 1.0;
CGFloat kZJScaleV = 1.0;
CGFloat kZJScaleH = 1.0;

CGRect ZJScreenFrame() {
    return ZJScreen.shared.screenFrame;
}

CGFloat ZJScreenHeight() {
    return ZJScreen.shared.screenHeight;
}

CGFloat ZJScreenWidth() {
    return ZJScreen.shared.screenWidth;
}

CGFloat ZJStatusBarHeight() {
    return ZJScreen.shared.statusBarHeight;
}

CGFloat ZJNavBarHeight() {
    return ZJScreen.shared.navBarHeight;
}

CGFloat ZJNavStatusBarHeight(void)
{
    return ZJScreen.shared.navStatusBarHeight;
}

CGFloat ZJTabarBarHeight(void) {
    return ZJScreen.shared.tabarBarHeight;
}

CGFloat ZJSafeAreaInsetsHeight(void) {
    return ZJScreen.shared.safeAreaInsetsHeight;
}

CGFloat ZJSafeAreaTop(void) {
    return ZJScreen.shared.safeAreaTop;
}

CGFloat ZJSafeAreaBottom(void) {
    return ZJScreen.shared.safeAreaBottom;
}

ZJScreenSizeType ZJscreenSizeType() {
    return ZJScreen.shared.screenSizeType;
}

BOOL ZJIsIPad() {
    return ZJScreen.shared.isIPad;
}

CGFloat ZJScale() {
    if (ZJIsIPad()) {
        return ZJScreenHeight()/667.0 + 0.5;
    } else {
        return ZJScreenHeight()/ZJScreen.shared.scaleStandardLength;
    }
}

CGFloat ZJScaleV(void) {
    if (ZJIsIPad()) {
        return ZJScreenHeight()/667.0 + 0.5;
    } else {
        return ZJScreenHeight()/ZJScreen.shared.scaleStandardLength;
    }
}

CGFloat ZJScaleH(void) {
    if (ZJIsIPad()) {
        return ZJScreenWidth()/375.0 + 0.5;
    } else {
        return ZJScreenWidth()/ZJScreen.shared.scaleStandardWidthLength;
    }
}

@interface ZJScreen ()

@property (nonatomic, assign) CGFloat statusBarHeight;    //状态栏高度
@property (nonatomic, assign) CGFloat tabarBarHeight;     //TabarBar高度
@property (nonatomic, assign) CGFloat safeAreaInsetsHeight;       //安全区域底部高度
@property (nonatomic, assign) CGFloat safeAreaTop;     //安全区域底部顶部高度=状态栏高度
@property (nonatomic, assign) CGFloat safeAreaBottom;  //安全区域底部底部高度-34.0

@end

@implementation ZJScreen
singleton_m();

- (void)initData
{
    _scaleStandardLength = 667.0;
    _scaleStandardWidthLength = 375.0;
    
    _navBarHeight = 44.0;
    if (@available(iOS 13.0, *)) {
        _isIPad = [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad;
    } else {
        _isIPad = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad);
    }
    
    self.scaleStandard = ZJScreenSizeType8;
}

- (CGRect)screenFrame {
    return [UIScreen mainScreen].bounds;
}

- (CGFloat)screenWidth {
    return self.screenFrame.size.width;
}

- (CGFloat)screenHeight {
    return self.screenFrame.size.height;
}

- (CGFloat)statusBarHeight
{
    if (@available(iOS 13.0, *)) {
        UIStatusBarManager *statusBarManager = [UIApplication sharedApplication].windows.firstObject.windowScene.statusBarManager;
        _statusBarHeight = statusBarManager.statusBarFrame.size.height;
    } else {
        _statusBarHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
    }
    
    return _statusBarHeight;
}

- (CGFloat)navStatusBarHeight
{
    return ZJScreen.shared.navBarHeight + ZJScreen.shared.statusBarHeight;
}

- (CGFloat)tabarBarHeight
{
    if (_tabarBarHeight == 0) {
        if (@available(iOS 11.0, *)) {
            UIEdgeInsets safeAreaInsets = [[UIApplication sharedApplication].windows.firstObject safeAreaInsets];
            _tabarBarHeight = safeAreaInsets.bottom + 49.0;
        } else {
            _tabarBarHeight = 49.0;
        }
    }
    
    return _tabarBarHeight;
}

- (CGFloat)safeAreaInsetsHeight
{
    if (_safeAreaInsetsHeight == 0) {
        if (@available(iOS 11.0, *)) {
            UIEdgeInsets safeAreaInsets = [[UIApplication sharedApplication].windows.firstObject safeAreaInsets];
            _safeAreaInsetsHeight = safeAreaInsets.bottom + safeAreaInsets.top;
        }
    }
    return _safeAreaInsetsHeight;
}

- (CGFloat)safeAreaTop
{
    if (_safeAreaTop == 0) {
        if (@available(iOS 11.0, *)) {
            UIEdgeInsets safeAreaInsets = [[UIApplication sharedApplication].windows.firstObject safeAreaInsets];
            _safeAreaTop = safeAreaInsets.top - 20.0f;
        }
    }
    
    return _safeAreaTop;
}

- (CGFloat)safeAreaBottom
{
    if (_safeAreaBottom == 0) {
        if (@available(iOS 11.0, *)) {
            UIEdgeInsets safeAreaInsets = [[UIApplication sharedApplication].windows.firstObject safeAreaInsets];
            _safeAreaBottom = safeAreaInsets.bottom;
        }
    }
    
    return _safeAreaBottom;
}

#pragma mark -

- (ZJScreenSizeType)screenSizeType
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    if (width == 414.0 && height == 896.0) {
        return ZJScreenSizeTypeXsMax;
    } else if (width == 375.0 && height == 812.0) {
        return ZJScreenSizeTypeX;
    } else if (width == 414.0 && height == 736.0) {
        return ZJScreenSizeType8P;
    } else if (width == 375.0 && height == 667.0) {
        return ZJScreenSizeType8;
    } else if (width == 320.0 && height == 568.0) {
        return ZJScreenSizeType5S;
    } else if (width == 320.0 && height == 480.0) {
        return ZJScreenSizeType4S;
    }

    return ZJScreenSizeType8;
}

- (void)setScaleStandard:(ZJScreenSizeType)scaleStandard
{
    _scaleStandard = scaleStandard;
    switch (scaleStandard) {
        case ZJScreenSizeType4S:
            _scaleStandardLength = 480.0;
            _scaleStandardWidthLength = 320.0;
            break;
        case ZJScreenSizeType5S:
            _scaleStandardLength = 568.0;
            _scaleStandardWidthLength = 320.0;
            break;
        case ZJScreenSizeType8:
            _scaleStandardLength = 667.0;
            _scaleStandardWidthLength = 375.0;
            break;
        case ZJScreenSizeType8P:
            _scaleStandardLength = 736.0;
            _scaleStandardWidthLength = 414.0;
            break;
        case ZJScreenSizeTypeX:
            _scaleStandardLength = 812.0;
            _scaleStandardWidthLength = 375.0;
            break;
        case ZJScreenSizeTypeXr:
            _scaleStandardLength = 896.0;
            _scaleStandardWidthLength = 414.0;
            break;
        default:
            _scaleStandardLength = 667.0;
            _scaleStandardWidthLength = 375.0;
            break;
    }
    
    if (_isIPad) {
        kZJScale = self.screenHeight/667.0 + 0.5;
        kZJScaleV = self.screenHeight/667.0 + 0.5;
        kZJScaleH = self.screenWidth/375.0 + 0.5;
    } else {
        kZJScale = self.screenHeight/self.scaleStandardLength;
        kZJScaleV = self.screenHeight/self.scaleStandardLength;
        kZJScaleH = self.screenWidth/self.scaleStandardWidthLength;
    }
}

#pragma mark -

+ (UIWindow *)keyWindow
{
    UIWindow *keyWindow = [UIApplication sharedApplication].delegate.window;
    if (keyWindow) return keyWindow;
    
    return [self frontWindow];
}

+ (UIWindow *)frontWindow
{
    NSEnumerator *frontToBackWindows = [UIApplication.sharedApplication.windows reverseObjectEnumerator];
    UIWindow *vaWindow = nil;
    for (UIWindow *window in frontToBackWindows) {
        BOOL isMainScreen = window.screen == UIScreen.mainScreen;
        BOOL isVisible = !window.hidden && window.alpha > 0;
        BOOL isLevelNormal = window.windowLevel == UIWindowLevelNormal;
        BOOL isKeyWindow = window.isKeyWindow;
            
        if (isMainScreen && isVisible && isLevelNormal && isKeyWindow) {
            vaWindow = window;
        }
    }
    
    return vaWindow;
}

@end
