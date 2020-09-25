//
//  ZJScreen.m
//  ZJBaseUtils
//
//  Created by eafy on 2020/8/18.
//  Copyright © 2020 ZJ<lizhijian_21@163.com>. All rights reserved.
//

#import "ZJScreen.h"

CGRect ZJScreenFrame() {
    return [ZJScreen screenFrame];
}

CGFloat ZJScreenHeight() {
    return [ZJScreen height];
}

CGFloat ZJScreenWidth() {
    return [ZJScreen width];
}

CGFloat ZJStatusBarHeight() {
    return [ZJScreen statusBarHeight];
}

CGFloat ZJNavBarHeight() {
    return [ZJScreen navBarHeight];
}

CGFloat ZJSafeAreaInsetsHeight(void) {
    return [ZJScreen safeAreaInsetsHeight];
}

ZJScreenSizeType ZJscreenSizeType() {
    return [ZJScreen screenSizeType];
}

BOOL ZJIsIPad() {
    return [ZJScreen isIPad];
}

CGFloat ZJScale() {
    if (ZJIsIPad()) {
        return ZJNavBarHeight()/ZJScreenWidth();
    } else {
        return ZJScreenWidth()/375.f;
    }
}

@implementation ZJScreen
singleton_m();

@synthesize screenFrame = _screenFrame;
@synthesize screenHeight = _screenHeight;
@synthesize screenWidth = _screenWidth;
@synthesize statusBarHeight = _statusBarHeight;
@synthesize navBarHeight = _navBarHeight;
@synthesize screenSizeType = _screenSizeType;
@synthesize isIPad = _isIPad;

- (void)initData
{
    _screenFrame = [UIScreen mainScreen].bounds;
    _screenHeight = self.screenFrame.size.height;
    _screenWidth = self.screenFrame.size.width;

     _navBarHeight = 44.0;
    if (self.screenHeight == 1366.0 || self.screenHeight == 1024.0) {
        _navBarHeight = 64.0;
    }

    _safeAreaInsetsHeight = 0;
    if (@available(iOS 11.0, *)) {
        UIEdgeInsets safeAreaInsets = [[UIApplication sharedApplication].windows.firstObject safeAreaInsets];
        _safeAreaInsetsHeight = safeAreaInsets.bottom - safeAreaInsets.top;
    }
    
    if (@available(iOS 13.0, *)) {
        UIStatusBarManager *statusBarManager = [UIApplication sharedApplication].windows.firstObject.windowScene.statusBarManager;
        _statusBarHeight = statusBarManager.statusBarFrame.size.height;
        _isIPad = [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad;
    } else {
        _statusBarHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
        _isIPad = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad);
    }
}

#pragma mark -

- (ZJScreenSizeType)screenSizeType
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    if (width == 414 && height == 896) {
        return ZJScreenSizeTypeXsMax;
    } else if (width == 375 && height == 812) {
        return ZJScreenSizeTypeX;
    } else if (width == 414 && height == 736) {
        return ZJScreenSizeType8P;
    } else if (width == 375 && height == 667) {
        return ZJScreenSizeType8;
    } else if (width == 320 && height == 568) {
        return ZJScreenSizeType5S;
    } else if (width == 320 && height == 480) {
        return ZJScreenSizeType4S;
    }

    return ZJScreenSizeType8;
}

#pragma mark -

+ (CGRect)screenFrame {
    return ZJScreen.shared.screenFrame;
}

+ (CGFloat)height {
    return ZJScreen.shared.screenHeight;
}

+ (CGFloat)width {
    return ZJScreen.shared.screenWidth;
}

+ (CGFloat)statusBarHeight {
    return ZJScreen.shared.statusBarHeight;
}

+ (CGFloat)navBarHeight {
    return ZJScreen.shared.navBarHeight;
}

+ (CGFloat)safeAreaInsetsHeight {
    return ZJScreen.shared.safeAreaInsetsHeight;
}

+ (ZJScreenSizeType)screenSizeType {
    return ZJScreen.shared.screenSizeType;
}

+ (BOOL)isIPad {
    return ZJScreen.shared.isIPad;
}


@end
