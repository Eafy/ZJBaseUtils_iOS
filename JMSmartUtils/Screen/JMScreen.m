//
//  JMScreen.m
//  JMBaseUtils
//
//  Created by lzj<lizhijian_21@163.com> on 2020/8/18.
//  Copyright © 2020 Jimi. All rights reserved.
//

#import "JMScreen.h"

extern CGRect JMScreenFrame() {
    return [JMScreen screenFrame];
}

extern CGFloat JMScreenHeight() {
    return [JMScreen height];
}

extern CGFloat JMScreenWidth() {
    return [JMScreen width];
}

extern CGFloat JMStatusBarHeight() {
    return [JMScreen statusBarHeight];
}

extern CGFloat JMNavBarHeight() {
    return [JMScreen navBarHeight];
}

extern JMScreenSizeType JMscreenSizeType() {
    return [JMScreen screenSizeType];
}

extern BOOL JMIsIPad() {
    return [JMScreen isIPad];
}

extern CGFloat JMScale() {
    if (JMIsIPad()) {
        return JMNavBarHeight()/JMScreenWidth();
    } else {
        return JMScreenWidth()/375.f;
    }
}

@implementation JMScreen
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
        UIStatusBarManager *statusBarManager = [UIApplication sharedApplication].windows.firstObject.windowScene.statusBarManager;
        _statusBarHeight = statusBarManager.statusBarFrame.size.height;
        _isIPad = [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad;
    } else {
        _statusBarHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
        _isIPad = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad);
    }
}

#pragma mark -

- (JMScreenSizeType)screenSizeType
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    if (width == 414 && height == 896) {
        return JMScreenSizeTypeXsMax;
    } else if (width == 375 && height == 812) {
        return JMScreenSizeTypeX;
    } else if (width == 414 && height == 736) {
        return JMScreenSizeType8P;
    } else if (width == 375 && height == 667) {
        return JMScreenSizeType8;
    } else if (width == 320 && height == 568) {
        return JMScreenSizeType5S;
    } else if (width == 320 && height == 480) {
        return JMScreenSizeType4S;
    }

    return JMScreenSizeType8;
}

#pragma mark -

+ (CGRect)screenFrame {
    return JMScreen.shared.screenFrame;
}

+ (CGFloat)height {
    return JMScreen.shared.screenHeight;
}

+ (CGFloat)width {
    return JMScreen.shared.screenWidth;
}

+ (CGFloat)statusBarHeight {
    return JMScreen.shared.statusBarHeight;
}

+ (CGFloat)navBarHeight {
    return JMScreen.shared.navBarHeight;
}

+ (JMScreenSizeType)screenSizeType {
    return JMScreen.shared.screenSizeType;
}

+ (BOOL)isIPad {
    return JMScreen.shared.isIPad;
}


@end
