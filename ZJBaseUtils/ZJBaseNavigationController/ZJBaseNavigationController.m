//
//  ZJBaseNavigationController.m
//  ZJBaseUtils
//
//  Created by eafy on 2020/9/16.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import <ZJBaseUtils/ZJBaseNavigationController.h>
#import <ZJBaseUtils/ZJBaseViewController.h>
#import <ZJBaseUtils/ZJBaseTableViewController.h>
#import <ZJBaseUtils/ZJBaseTabBarController.h>
#import <ZJBaseUtils/ZJScreen.h>

@interface ZJBaseNavigationController () <UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIPanGestureRecognizer *leftPopGestureRecognizer;

@end

@implementation ZJBaseNavigationController

+ (void)handleJumpWithNavigationController:(UINavigationController *)navCtl viewController:(UIViewController *)viewCtl {
    // 判断是否是基础导航控制器
    if ([navCtl isKindOfClass:[ZJBaseNavigationController class]]) {
        ZJBaseNavigationController *nav = (ZJBaseNavigationController *)navCtl;
        
        // 判断是否是基础视图控制器、基础表单控制器
        if ([viewCtl isKindOfClass:[ZJBaseViewController class]] ||
            [viewCtl isKindOfClass:[ZJBaseTableViewController class]] ||
            [viewCtl isKindOfClass:[ZJBaseTabBarController class]]) {
            ZJBaseViewController *vc = (ZJBaseViewController *)viewCtl;    //目标控制器
            
            if (!vc.hidesBottomBarWhenPushed && !vc.showBottomBarWhenPushed && navCtl.topViewController && navCtl.viewControllers.count == 1) {
                vc.hidesBottomBarWhenPushed = YES;
            }
            
            if (nav.navBackImgName) {
                UIImage *img = [vc.navLeftBtn imageForState:UIControlStateNormal];
                if (!img) {
                    [vc.navLeftBtn setImage:[UIImage imageNamed:nav.navBackImgName] forState:UIControlStateNormal];
                }
            }
            
            if (nav.backgroundImgName) vc.backgroundImgName = nav.backgroundImgName;
            if (nav.backgroundColor) vc.backgroundColor = nav.backgroundColor;
            if (nav.barTintColor) vc.barTintColor = nav.barTintColor;
            if (nav.barTitleColor) vc.barTitleColor = nav.barTitleColor;
            if (nav.barTitleFont) vc.barTitleFont = nav.barTitleFont;
            if (nav.isNavLeftSubTitle) vc.isNavLeftSubTitle = [nav.isNavLeftSubTitle boolValue];
        }
    }
}

#pragma mark -

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController {
    if (self = [super initWithRootViewController:rootViewController]) {
        self.leftSlideCustomEdge = ZJScreenWidth()/3.0;
        [self adaptToIOS15];
    }
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.leftSlideCustomEdge = ZJScreenWidth()/3.0;
        [self adaptToIOS15];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.modalPresentationStyle = UIModalPresentationFullScreen;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    [ZJBaseNavigationController handleJumpWithNavigationController:self viewController:viewController];
    
    [super pushViewController:viewController animated:animated];
    if (self.hideNavBarArray && [self.hideNavBarArray containsObject:[self class]]) {
        if ([viewController respondsToSelector:@selector(isHideNavBar)]) {
            [self setNavigationBarHidden:((ZJBaseViewController *)viewController).isHideNavBar animated:YES];
        }
    }
    
    if (self.isLeftSlideCustomEnable && ![self.interactivePopGestureRecognizer.view.gestureRecognizers containsObject:self.leftPopGestureRecognizer]) {
        self.interactivePopGestureRecognizer.enabled = NO;
        [self.interactivePopGestureRecognizer.view addGestureRecognizer:self.leftPopGestureRecognizer];
        NSArray *gesTargets = [self.interactivePopGestureRecognizer valueForKey:@"targets"];
        id popGesTarget = [gesTargets.firstObject valueForKey:@"target"];
        SEL gesTargetsAction = NSSelectorFromString(@"handleNavigationTransition:");
        self.leftPopGestureRecognizer.delegate = self;
        [self.leftPopGestureRecognizer addTarget:popGesTarget action:gesTargetsAction];
    }
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
    _backgroundColor = backgroundColor;
    if (self.viewControllers.count == 1) {
        ZJBaseViewController *viewCtl = self.viewControllers[0];
        if ([viewCtl isKindOfClass:[ZJBaseViewController class]] ||
        [viewCtl isKindOfClass:[ZJBaseTableViewController class]]) {
            viewCtl.backgroundColor = backgroundColor;
        }
    }
}

- (void)setBackgroundImgName:(NSString *)backgroundImgName {
    _backgroundImgName = backgroundImgName;
    if (self.viewControllers.count == 1) {
        ZJBaseViewController *viewCtl = self.viewControllers[0];
        if ([viewCtl isKindOfClass:[ZJBaseViewController class]] ||
        [viewCtl isKindOfClass:[ZJBaseTableViewController class]]) {
            viewCtl.backgroundImgName = backgroundImgName;
        }
    }
}

