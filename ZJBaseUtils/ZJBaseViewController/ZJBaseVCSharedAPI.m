//
//  ZJBaseVCSharedAPI.m
//  ZJBaseUtils
//
//  Created by eafy on 2021/9/26.
//  Copyright © 2021 ZJ. All rights reserved.
//

#import "ZJBaseVCSharedAPI.h"
#import <ZJBaseUtils/UIView+ZJFrame.h>
#import <ZJBaseUtils/ZJScreen.h>
#import <ZJBaseUtils/ZJSystem.h>
#import <ZJBaseUtils/UIColor+ZJExt.h>
#import <ZJBaseUtils/ZJBundleRes.h>

@interface ZJBaseVCSharedAPI() <UIGestureRecognizerDelegate,UINavigationControllerDelegate>

/// 是左侧边栏右滑返回
@property (nonatomic,assign) BOOL isLeftSideslipBack;

/// 背景视图
@property (nonatomic,strong) UIImageView *backgroundImgView;
/// 屏幕方向
@property (nonatomic,assign) UIInterfaceOrientation inInterfaceOrientation;

@end

@implementation ZJBaseVCSharedAPI

- (ZJBaseViewController *_Nullable)currentVC {
    return (ZJBaseViewController *)self.delegate;
}

- (UINavigationController *_Nullable)navCtl {
    return self.currentVC.navigationController;
}

- (UINavigationBar *_Nullable)navigationBar {
    return self.navCtl.navigationBar;
}

#pragma mark - 系统API

- (void)viewWillAppear:(BOOL)animated {
    [self.navCtl setNavigationBarHidden:self.isHideNavBar animated:YES];
    self.isLeftSideslipBack = NO;
    self.isVisible = YES;

    [self initNavigationBar];
    if (self.isShowNavBarView) {
        [self addNavBarBtnForHide];
    }
    if (_navLeftBtn && self.navCtl && self.navCtl.viewControllers.count == 1) {
        self.navLeftBtn.hidden = YES;
    }
}

- (void)viewDidAppear:(BOOL)animated {
    self.navCtl.interactivePopGestureRecognizer.delegate = self;
    self.navCtl.delegate = self;
    self.isLeftSlideEnable = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    if (self.isHideNavBar) {
        [self.navCtl setNavigationBarHidden:!self.isHideNavBar animated:YES];
    }
    self.isVisible = NO;
}

- (void)viewDidDisappear:(BOOL)animated {
    self.navCtl.interactivePopGestureRecognizer.delegate = nil;
    self.navCtl.delegate = nil;

    if (self.isLeftSideslipBack) {
        [self navLeftBtnAction];
    }
}

- (void)viewDidLoad {
    self.currentVC.automaticallyAdjustsScrollViewInsets = NO;
    self.currentVC.modalPresentationStyle = UIModalPresentationFullScreen;

    self.currentVC.view.backgroundColor = self.backgroundColor ? self.backgroundColor : [UIColor whiteColor];
    if (_backgroundImgName && !_backgroundImgView) {
        self.backgroundImgName = _backgroundImgName;
    }
}

- (void)dealloc {
    [self releaseData];
}

- (void)releaseData {
    _nextViewController = nil;
    _navRightBtn = nil;
    _navLeftBtn = nil;
    _returnBeforeOption = nil;
    _returnBeforeData = nil;

    _isLeftSideslipBack = NO;
    if (self.delegate) {
        [[NSNotificationCenter defaultCenter] removeObserver:self.delegate];        
    }
}

