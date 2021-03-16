//
//  ZJBaseViewController.m
//  ZJBaseUtils
//
//  Created by eafy on 2020/9/14.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import "ZJBaseViewController.h"
#import "ZJScreen.h"
#import "ZJSystem.h"
#import "UIView+ZJFrame.h"
#import "UIColor+ZJExt.h"
#import "ZJBundleRes.h"

@interface ZJBaseViewController () <UIGestureRecognizerDelegate,UINavigationControllerDelegate>

 /// 是左侧边栏右滑返回
@property (nonatomic,assign) BOOL isLeftSideslipBack;

@property (nonatomic,strong) UIImageView *backgroundImgView;

@end

@implementation ZJBaseViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:self.isHideNavBar animated:YES];
    self.isLeftSideslipBack = NO;
    self.isVisible = YES;
    
    [self initNavigationBar];
    if (self.isShowNavBarView) {
        [self addNavBarBtnForHide];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    self.navigationController.delegate = self;
    self.isLeftSidesliEnable = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.isVisible = NO;
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    self.navigationController.delegate = nil;
    
    if (self.isLeftSideslipBack) {
        [self navLeftBtnAction];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.modalPresentationStyle = UIModalPresentationFullScreen;
    
    self.view.backgroundColor = self.backgroundColor ? self.backgroundColor : [UIColor whiteColor];
    if (_backgroundImgName && !_backgroundImgView) {
        self.backgroundImgName = _backgroundImgName;
    }
}

- (void)dealloc {
    [self releaseCtlData];
}

- (void)releaseCtlData
{
    _nextViewController = nil;
    _navRightBtn = nil;
    _navLeftBtn = nil;
    _returnBeforeOption = nil;
    _returnBeforeData = nil;
    
    _isLeftSideslipBack = NO;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 懒加载

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
        
        [_navLeftBtn.titleLabel setFont:[UIFont systemFontOfSize:14.f*ZJScale()]];
        [_navLeftBtn setTitleColor:ZJColorFromRGB(0x3D7DFF) forState:UIControlStateNormal];
        [_navLeftBtn setBackgroundColor:[UIColor clearColor]];
        [_navLeftBtn addTarget:self action:@selector(navLeftBtnAction) forControlEvents:UIControlEventTouchUpInside];
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
        [_navLeftSubBtn.titleLabel setFont:[UIFont systemFontOfSize:14.f*ZJScale()]];
        [_navLeftSubBtn setTitleColor:ZJColorFromRGB(0x3D7DFF) forState:UIControlStateNormal];
        [_navLeftSubBtn setBackgroundColor:[UIColor clearColor]];
        [_navLeftSubBtn addTarget:self action:@selector(navLeftSubBtnAction) forControlEvents:UIControlEventTouchUpInside];
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
        _navRightBtn.frame = CGRectMake(0, 0, ZJNavBarHeight() + (ZJIsIPad()?30:0), ZJNavBarHeight());
        [_navRightBtn.titleLabel setFont:[UIFont systemFontOfSize:14.f*ZJScale()]];
        [_navRightBtn setTitleColor:ZJColorFromRGB(0x3D7DFF) forState:UIControlStateNormal];
        [_navRightBtn setBackgroundColor:[UIColor clearColor]];
        [_navRightBtn addTarget:self action:@selector(navRightBtnAction) forControlEvents:UIControlEventTouchUpInside];
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
        [_navRightSubBtn.titleLabel setFont:[UIFont systemFontOfSize:14.f*ZJScale()]];
        [_navRightSubBtn setTitleColor:ZJColorFromRGB(0x3D7DFF) forState:UIControlStateNormal];
        [_navRightSubBtn setBackgroundColor:[UIColor clearColor]];
        [_navRightSubBtn addTarget:self action:@selector(navRightSubBtnAction) forControlEvents:UIControlEventTouchUpInside];
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
    }
    
    return _navRightSubBtn;
}

