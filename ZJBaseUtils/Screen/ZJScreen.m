//
//  ZJScreen.m
//  ZJBaseUtils
//
//  Created by eafy on 2020/8/18.
//  Copyright © 2020 ZJ<lizhijian_21@163.com>. All rights reserved.
//

#import "ZJScreen.h"

extern CGRect ZJScreenFrame() {
    return [ZJScreen screenFrame];
}

extern CGFloat ZJScreenHeight() {
    return [ZJScreen height];
}

extern CGFloat ZJScreenWidth() {
    return [ZJScreen width];
}

extern CGFloat ZJStatusBarHeight() {
    return [ZJScreen statusBarHeight];
}

extern CGFloat ZJNavBarHeight() {
    return [ZJScreen navBarHeight];
}

extern ZJScreenSizeType ZJscreenSizeType() {
    return [ZJScreen screenSizeType];
}

extern BOOL ZJIsIPad() {
    return [ZJScreen isIPad];
}

extern CGFloat ZJScale() {
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

    if (@available(iOS 13.0, *)) {
        UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
        _statusBarHeight = keyWindow.windowScene.statusBarManager.statusBarFrame.size.height;
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

+ (ZJScreenSizeType)screenSizeType {
    return ZJScreen.shared.screenSizeType;
}

+ (BOOL)isIPad {
    return ZJScreen.shared.isIPad;
}


@end