- (void)initNavigationBar {
    if (!self.barTintColor) {
        _barTintColor = [self sysBarTintColor];
    }
    if (!self.barTitleColor) {
        _barTitleColor = [self sysBarTitleColor];
    }
    if (!self.barTitleFont) {
        _barTitleFont = [self sysBarTitleFont];
    }
    
    if (!self.isHideNavBar) {
        self.barTintColor = self.barTintColor;
    }
    self.barTitleColor = self.barTitleColor;
    self.barTitleFont = self.barTitleFont;
    
    if (!self.isHideNavBar && !self.currentVC.navigationItem.leftBarButtonItem) {
        UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.navLeftBtn];
        if (!_navLeftSubBtn) {
            self.currentVC.navigationItem.leftBarButtonItem = leftBarButtonItem;
        } else {
            UIBarButtonItem *leftBarButtonItem2 = [[UIBarButtonItem alloc] initWithCustomView:self.navLeftSubBtn];
            self.currentVC.navigationItem.leftBarButtonItems = @[leftBarButtonItem, leftBarButtonItem2];
        }
    }
    
    if (!self.isHideNavBar && !self.currentVC.navigationItem.rightBarButtonItem) {
        UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.navRightBtn];
        if (!_navRightSubBtn) {
            self.currentVC.navigationItem.rightBarButtonItem = rightBarButtonItem;
        } else {
            UIBarButtonItem *rightBarButtonItem2 = [[UIBarButtonItem alloc] initWithCustomView:self.navRightSubBtn];
            self.currentVC.navigationItem.rightBarButtonItems = @[rightBarButtonItem, rightBarButtonItem2];
        }
    }
    
    //去除NavigationBar底部黑线颜色
    self.navigationBar.shadowImage = [[UIImage alloc] init];
}

#pragma mark - 自定义导航栏视图

- (void)setIsShowNavBarView:(BOOL)isShowNavBarView {
    _isShowNavBarView = isShowNavBarView;
    if (!self.isHideNavBar) {
        NSLog(@"The system navigation bar is not hidden, and the custom navigation bar cannot be set!\nIt will be set again when the view controller is displayed.");
        return;
    }

    if (isShowNavBarView && self.isVisible) {
        [self addNavBarBtnForHide];
    }

    if (_navBarBgView) {
        self.navBarBgView.hidden = !isShowNavBarView;
    } else {
        self.navLeftBtn.hidden = !isShowNavBarView;
        self.navRightBtn.hidden = !isShowNavBarView;
        self.navBarTitleLB.hidden = !isShowNavBarView;
    }
}