- (UILabel *)navBarTitleLB
{
    if (!_navBarTitleLB) {
        _navBarTitleLB = [[UILabel alloc] initWithFrame:CGRectMake(0, ZJStatusBarHeight(), ZJScreenWidth()/2.0, ZJNavBarHeight())];
        _navBarTitleLB.text = self.title;
        _navBarTitleLB.textAlignment = NSTextAlignmentCenter;
        _navBarTitleLB.backgroundColor = [UIColor clearColor];
        
        NSDictionary *dic = self.navigationController.navigationBar.titleTextAttributes;
        if (self.barTitleColor) {
            _navBarTitleLB.textColor = self.barTitleColor;
        } else {
            UIColor *color = [dic objectForKey:NSForegroundColorAttributeName];
            if (color) {
                _navBarTitleLB.textColor = color;
            }
        }
        if (self.barTitleFont) {
            _navBarTitleLB.font = self.barTitleFont;
        } else {
            UIFont *font = [dic objectForKey:NSFontAttributeName];
            if (font) {
                _navBarTitleLB.font = font;
            } else {
                _navBarTitleLB.font = [UIFont boldSystemFontOfSize:18.0];
            }
        }
        
        [_navBarTitleLB sizeToFit];
        _navBarTitleLB.zj_centerX = ZJScreenWidth()/2.0;
        _navBarTitleLB.zj_centerY = ZJStatusBarHeight() + ZJNavBarHeight()/2.0;
    }
    
    return _navBarTitleLB;
}

#pragma mark -

- (void)setTitle:(NSString *)title
{
    super.title = title;
    if (_navBarTitleLB) {
        self.navBarTitleLB.text = title;
    }
}

- (void)setBarTitleColor:(UIColor *)barTitleColor
{
    _barTitleColor = barTitleColor;
    if (_navBarTitleLB) {
        self.navBarTitleLB.textColor = barTitleColor;
    } else if (self.navigationController) {
        [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:self.barTitleColor, NSForegroundColorAttributeName,nil]];
    }
}

- (void)setBarTitleFont:(UIFont *)barTitleFont
{
    _barTitleFont = barTitleFont;
    if (_navBarTitleLB) {
        if (barTitleFont) {
            self.navBarTitleLB.font = barTitleFont;            
        }
    } else if (self.navigationController) {
        [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:self.barTitleFont, NSFontAttributeName,nil]];
    }
}

- (void)initNavigationBar
{
    NSDictionary<NSAttributedStringKey, id> *navTitleAttDic = [self.navigationController.navigationBar titleTextAttributes];
    if (!self.barTitleColor) {
        self.barTitleColor = [navTitleAttDic objectForKey:NSForegroundColorAttributeName];
    }
    if (!self.barTitleFont) {
        self.barTitleFont = [navTitleAttDic objectForKey:NSFontAttributeName];
    }
    
    if (self.barTintColor) {
        self.navigationController.navigationBar.barTintColor = self.barTintColor;
    }
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:self.barTitleColor,NSForegroundColorAttributeName, self.barTitleFont, NSFontAttributeName, nil]];
    
    if (!self.isHideNavBar && !self.navigationItem.leftBarButtonItem) {
        UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.navLeftBtn];
        if (!_navLeftSubBtn) {
            self.navigationItem.leftBarButtonItem = leftBarButtonItem;
        } else {
            UIBarButtonItem *leftBarButtonItem2 = [[UIBarButtonItem alloc] initWithCustomView:self.navLeftSubBtn];
            self.navigationItem.leftBarButtonItems = @[leftBarButtonItem, leftBarButtonItem2];
        }
    }
    
    if (!self.isHideNavBar && !self.navigationItem.rightBarButtonItem) {
        UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.navRightBtn];
        if (!_navRightSubBtn) {
            self.navigationItem.rightBarButtonItem = rightBarButtonItem;
        } else {
            UIBarButtonItem *rightBarButtonItem2 = [[UIBarButtonItem alloc] initWithCustomView:self.navRightSubBtn];
            self.navigationItem.rightBarButtonItems = @[rightBarButtonItem, rightBarButtonItem2];
        }
    }
    
    //去除NavigationBar底部黑线颜色
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
}

