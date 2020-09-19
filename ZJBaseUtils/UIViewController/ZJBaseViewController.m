//
//  ZJBaseViewController.m
//  ZJBaseUtils
//
//  Created by eafy on 2020/9/14.
//  Copyright © 2020 ZJ<lizhijian_21@163.com>. All rights reserved.
//

#import "ZJBaseViewController.h"
#import "ZJScreen.h"
#import "ZJSystem.h"
#import "UIView+ZJFrame.h"

@interface ZJBaseViewController ()  <UIGestureRecognizerDelegate,UINavigationControllerDelegate>

@property (nonatomic,assign) BOOL isLeftSideslipBack;     //是左侧边栏右滑返回

@end

@implementation ZJBaseViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:self.isHideNavBar animated:YES];
    self.isLeftSideslipBack = NO;
    
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
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
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
}

- (instancetype)init
{
    if (self = [super init]) {
        _isLeftSidesliEnable = YES;
        self.modalPresentationStyle = UIModalPresentationFullScreen;
        self.view.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)dealloc {
    [self releaseCtlData];
}

- (void)releaseCtlData
{
    _nextViewController = nil;
    _navRightBtn = nil;
    _navLeftBtn = nil;
    _returnBeforeBlock = nil;
    
    _isLeftSideslipBack = NO;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 懒加载

- (UIButton *)navLeftBtn
{
    if (!_navLeftBtn) {
        UIImage *leftImg = [UIImage imageNamed:@"icon_nav_back_no"];
        _navLeftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, ZJNavBarHeight() + (ZJIsIPad()?30:0), ZJNavBarHeight())];
        [_navLeftBtn setImage:leftImg forState:UIControlStateNormal];
        [_navLeftBtn setImage:[UIImage imageNamed:@"icon_nav_back_sel"] forState:UIControlStateHighlighted];
        [_navLeftBtn.titleLabel setFont:[UIFont systemFontOfSize:14.f*ZJScale()]];
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

- (UIButton *)navRightBtn
{
    if (!_navRightBtn) {
        _navRightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _navRightBtn.frame = CGRectMake(0, 0, ZJNavBarHeight() + (ZJIsIPad()?30:0), ZJNavBarHeight());
        [_navRightBtn.titleLabel setFont:[UIFont systemFontOfSize:14.f*ZJScale()]];
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

- (UILabel *)navBarTitleLB
{
    if (!_navBarTitleLB) {
        _navBarTitleLB = [[UILabel alloc] initWithFrame:CGRectMake(0, ZJStatusBarHeight(), ZJScreenWidth()/2.0, ZJNavBarHeight())];
        _navBarTitleLB.zj_centerX = ZJScreenWidth()/2.0;
        _navBarTitleLB.zj_centerY = ZJStatusBarHeight() + ZJNavBarHeight()/2.0;
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
            }
        }
    }
    
    return _navBarTitleLB;
}

#pragma mark -

- (void)setIsShowNavBarView:(BOOL)isShowNavBarView
{
    if (self.isHideNavBar && !self.isShowNavBarView && self.isShowNavBarView != isShowNavBarView) {
        _isShowNavBarView = isShowNavBarView;
        [self addNavBarBtnForHide];
    }
}

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
    }
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:self.barTitleColor, NSForegroundColorAttributeName,nil]];
}

- (void)setBarTitleFont:(UIFont *)barTitleFont
{
    _barTitleFont = barTitleFont;
    if (_navBarTitleLB) {
        self.navBarTitleLB.font = barTitleFont;
    }
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:self.barTitleFont, NSFontAttributeName,nil]];
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
        self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    }
    if (!self.isHideNavBar && !self.navigationItem.rightBarButtonItem) {
        UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.navRightBtn];
        self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    }
    //去除NavigationBar底部黑线颜色
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
}

- (void)addNavBarBtnForHide
{
    self.navLeftBtn.frame = CGRectMake(15, ZJStatusBarHeight(), self.navLeftBtn?self.navLeftBtn.zj_width: (ZJNavBarHeight() + (ZJIsIPad()?30:0)), ZJNavBarHeight());
    [self.view addSubview:self.navLeftBtn];
    
    self.navRightBtn.frame = CGRectMake(0, ZJStatusBarHeight(), self.navRightBtn?self.navRightBtn.zj_width:(ZJNavBarHeight() + (ZJIsIPad()?30:0)), ZJNavBarHeight());
    self.navRightBtn.zj_right = ZJScreenWidth() - 15;
    [self.view addSubview:self.navRightBtn];
    
    [self.view addSubview:self.navBarTitleLB];
}


#pragma mark - ButtonAction

//进入子视图
- (void)navRightBtnAction
{
    if (_nextViewController) {
        [self.navigationController pushViewController:_nextViewController animated:YES];
    } else {
        [self clickedNavRightBarButton];
    }
}

//返回动画
- (void)navLeftBtnAction
{
    [self.view endEditing:YES];
    if (_returnAfterBlock) {
        self.returnAfterBlock();
    }
    [self releaseCtlData];
    
    if (!self.isLeftSideslipBack) {
        if (self.navigationController.viewControllers.count == 1) {
            [self dismissViewControllerAnimated:YES completion:self.returnAfterBlock];
        } else {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    self.isLeftSideslipBack = NO;
}

- (void)clickedNavRightBarButton
{
    
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