- (void)addNavBarBtnForHide {
    self.navLeftBtn.zj_left = 15.0f;
    self.navLeftBtn.zj_centerY = ZJStatusBarHeight() + ZJNavBarHeight()/2;
    self.navRightBtn.zj_centerY = self.navLeftBtn.zj_centerY;
    self.navRightBtn.zj_right = ZJScreenWidth() - 15;

    if (self.isShowNavBarBgView) {
        self.navBarBgView.frame = CGRectMake(0, 0, ZJScreenWidth(), ZJNavStatusBarHeight());
        self.navBarBgView.userInteractionEnabled = YES;
        if (self.navBarBgView.superview != self.currentVC.view) {
            [self.currentVC.view addSubview:self.navBarBgView];
        }
    }
    UIView *navView = self.currentVC.view;
    if (_navBarBgView) {
        navView = self.navBarBgView;
    }

    [self.navLeftBtn removeFromSuperview];
    [self.navRightBtn removeFromSuperview];
    [self.navBarTitleLB removeFromSuperview];
    if (_navRightSubBtn) {
        [self.navRightSubBtn removeFromSuperview];
    }
    if (_navLeftSubBtn) {
        [self.navLeftSubBtn removeFromSuperview];
    }

    [navView addSubview:self.navLeftBtn];
    CGFloat imageWith = self.navLeftBtn.imageView.frame.size.width;
    CGFloat labelWidth = self.navLeftBtn.titleLabel.intrinsicContentSize.width;
    if (imageWith + labelWidth > self.navLeftBtn.zj_width) {
        self.navLeftBtn.zj_width = imageWith + labelWidth;
        self.navLeftBtn.zj_left = 15;
    }
    if (_navLeftSubBtn || self.isNavLeftSubTitle) {
        self.navLeftBtn.zj_width = imageWith + labelWidth;

        self.navLeftSubBtn.zj_centerY = self.navLeftBtn.zj_centerY;
        [navView addSubview:self.navLeftSubBtn];
        if (self.isNavLeftSubTitle) {
            if (self.navCtl.viewControllers.count > 1) {
                UIViewController *vc = self.navCtl.viewControllers[self.navCtl.viewControllers.count - 2];
                [self.navLeftSubBtn setTitle:vc.title forState:UIControlStateNormal];
            }
        }

        imageWith = self.navLeftSubBtn.imageView.frame.size.width;
        labelWidth = self.navLeftSubBtn.titleLabel.intrinsicContentSize.width;
        if (imageWith + labelWidth > self.navLeftSubBtn.zj_width) {
            self.navLeftSubBtn.zj_width = imageWith + labelWidth;
        }
        self.navLeftSubBtn.zj_left = self.navLeftBtn.zj_right;
    }

    [navView addSubview:self.navRightBtn];
    imageWith = self.navRightBtn.imageView.frame.size.width;
    labelWidth = self.navRightBtn.titleLabel.intrinsicContentSize.width;
    if (imageWith + labelWidth > self.navRightBtn.zj_width) {
        self.navRightBtn.zj_width = imageWith + labelWidth;
        self.navRightBtn.zj_right = ZJScreenWidth() - 15;
    }
    if (_navRightSubBtn) {
        self.navRightSubBtn.zj_centerY = self.navRightBtn.zj_centerY;
        [navView addSubview:self.navRightSubBtn];

        imageWith = self.navRightSubBtn.imageView.frame.size.width;
        labelWidth = self.navRightSubBtn.titleLabel.intrinsicContentSize.width;
        if (imageWith + labelWidth > self.navRightSubBtn.zj_width) {
            self.navRightSubBtn.zj_width = imageWith + labelWidth;
        }
        self.navRightSubBtn.zj_right = self.navRightBtn.zj_left - 8;
    }

    self.navBarTitleLB.frame = CGRectMake(0, ZJStatusBarHeight(), ZJScreenWidth()/2.0, ZJNavBarHeight());
    self.navBarTitleLB.zj_centerX = ZJScreenWidth()/2.0;
    self.navBarTitleLB.zj_centerY = ZJStatusBarHeight() + ZJNavBarHeight()/2.0;
    [navView addSubview:self.navBarTitleLB];
}

#pragma mark - 懒加载

- (UIImageView *)navBarBgView {
    if (!_navBarBgView) {
        _navBarBgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ZJScreenWidth(), ZJNavStatusBarHeight())];
        if (self.barTintColor) {
            _navBarBgView.backgroundColor = self.barTintColor;
        } else {
            _navBarBgView.backgroundColor = [UIColor whiteColor];
        }
    }

    return _navBarBgView;
}