#pragma mark - 自定义导航栏视图

- (UIImageView *)navBarBgView
{
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

- (void)addNavBarBtnForHide
{
    self.navLeftBtn.zj_left = 15.0f;
    self.navLeftBtn.zj_centerY = ZJStatusBarHeight() + ZJNavBarHeight()/2;
    self.navRightBtn.zj_centerY = self.navLeftBtn.zj_centerY;
    self.navRightBtn.zj_right = ZJScreenWidth() - 15;
    
    if (self.isShowNavBarBgView) {
        self.navBarBgView.frame = CGRectMake(0, 0, ZJScreenWidth(), ZJNavStatusBarHeight());
        self.navBarBgView.userInteractionEnabled = YES;
        if (self.navBarBgView.superview != self.view) {
            [self.view addSubview:self.navBarBgView];
        }
    }
    UIView *navView = self.view;
    if (_navBarBgView) {
        navView = self.navBarBgView;
        if (self.navLeftBtn.superview == self.navBarBgView) {
            return;
        }
    } else if (self.navLeftBtn.superview == self.view) {
        return;
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
            if (self.navigationController.viewControllers.count > 1) {
                UIViewController *vc = self.navigationController.viewControllers[self.navigationController.viewControllers.count - 2];
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
    
    [navView addSubview:self.navBarTitleLB];
}

- (void)setIsShowNavBarView:(BOOL)isShowNavBarView
{
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

#pragma mark -

- (void)setBackgroundImgName:(NSString *)backgroundImgName
{
    _backgroundImgName = backgroundImgName;
    if (backgroundImgName && [self isViewLoaded]) {
        UIImage *img = [UIImage imageNamed:backgroundImgName];
        if (img) {
            _backgroundImgView = [[UIImageView alloc] initWithFrame:self.view.bounds];
            _backgroundImgView.image = img;
            _backgroundImgView.contentMode = UIViewContentModeScaleAspectFill;
            [self.view insertSubview:_backgroundImgView atIndex:0];
        }
    }
}

- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    _backgroundColor = backgroundColor;
    if ([self isViewLoaded]) {
        self.view.backgroundColor = backgroundColor;
    }
}

#pragma mark - ButtonAction

//进入子视图
- (void)navRightBtnAction
{
    if (_nextViewController) {
        [self.navigationController pushViewController:_nextViewController animated:YES];
    }
}

- (void)navRightSubBtnAction {
}

//返回动画
- (void)navLeftBtnAction
{
    [self.view endEditing:YES];
    if (_returnBeforeOption) {
        self.returnBeforeOption(self.returnBeforeData);
    }
    [self releaseCtlData];
    
    if (!self.isLeftSideslipBack) {
        if (self.navigationController.viewControllers.count == 1) {
            [self dismissViewControllerAnimated:YES completion:self.returnAfterOption];
            _returnAfterOption = nil;
        } else {
            [self.navigationController popViewControllerAnimated:YES];
            if (_returnAfterOption) {
                self.returnAfterOption();
                _returnAfterOption = nil;
            }
        }
    }
    self.isLeftSideslipBack = NO;
}

- (void)navLeftSubBtnAction {
}

#pragma mark - UINavigationControllerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if ([gestureRecognizer isKindOfClass:[UIScreenEdgePanGestureRecognizer class]]) {
        if (self.isLeftSidesliEnable && self.navigationController.viewControllers.count > 1) {
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
    if (self.navigationController.viewControllers.count > 1) {
        navigationController.interactivePopGestureRecognizer.enabled = YES;
    } else {
        navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}

@end
