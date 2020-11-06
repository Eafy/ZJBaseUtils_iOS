//
//  ZJBaseTableViewController.m
//  ZJBaseUtils
//
//  Created by eafy on 2020/9/14.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import "ZJBaseTableViewController.h"
#import "ZJSettingItem.h"
#import "ZJScreen.h"
#import "ZJSystem.h"
#import "UIView+ZJFrame.h"
#import "ZJLocalizationTool.h"
#import "NSString+ZJExt.h"
#import "ZJBaseTableViewConfig+ZJExt.h"

@interface ZJBaseTableViewController () <UIGestureRecognizerDelegate,UINavigationControllerDelegate>

@property (nonatomic,assign) BOOL isLeftSideslipBack;     //是左侧边栏右滑返回
@property (nonatomic,strong) NSArray * _Nullable datasArray;      //TableView数据源

@end

@implementation ZJBaseTableViewController

#pragma mark - 下面和ZJBaseViewController完全一致

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:self.isHideNavBar animated:YES];
    self.isLeftSideslipBack = NO;
    
    [self initNavigationBar];
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
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    
    if (self.tableViewConfig.bgColor) {
        self.view.backgroundColor = self.tableViewConfig.bgColor;
    }
    if (self.tableViewConfig.bgTableViewColor) {
        self.tableView.backgroundColor = self.tableViewConfig.bgTableViewColor;
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

#pragma mark - 自定义导航栏视图

- (UIView *)navBarBgView
{
    if (!_navBarBgView) {
        _navBarBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ZJScreenWidth(), ZJStatusBarHeight() + ZJNavBarHeight())];
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
    self.navLeftBtn.zj_top = ZJStatusBarHeight();
    self.navRightBtn.zj_top = ZJStatusBarHeight();
    self.navRightBtn.zj_right = ZJScreenWidth() - 15;
    
    if (self.isShowNavBarBgView) {
        [self.view addSubview:self.navBarBgView];
        
        if (self.navLeftBtn.superview != self.navBarBgView) {
            [self.navLeftBtn removeFromSuperview];
            [self.navRightBtn removeFromSuperview];
            [self.navBarTitleLB removeFromSuperview];
            [self.navBarBgView addSubview:self.navLeftBtn];
            [self.navBarBgView addSubview:self.navRightBtn];
            [self.navBarBgView addSubview:self.navBarTitleLB];            
        }
    } else {
        if (self.navLeftBtn.superview != self.view) {
            [self.navLeftBtn removeFromSuperview];
            [self.navRightBtn removeFromSuperview];
            [self.navBarTitleLB removeFromSuperview];
            [self.view addSubview:self.navLeftBtn];
            [self.view addSubview:self.navRightBtn];
            [self.view addSubview:self.navBarTitleLB];
        }
    }
}