- (UIButton *)navLeftBtn
{
    if (!_navLeftBtn) {
        _navLeftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, ZJNavBarHeight() + (ZJIsIPad()?30:0), ZJNavBarHeight())];
        if (![_navLeftBtn imageForState:UIControlStateNormal]) {
            UIImage *img = [ZJBundleRes imageNamed:@"icon_nav_back_no"];
            if (img) {
                [_navLeftBtn setImage:img forState:UIControlStateNormal];
            }
        }
        if (![_navLeftBtn imageForState:UIControlStateHighlighted]) {
            UIImage *img = [ZJBundleRes imageNamed:@"icon_nav_back_sel"];
            if (img) {
                [_navLeftBtn setImage:img forState:UIControlStateHighlighted];
            }
        }

        [_navLeftBtn.titleLabel setFont:[UIFont systemFontOfSize:14.f*ZJScaleH()]];
        [_navLeftBtn setTitleColor:ZJColorFromRGB(0x3D7DFF) forState:UIControlStateNormal];
        [_navLeftBtn setBackgroundColor:[UIColor clearColor]];
        if ([self.delegate respondsToSelector:@selector(navLeftBtnAction)]) {
            [_navLeftBtn addTarget:self.delegate action:@selector(navLeftBtnAction) forControlEvents:UIControlEventTouchUpInside];
        } else {
            [_navLeftBtn addTarget:self action:@selector(navLeftBtnAction) forControlEvents:UIControlEventTouchUpInside];
        }
        if ([ZJSystem currentLanguageType] == ZJ_SYS_LANGUAGE_TYPE_Hebrew) {
            _navLeftBtn.imageView.transform = CGAffineTransformMakeScale(-1, 1);
            [_navLeftBtn.titleLabel setTextAlignment:NSTextAlignmentRight];
            [_navLeftBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
        } else {
            [_navLeftBtn.titleLabel setTextAlignment:NSTextAlignmentLeft];
            [_navLeftBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
            if (ZJIsIPad()) {
                [_navLeftBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
            }
        }
    }

    return _navLeftBtn;
}

- (UIButton *)navLeftSubBtn {
    if (!_navLeftSubBtn) {
        _navLeftSubBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _navLeftSubBtn.frame = CGRectMake(0, 0, ZJNavBarHeight() + (ZJIsIPad()?30:0), ZJNavBarHeight());
        [_navLeftSubBtn.titleLabel setFont:[UIFont systemFontOfSize:14.f*ZJScaleH()]];
        [_navLeftSubBtn setTitleColor:ZJColorFromRGB(0x3D7DFF) forState:UIControlStateNormal];
        [_navLeftSubBtn setBackgroundColor:[UIColor clearColor]];
        if ([self.delegate respondsToSelector:@selector(navLeftSubBtnAction)]) {
            [_navLeftSubBtn addTarget:self.delegate action:@selector(navLeftSubBtnAction) forControlEvents:UIControlEventTouchUpInside];
        } else {
            [_navLeftSubBtn addTarget:self action:@selector(navLeftSubBtnAction) forControlEvents:UIControlEventTouchUpInside];
        }
        if ([ZJSystem currentLanguageType] == ZJ_SYS_LANGUAGE_TYPE_Hebrew) {
            _navLeftSubBtn.imageView.transform = CGAffineTransformMakeScale(-1, 1);
            [_navLeftSubBtn.titleLabel setTextAlignment:NSTextAlignmentRight];
            [_navLeftSubBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
        } else {
            [_navLeftSubBtn.titleLabel setTextAlignment:NSTextAlignmentLeft];
            [_navLeftSubBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
            if (ZJIsIPad()) {
                [_navLeftSubBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
            }
        }
    }

    return _navLeftSubBtn;
}

- (UIButton *)navRightBtn
{
    if (!_navRightBtn) {
        _navRightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _navRightBtn.frame = CGRectMake(0, 0, ZJNavBarHeight() + 20, ZJNavBarHeight());
        [_navRightBtn.titleLabel setFont:[UIFont systemFontOfSize:14.f*ZJScaleH()]];
        [_navRightBtn setTitleColor:ZJColorFromRGB(0x3D7DFF) forState:UIControlStateNormal];
        [_navRightBtn setBackgroundColor:[UIColor clearColor]];
        if ([self.delegate respondsToSelector:@selector(navRightBtnAction)]) {
            [_navRightBtn addTarget:self.delegate action:@selector(navRightBtnAction) forControlEvents:UIControlEventTouchUpInside];
        } else {
            [_navRightBtn addTarget:self action:@selector(navRightBtnAction) forControlEvents:UIControlEventTouchUpInside];
        }
        if ([ZJSystem currentLanguageType] == ZJ_SYS_LANGUAGE_TYPE_Hebrew) {
            [_navRightBtn.titleLabel setTextAlignment:NSTextAlignmentLeft];
            [_navRightBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        } else {
            [_navRightBtn.titleLabel setTextAlignment:NSTextAlignmentRight];
            [_navRightBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
            if (ZJIsIPad()) {
                [_navRightBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 10)];
            }
        }
    }

    return _navRightBtn;
}

- (UIButton *)navRightSubBtn {
    if (!_navRightSubBtn) {
        _navRightSubBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _navRightSubBtn.frame = CGRectMake(0, 0, ZJNavBarHeight() + (ZJIsIPad()?30:0), ZJNavBarHeight());
        [_navRightSubBtn.titleLabel setFont:[UIFont systemFontOfSize:14.f*ZJScaleH()]];
        [_navRightSubBtn setTitleColor:ZJColorFromRGB(0x3D7DFF) forState:UIControlStateNormal];
        [_navRightSubBtn setBackgroundColor:[UIColor clearColor]];
        if ([self.delegate respondsToSelector:@selector(navRightSubBtnAction)]) {
            [_navRightSubBtn addTarget:self.delegate action:@selector(navRightSubBtnAction) forControlEvents:UIControlEventTouchUpInside];
        } else {
            [_navRightSubBtn addTarget:self action:@selector(navRightSubBtnAction) forControlEvents:UIControlEventTouchUpInside];
        }
        if ([ZJSystem currentLanguageType] == ZJ_SYS_LANGUAGE_TYPE_Hebrew) {
            [_navRightSubBtn.titleLabel setTextAlignment:NSTextAlignmentLeft];
            [_navRightSubBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        } else {
            [_navRightSubBtn.titleLabel setTextAlignment:NSTextAlignmentRight];
            [_navRightSubBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
            if (ZJIsIPad()) {
                [_navRightSubBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 10)];
            }
        }
        
        if (self.navRightBtn.zj_width == ZJNavBarHeight() + 20) {
            self.navRightBtn.zj_width = ZJNavBarHeight();
        }
    }

    return _navRightSubBtn;
}

- (UILabel *)navBarTitleLB
{
    if (!_navBarTitleLB) {
        _navBarTitleLB = [[UILabel alloc] initWithFrame:CGRectMake(0, ZJStatusBarHeight(), ZJScreenWidth()/2.0, ZJNavBarHeight())];
        _navBarTitleLB.text = self.currentVC.title;
        _navBarTitleLB.textAlignment = NSTextAlignmentCenter;
        _navBarTitleLB.backgroundColor = [UIColor clearColor];

        if (self.barTitleColor) {
            _navBarTitleLB.textColor = self.barTitleColor;
        } else {
            _navBarTitleLB.textColor = [self sysBarTitleColor];
        }
        if (self.barTitleFont) {
            _navBarTitleLB.font = self.barTitleFont;
        } else {
            _navBarTitleLB.font = [self sysBarTitleFont];
        }

        _navBarTitleLB.zj_centerX = ZJScreenWidth()/2.0;
        _navBarTitleLB.zj_centerY = ZJStatusBarHeight() + ZJNavBarHeight()/2.0;
    }

    return _navBarTitleLB;
}

#pragma mark - 属性API

- (UIColor *)sysBarTintColor {
    UIColor *color = self.navigationBar.barTintColor;
    if (!color) color = [UIColor whiteColor];

    if (@available(iOS 15.0, *)) {
        UINavigationBarAppearance *appearance = self.navigationBar.scrollEdgeAppearance;
        UIColor *colorT = appearance.backgroundColor;
        if (colorT) {
            color = colorT;
        }
    }
    return color;
}

- (UIColor *)sysBarTitleColor {
    NSDictionary<NSAttributedStringKey, id> *navTitleAttDic = [self.navigationBar titleTextAttributes];
    UIColor *color = [navTitleAttDic objectForKey:NSForegroundColorAttributeName];
    if (!color) color = [UIColor blackColor];

    if (@available(iOS 15.0, *)) {
        UINavigationBarAppearance *appearance = self.navigationBar.scrollEdgeAppearance;
        UIColor *colorT = [appearance.titleTextAttributes objectForKey:NSForegroundColorAttributeName];
        if (colorT) {
            color = colorT;
        }
    }
    return color;
}

- (UIFont *)sysBarTitleFont {
    NSDictionary<NSAttributedStringKey, id> *navTitleAttDic = [self.navigationBar titleTextAttributes];
    UIFont *font = [navTitleAttDic objectForKey:NSFontAttributeName];
    if (!font) font = [UIFont boldSystemFontOfSize:18];
    
    if (@available(iOS 15.0, *)) {
        UINavigationBarAppearance *appearance = self.navigationBar.scrollEdgeAppearance;
        UIFont *fontT = [appearance.titleTextAttributes objectForKey:NSFontAttributeName];
        if (fontT) {
            font = fontT;
        }
    }
    return font;
}

- (void)setBarTintColor:(UIColor *)barTintColor {
    _barTintColor = barTintColor;
    if (!_barTintColor) return;
    
    self.navigationBar.barTintColor = barTintColor;
    if (@available(iOS 15.0, *)) {
        UINavigationBarAppearance *appearance = self.navigationBar.scrollEdgeAppearance;
        appearance.backgroundColor = barTintColor;
        self.navigationBar.scrollEdgeAppearance = appearance;
        self.navigationBar.standardAppearance = appearance;
    }
}

- (void)setBarTitleColor:(UIColor *)barTitleColor {
    _barTitleColor = barTitleColor;
    if (!_barTitleColor) return;

    if (_navBarTitleLB) {
        self.navBarTitleLB.textColor = barTitleColor;
    } else if (self.navCtl) {
        [self updataSysTitleTextAttributes];
        if (@available(iOS 15.0, *)) {
            UINavigationBarAppearance *appearance = self.navigationBar.scrollEdgeAppearance;
            NSMutableDictionary<NSAttributedStringKey, id> *titleTextAttributes = [NSMutableDictionary dictionaryWithDictionary:appearance.titleTextAttributes];
            [titleTextAttributes setValue:self.barTitleColor forKey:NSForegroundColorAttributeName];
            appearance.titleTextAttributes = titleTextAttributes;
            self.navigationBar.scrollEdgeAppearance = appearance;
            self.navigationBar.standardAppearance = appearance;
        }
    }
}

- (void)setBarTitleFont:(UIFont *)barTitleFont {
    _barTitleFont = barTitleFont;
    if (!_barTitleFont) return;
    
    if (_navBarTitleLB) {
        if (barTitleFont) {
            self.navBarTitleLB.font = barTitleFont;
        }
    } else if (self.navCtl) {
        [self updataSysTitleTextAttributes];
        if (@available(iOS 15.0, *)) {
            UINavigationBarAppearance *appearance = self.navigationBar.scrollEdgeAppearance;
            NSMutableDictionary<NSAttributedStringKey, id> *titleTextAttributes = [NSMutableDictionary dictionaryWithDictionary:appearance.titleTextAttributes];
            [titleTextAttributes setValue:self.barTitleFont forKey:NSFontAttributeName];
            appearance.titleTextAttributes = titleTextAttributes;
            self.navigationBar.scrollEdgeAppearance = appearance;
            self.navigationBar.standardAppearance = appearance;
        }
    }
}

- (void)updataSysTitleTextAttributes {
    NSMutableDictionary<NSAttributedStringKey, id> *titleTextAttributes = [NSMutableDictionary dictionary];
    if (self.navigationBar.titleTextAttributes) {
        titleTextAttributes = [NSMutableDictionary dictionaryWithDictionary:self.navigationBar.titleTextAttributes];
    }
    BOOL ret = NO;
    if (self.barTitleColor) {
        [titleTextAttributes setValue:self.barTitleColor forKey:NSForegroundColorAttributeName];
        ret = YES;
    }
    if (self.barTitleFont) {
        [titleTextAttributes setValue:self.barTitleFont forKey:NSFontAttributeName];
        ret = YES;
    }
    if (ret) {
        [self.navigationBar setTitleTextAttributes:titleTextAttributes];
    }
}

- (void)setTitle:(NSString *)title {
    _title = title;
    if (_navBarTitleLB) {
        self.navBarTitleLB.text = title;
    }
}

- (void)setBackgroundImgName:(NSString *)backgroundImgName {
    _backgroundImgName = backgroundImgName;
    if (backgroundImgName && [self.currentVC isViewLoaded]) {
        UIImage *img = [UIImage imageNamed:backgroundImgName];
        if (img) {
            if (!_backgroundImgView) {
                _backgroundImgView = [[UIImageView alloc] initWithFrame:self.currentVC.view.bounds];
                _backgroundImgView.contentMode = UIViewContentModeScaleAspectFill;
                [self.currentVC.view insertSubview:_backgroundImgView atIndex:0];
            }
            _backgroundImgView.image = img;
        }
    } else if (_backgroundImgView && (!backgroundImgName || backgroundImgName.length == 0)) {
        [_backgroundImgView removeFromSuperview];
        _backgroundImgView = nil;
    }
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
    _backgroundColor = backgroundColor;
    if ([self.currentVC isViewLoaded]) {
        self.currentVC.view.backgroundColor = backgroundColor;
    }
}

#pragma mark - ButtonAction

- (void)navRightBtnAction {
    if (_nextViewController) {
        [self.navCtl pushViewController:_nextViewController animated:YES];
    }
}

- (void)navRightSubBtnAction {
}

- (void)navLeftBtnAction {
    [self.currentVC.view endEditing:YES];
    if (_returnBeforeOption) {
        self.returnBeforeOption(self.returnBeforeData);
    }

    if (!self.isLeftSideslipBack) {
        if (self.navCtl.viewControllers.count == 1 || !self.navCtl) {
            [self.currentVC dismissViewControllerAnimated:YES completion:self.returnAfterOption];
            _returnAfterOption = nil;
        } else {
            [self.navCtl popViewControllerAnimated:YES];
            if (_returnAfterOption) {
                self.returnAfterOption();
                _returnAfterOption = nil;
            }
        }
    } else if (_returnAfterOption) {
        self.returnAfterOption();
    }
    
    [self releaseData];
}

- (void)navLeftSubBtnAction {
}

#pragma mark - UINavigationControllerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if ([gestureRecognizer isKindOfClass:[UIScreenEdgePanGestureRecognizer class]]) {
        if (self.isLeftSlideEnable && self.navCtl.viewControllers.count > 1) {
            self.isLeftSideslipBack = YES;
            return YES;
        }
    } else {
        return YES;
    }
    self.isLeftSideslipBack = NO;

    return NO;
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    self.isLeftSideslipBack = NO;
    if (self.navCtl.viewControllers.count > 1) {
        navigationController.interactivePopGestureRecognizer.enabled = YES;
    } else {
        navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    if (self.isShowNavBarView) {
        __weak ZJBaseVCSharedAPI *weakSelf = self;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf addNavBarBtnForHide];
        });
    }
}

#pragma mark - 强制横竖屏切换

/// 横竖屏切换
/// #需要在- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window接口返回指定方向
/// @param orientation 方向
- (void)interfaceOrientation:(UIInterfaceOrientation)orientation {
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        self.inInterfaceOrientation = orientation;
        SEL selector = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];

        [invocation setSelector:selector];
        [invocation setTarget:[UIDevice currentDevice]];

        [invocation setArgument:&orientation atIndex:2];    //从2开始是因为0 1两个参数已经被selector和target占用
        [invocation invoke];
    }
}

- (UIInterfaceOrientation)interfaceOrientation {
    return self.inInterfaceOrientation;
}


@end
