//
//  ZJBaseViewController.m
//  ZJBaseUtils
//
//  Created by eafy on 2020/9/14.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import <ZJBaseUtils/ZJBaseViewController.h>
#import <ZJBaseUtils/ZJBaseVCSharedAPI.h>

@interface ZJBaseViewController () <ZJBaseVCSharedAPIDelegate>

@property (nonatomic,strong) ZJBaseVCSharedAPI *sharedAPI;

@end

@implementation ZJBaseViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.sharedAPI viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.sharedAPI viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.sharedAPI viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.sharedAPI viewDidDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.sharedAPI viewDidLoad];
}

- (void)dealloc {
    if (_sharedAPI) {
        [_sharedAPI releaseData];
        _sharedAPI = nil;
    }
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 自定义导航栏视图

- (UIImageView *)navBarBgView {
    return self.sharedAPI.navBarBgView;
}
- (void)setNavBarBgView:(UIImageView *)navBarBgView {
    self.sharedAPI.navBarBgView = navBarBgView;
}

- (void)setIsShowNavBarView:(BOOL)isShowNavBarView {
    _isShowNavBarView = isShowNavBarView;
    self.sharedAPI.isShowNavBarView = isShowNavBarView;
}

- (void)setIsShowNavBarBgView:(BOOL)isShowNavBarBgView {
    _isShowNavBarBgView = isShowNavBarBgView;
    self.sharedAPI.isShowNavBarBgView = isShowNavBarBgView;
}

#pragma mark - 懒加载

- (UIButton *)navLeftBtn {
    return self.sharedAPI.navLeftBtn;
}
- (void)setNavLeftBtn:(UIButton *)navLeftBtn {
    self.sharedAPI.navLeftBtn = navLeftBtn;
}

- (UIButton *)navLeftSubBtn {
    return self.sharedAPI.navLeftSubBtn;
}
- (void)setNavLeftSubBtn:(UIButton *)navLeftSubBtn {
    self.sharedAPI.navLeftSubBtn = navLeftSubBtn;
}

- (UIButton *)navRightBtn {
    return self.sharedAPI.navRightBtn;
}
- (void)setNavRightBtn:(UIButton *)navRightBtn {
    self.sharedAPI.navRightBtn = navRightBtn;
}

- (UIButton *)navRightSubBtn {
    return self.sharedAPI.navRightSubBtn;
}
- (void)setNavRightSubBtn:(UIButton *)navRightSubBtn {
    self.sharedAPI.navRightSubBtn = navRightSubBtn;
}

- (UILabel *)navBarTitleLB {
    return self.sharedAPI.navBarTitleLB;
}
- (void)setNavBarTitleLB:(UILabel *)navBarTitleLB {
    self.sharedAPI.navBarTitleLB = navBarTitleLB;
}

- (BOOL)isLeftSlideEnable {
    return self.sharedAPI.isLeftSlideEnable;
}
- (void)setIsLeftSlideEnable:(BOOL)isLeftSlideEnable {
    self.sharedAPI.isLeftSlideEnable = isLeftSlideEnable;
}

#pragma mark - 仅set

- (void)setTitle:(NSString *)title {
    super.title = title;
    self.sharedAPI.title = title;
}

- (void)setBarTintColor:(UIColor *)barTintColor {
    _barTintColor = barTintColor;
    self.sharedAPI.barTintColor = barTintColor;
}

- (void)setBarTitleColor:(UIColor *)barTitleColor {
    _barTitleColor = barTitleColor;
    self.sharedAPI.barTitleColor = barTitleColor;
}

- (void)setBarTitleFont:(UIFont *)barTitleFont {
    _barTitleFont = barTitleFont;
    self.sharedAPI.barTitleFont = barTitleFont;
}

- (void)setBackgroundImgName:(NSString *)backgroundImgName {
    _backgroundImgName = backgroundImgName;
    self.sharedAPI.backgroundImgName = backgroundImgName;
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
    _backgroundColor = backgroundColor;
    self.sharedAPI.backgroundColor = backgroundColor;
}

- (void)setIsNavLeftSubTitle:(BOOL)isNavLeftSubTitle {
    _isNavLeftSubTitle = isNavLeftSubTitle;
    self.sharedAPI.isNavLeftSubTitle = isNavLeftSubTitle;
}

- (void)setShowBottomBarWhenPushed:(BOOL)showBottomBarWhenPushed {
    _showBottomBarWhenPushed = showBottomBarWhenPushed;
    self.sharedAPI.showBottomBarWhenPushed = showBottomBarWhenPushed;
}

- (void)setIsHideNavBar:(BOOL)isHideNavBar {
    _isHideNavBar = isHideNavBar;
    self.sharedAPI.isHideNavBar = isHideNavBar;
}

- (void)setReturnBeforeData:(id)returnBeforeData {
    _returnBeforeData = returnBeforeData;
    self.sharedAPI.returnBeforeData = returnBeforeData;
}

- (void)setNextViewController:(UIViewController *)nextViewController {
    _nextViewController = nextViewController;
    self.sharedAPI.nextViewController = nextViewController;
}

- (void)setReturnBeforeOption:(void (^)(id _Nullable))returnBeforeOption {
    _returnBeforeOption = returnBeforeOption;
    self.sharedAPI.returnBeforeOption = returnBeforeOption;
}

- (void)setReturnAfterOption:(void (^)(void))returnAfterOption {
    _returnAfterOption = returnAfterOption;
    self.sharedAPI.returnAfterOption = returnAfterOption;
}

#pragma mark - 仅get

- (BOOL)isVisible {
    return self.sharedAPI.isVisible;
}

- (UIImageView *)backgroundImgView {
    return self.sharedAPI.backgroundImgView;
}

#pragma mark - ButtonAction

- (void)navRightBtnAction {
    [self.sharedAPI navRightBtnAction];
}

- (void)navRightSubBtnAction {
    [self.sharedAPI navRightSubBtnAction];
}

- (void)navLeftBtnAction {
    [self.sharedAPI navLeftBtnAction];
}

- (void)navLeftSubBtnAction {
    [self.sharedAPI navLeftSubBtnAction];
}

#pragma mark - UINavigationControllerDelegate

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    [self.sharedAPI viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
}

#pragma mark - 强制横竖屏切换

- (void)interfaceOrientation:(UIInterfaceOrientation)orientation errorHandler:(nullable void (^)(NSError *error))errorHandler {
    [self.sharedAPI interfaceOrientation:orientation errorHandler:errorHandler];
}

- (UIInterfaceOrientation)interfaceOrientation {
    return self.sharedAPI.interfaceOrientation;
}

#pragma mark - ZJBaseVCSharedAPIDelegate

- (ZJBaseVCSharedAPI *)sharedAPI {
    if (!_sharedAPI) {
        _sharedAPI = [[ZJBaseVCSharedAPI alloc] init];
        _sharedAPI.delegate = self;
    }
    return _sharedAPI;
}

- (ZJBaseViewController *)currentSharedVC {
    return self;
}

@end