- (void)setIsShowNavBarView:(BOOL)isShowNavBarView
{
    if (!self.isHideNavBar) {
        NSLog(@"The system navigation bar is not hidden, and the custom navigation bar cannot be set!");
        return;
    }
    
    _isShowNavBarView = isShowNavBarView;
    if (isShowNavBarView && !_navBarBgView) {   //显示自定义视图，切之前没有添加自定义视图被拒
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

#pragma mark - ZJBaseTableViewController特有接口

- (instancetype)init
{
    if (self = [super initWithStyle:UITableViewStyleGrouped]) {
        [self initDefaultData];
    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    if (self = [super initWithStyle:UITableViewStyleGrouped]) {
        [self initDefaultData];
    }
    
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        [self initDefaultData];
    }
    
    return self;
}

- (void)initDefaultData
{
    _isLeftSidesliEnable = YES;
    _tableViewConfig = [[ZJBaseTableViewConfig alloc] init];
    self.modalPresentationStyle = UIModalPresentationFullScreen;
}

- (void)setItem:(ZJSettingItem *)item config:(ZJBaseTableViewConfig *)config
{
    _dataObject = item.dataObject;
    _data = item.data;
    _pData = item.pData;
    _tableViewConfig = config;
}

#pragma mark - UITableViewDataLoad

- (NSArray *)setupDatas
{
    NSArray *datasArray = [NSArray array];
    return datasArray;
}

- (void)reloadData
{
    __weak ZJBaseTableViewController *weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        weakSelf.datasArray = [weakSelf setupDatas];
        [weakSelf.tableView reloadData];
    });
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.datasArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    ZJSettingItemGroup *g = self.datasArray[section];
    return g.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZJSettingItemGroup *group = self.datasArray[indexPath.section];
    ZJSettingItem *item = group.items[indexPath.row];
    ZJSettingTableViewCell *cell = [ZJSettingTableViewCell cellWithTableView:tableView item:item config:self.tableViewConfig];

    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];   //立即取消选中

    if (indexPath.section < self.datasArray.count) {
        ZJSettingItemGroup *group = self.datasArray[indexPath.section];
        if (indexPath.row < group.items.count) {
            ZJSettingItem *item = group.items[indexPath.row];
            
            if (item.cellOptionBlock != nil) {
                item.cellOptionBlock(item);
            } else if ([item isKindOfClass:[ZJSettingArrowItem class]]) {
                if (item.destVC) {
                    ZJBaseTableViewController *vc = [[item.destVC alloc] init];
                    vc.title = item.title;
                    
                    if ([vc respondsToSelector:@selector(setItem:config:)]) {
                        [vc setItem:item config:self.tableViewConfig];
                    } else {
                        if (item.dataObject && [vc respondsToSelector:@selector(dataObject)]) {
                            vc.dataObject = item.dataObject;
                        }
                        if (item.data && [vc respondsToSelector:@selector(data)]) {
                            vc.data = item.data;
                        }
                        if (item.pData && [vc respondsToSelector:@selector(pData)]) {
                            vc.pData = item.pData;
                        }
                        if (_tableViewConfig && [vc respondsToSelector:@selector(tableViewConfig)]) {
                            vc.tableViewConfig = self.tableViewConfig;
                        }
                    }
                    
                    [self.navigationController pushViewController:vc animated:YES];
                }
            }
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZJSettingItemGroup *group = self.datasArray[indexPath.section];
    ZJSettingItem *item = group.items[indexPath.row];
    
    CGFloat rowHeight = 54.0f;
    if (self.tableViewConfig.rowHeight) {
        rowHeight = self.tableViewConfig.rowHeight;
    }
    if (self.tableViewConfig) {
        if (self.tableViewConfig.adapterEnable) {
            if (self.tableViewConfig.rowCacheHeight) {
                return self.tableViewConfig.rowCacheHeight;
            } else {
                CGFloat titleHeight = [item.title zj_sizeWithFont:[UIFont systemFontOfSize:16.0f] maxSize:CGSizeMake(ZJScreenWidth()*0.75, rowHeight)].height;
                CGFloat detailTitleHeight = 0;
                if (![NSString zj_isEmpty:item.detailTitle]) {
                    detailTitleHeight = [item.detailTitle zj_sizeWithFont:[UIFont systemFontOfSize:12.0f] maxSize:CGSizeMake(ZJScreenWidth(), rowHeight)].height;
                }

                if (titleHeight + detailTitleHeight + 10.0f > rowHeight) {
                    self.tableViewConfig.rowCacheHeight = rowHeight = titleHeight + detailTitleHeight + 10.0f;
                }
            }
        }
    }
 
    return rowHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return self.tableViewConfig.sectionHeaderHeight ? self.tableViewConfig.sectionHeaderHeight : 50.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    CGFloat footerHeight = 20.0f;
    if (self.tableViewConfig.sectionFooterHeight) {
        footerHeight = self.tableViewConfig.sectionFooterHeight;
    }
    if (self.tableViewConfig) {
        if (self.tableViewConfig.adapterEnable) {
            if (self.tableViewConfig.footerCacheHeight) {
                footerHeight = self.tableViewConfig.footerCacheHeight;
            } else {
                ZJSettingItemGroup *group = self.datasArray[section];
                if (![NSString zj_isEmpty:group.footerTitle]) {
                    CGFloat footerCacheHeight = [group.footerTitle zj_sizeWithFont:[UIFont systemFontOfSize:16.0f] maxSize:CGSizeMake(ZJScreenWidth()-40.0f, 100)].height;
                    if (footerCacheHeight > footerHeight) {
                        self.tableViewConfig.footerCacheHeight = footerHeight = footerCacheHeight;
                    }
                }
            }
        }
    }
    
    if (section == self.datasArray.count - 1) {
        return footerHeight > 0 ? footerHeight : 20.f;
    }
    
    return 0.1f;
}

#pragma mark - 设置CELL组的标题

//设置组头部标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section;
{
    ZJSettingItemGroup *group = self.datasArray[section];
    return group.headerTitle;
}

//设置组底部标题
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    ZJSettingItemGroup *group = self.datasArray[section];
    return group.footerTitle;
}

@end