#pragma mark -

- (UIPanGestureRecognizer *)leftPopGestureRecognizer {
    if (!_leftPopGestureRecognizer) {
        _leftPopGestureRecognizer = [[UIPanGestureRecognizer alloc] init];
        _leftPopGestureRecognizer.maximumNumberOfTouches = 1;
    }
    return _leftPopGestureRecognizer;
}

- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer {
    if (gestureRecognizer != _leftPopGestureRecognizer) {
        return YES;
    }
    if (self.viewControllers.count <= 1) {
        return NO;
    }
    
    ZJBaseViewController *topViewController = self.viewControllers.lastObject;
    if (![topViewController isKindOfClass:[ZJBaseViewController class]] || !topViewController.isLeftSlideEnable) {
        return NO;
    }
    
    CGPoint beginningLocation = [gestureRecognizer locationInView:gestureRecognizer.view];
    if (self.leftSlideCustomEdge > 0 && beginningLocation.x > self.leftSlideCustomEdge) {
        return NO;
    }

    if ([[self valueForKey:@"_isTransitioning"] boolValue]) {
        return NO;
    }
    
    CGPoint translation = [gestureRecognizer translationInView:gestureRecognizer.view];
    BOOL isLeftToRight = [UIApplication sharedApplication].userInterfaceLayoutDirection == UIUserInterfaceLayoutDirectionLeftToRight;
    CGFloat multiplier = isLeftToRight ? 1 : - 1;
    if ((translation.x * multiplier) <= 0) {
        return NO;
    }
    
    return YES;
}

#pragma mark - iOS 15适配

- (void)adaptToIOS15 {
    if (@available(iOS 15.0, *)) {
        UINavigationBarAppearance *appearance = [[UINavigationBarAppearance alloc] init];
        appearance.backgroundColor = [UIColor whiteColor];
        appearance.shadowColor = [UIColor clearColor];
        appearance.backgroundEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleRegular];
        self.navigationBar.scrollEdgeAppearance = appearance;
        self.navigationBar.standardAppearance = appearance;
    }
}

- (void)setBarTintColor:(UIColor *)barTintColor {
    _barTintColor = barTintColor;
    if (!self.barTintColor) return;
    
    self.navigationController.navigationBar.barTintColor = self.barTintColor;
    if (@available(iOS 15.0, *)) {
        UINavigationBarAppearance *appearance = self.navigationController.navigationBar.standardAppearance;
        appearance.backgroundColor = self.barTintColor;
        self.navigationController.navigationBar.scrollEdgeAppearance = appearance;
        self.navigationController.navigationBar.standardAppearance = appearance;
    }
}

- (void)setBarTitleColor:(UIColor *)barTitleColor {
    _barTitleColor = barTitleColor;
    if (!self.barTitleColor) return;
    
    [self updataSysTitleTextAttributes];
    if (@available(iOS 15.0, *)) {
        UINavigationBarAppearance *appearance = self.navigationController.navigationBar.standardAppearance;
        NSMutableDictionary<NSAttributedStringKey, id> *titleTextAttributes = [NSMutableDictionary dictionaryWithDictionary:appearance.titleTextAttributes];
        [titleTextAttributes setValue:self.barTitleColor forKey:NSForegroundColorAttributeName];
        appearance.titleTextAttributes = titleTextAttributes;
        
        self.navigationController.navigationBar.scrollEdgeAppearance = appearance;
        self.navigationController.navigationBar.standardAppearance = appearance;
    }
}

- (void)setBarTitleFont:(UIFont *)barTitleFont {
    _barTitleFont = barTitleFont;
    if (!self.barTitleFont) return;
    
    [self updataSysTitleTextAttributes];
    if (@available(iOS 15.0, *)) {
        UINavigationBarAppearance *appearance = self.navigationController.navigationBar.standardAppearance;
        NSMutableDictionary<NSAttributedStringKey, id> *titleTextAttributes = [NSMutableDictionary dictionaryWithDictionary:appearance.titleTextAttributes];
        [titleTextAttributes setValue:self.barTitleFont forKey:NSFontAttributeName];
        appearance.titleTextAttributes = titleTextAttributes;
        
        self.navigationController.navigationBar.scrollEdgeAppearance = appearance;
        self.navigationController.navigationBar.standardAppearance = appearance;
    }
}

- (void)updataSysTitleTextAttributes {
    NSMutableDictionary<NSAttributedStringKey, id> *titleTextAttributes = [NSMutableDictionary dictionary];
    if (self.navigationController.navigationBar.titleTextAttributes) {
        titleTextAttributes = [NSMutableDictionary dictionaryWithDictionary:self.navigationController.navigationBar.titleTextAttributes];
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
        [self.navigationController.navigationBar setTitleTextAttributes:titleTextAttributes];
    }
}

@end
