//
//  ZJBaseTableViewController.m
//  ZJBaseUtils
//
//  Created by eafy on 2020/9/14.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import <ZJBaseUtils/ZJBaseTableViewController.h>
#import <ZJBaseUtils/ZJSettingItem.h>
#import <ZJBaseUtils/ZJScreen.h>
#import <ZJBaseUtils/ZJSystem.h>
#import <ZJBaseUtils/UIView+ZJFrame.h>
#import <ZJBaseUtils/ZJLocalization.h>
#import <ZJBaseUtils/NSString+ZJExt.h>
#import <ZJBaseUtils/ZJBaseTVConfig.h>
#import <ZJBaseUtils/ZJBaseTableView.h>
#import <ZJBaseUtils/UIColor+ZJExt.h>
#import <ZJBaseUtils/ZJBaseVCSharedAPI.h>

@interface ZJBaseTableViewController ()  <ZJBaseVCSharedAPIDelegate>

@property (nonatomic,strong) ZJBaseVCSharedAPI *sharedAPI;

@property (nonatomic,strong) NSMutableArray * _Nullable datasArray;      //TableView数据源

@end

@implementation ZJBaseTableViewController

#pragma mark - 下面和ZJBaseViewController完全一致

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
    
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    
    self.tableView.separatorStyle = self.privateData.separatorStyle;
    if (self.privateData.config.bgColor) {
        self.view.backgroundColor = self.privateData.config.bgColor;
    }
    if (self.privateData.config.bgTableViewColor) {
        self.tableView.backgroundColor = self.privateData.config.bgTableViewColor;
    }
}

- (void)dealloc {
    [self.sharedAPI releaseData];
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

- (void)interfaceOrientation:(UIInterfaceOrientation)orientation {
    [self.sharedAPI interfaceOrientation:orientation];
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
    return (ZJBaseViewController *)self;
}

#pragma mark - ZJBaseTableViewController特有接口

#pragma mark - iOS 15适配

- (void)adaptToIOS15 {
    if (@available(iOS 15.0, *)) {
        self.tableView.sectionHeaderTopPadding = 0;
    }
}

#pragma mark -

- (instancetype)init {
    if (self = [super initWithStyle:UITableViewStyleGrouped]) {
        [self initDefaultData];
    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewStyle)style {
    if (self = [super initWithStyle:style]) {
        [self initDefaultData];
    }
    
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        [self initDefaultData];
    }
    
    return self;
}

- (void)initDefaultData {
    [self adaptToIOS15];
}

- (ZJBaseTVPrivateData *)privateData {
    if (!_privateData) {
        _privateData = [[ZJBaseTVPrivateData alloc] init];
    }
    return _privateData;
}

#pragma mark - UITableViewDataLoad

- (NSMutableArray *)datasArray {
    if (!_datasArray) {
        _datasArray = [NSMutableArray array];
    }
    return _datasArray;
}

- (NSArray *)dataSourceArray {
    return self.datasArray;
}

- (NSArray<ZJSettingItemGroup *> *)setupDatas {
    return self.datasArray;
}

- (void)reloadData {
    if (!self.privateData.config.lineColor) {
        self.privateData.config.lineColor = self.tableView.backgroundColor;
    }
    
    if (self.datasArray.count == 0) {
        self.datasArray = [NSMutableArray arrayWithArray:[self setupDatas]];
    }
    if (self.datasArray.count == 0 && !self.tableView.tableFooterView) {
        self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    }
    [self.tableView reloadData];
}

- (void)updateData {
    self.datasArray =[NSMutableArray arrayWithArray:[self setupDatas]];
    
    if ([NSThread isMainThread]) {
        [self reloadData];
    } else {
        __weak ZJBaseTableViewController *weakSelf = self;
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf reloadData];
        });
    }
}

- (void)updateDataWithSection:(NSUInteger)section {
    NSArray *array = [self setupDatas];
    if (section >= array.count) return;
    ZJSettingItemGroup *group = [array objectAtIndex:section];
    
    if (section >= self.datasArray.count) return;
    [self.datasArray replaceObjectAtIndex:section withObject:group];
    [self.tableView reloadData];
}

- (void)updateDataWithSection:(NSUInteger)section row:(NSUInteger)row {
    NSArray *array = [self setupDatas];
    if (section >= array.count) return;
    ZJSettingItemGroup *group = [array objectAtIndex:section];
    if (row >= group.items.count) return;
    ZJSettingItem *itemT = [group.items objectAtIndex:row];
    
    if (section >= self.datasArray.count) return;
    group = [self.datasArray objectAtIndex:section];
    [group replaceObjectAtIndex:row withObject:itemT];
    [self.tableView reloadData];
}

#pragma mark -

- (ZJSettingItem *)itemWithSection:(NSUInteger)section row:(NSUInteger)row {
    if (section >= self.datasArray.count) return nil;
    ZJSettingItemGroup *group = [self.datasArray objectAtIndex:section];
    if (row >= group.items.count) return nil;
    
    ZJSettingItem *item = [group.items objectAtIndex:row];
    return item;
}

- (UITableViewCell *)cellWithSection:(NSUInteger)section row:(NSUInteger)row {
    return [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:section]];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [ZJBaseTableView numberOfSectionsInTableView:tableView datasArray:self.datasArray];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [ZJBaseTableView tableView:tableView numberOfRowsInSection:section datasArray:self.datasArray];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [ZJBaseTableView tableView:tableView cellForRowAtIndexPath:indexPath datasArray:self.datasArray config:self.privateData.config];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [ZJBaseTableView tableView:tableView heightForRowAtIndexPath:indexPath datasArray:self.datasArray privateData:self.privateData];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [ZJBaseTableView tableView:tableView didSelectRowAtIndexPath:indexPath datasArray:self.datasArray privateData:self.privateData currentViewController:self];
}

#pragma mark - Header & Footer

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return [ZJBaseTableView tableView:tableView heightForHeaderInSection:section privateData:self.privateData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return [ZJBaseTableView tableView:tableView heightForFooterInSection:section datasArray:self.datasArray privateData:self.privateData];
}

//设置组头部标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [ZJBaseTableView tableView:tableView titleForHeaderInSection:section datasArray:self.datasArray];
}

//设置组底部标题
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    return [ZJBaseTableView tableView:tableView titleForFooterInSection:section datasArray:self.datasArray];
}

@end
