//
//  ZJBaseTableView.m
//  ZJBaseUtils
//
//  Created by eafy on 2020/11/11.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import "ZJBaseTableView.h"
#import "ZJBaseTableViewController.h"
#import "ZJScreen.h"
#import "ZJSystem.h"
#import "UIView+ZJFrame.h"
#import "ZJLocalizationTool.h"
#import "NSString+ZJExt.h"

@interface ZJBaseTableView () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSArray * _Nullable datasArray;      //TableView数据源
@property (nonatomic,strong) UIViewController *currentViewController;

@end

@implementation ZJBaseTableView

- (instancetype)init
{
    if (self = [super init]) {
        self.dataSource = self;
        self.delegate = self;
        if (@available(iOS 11.0, *)) {
            self.estimatedRowHeight = 0;
            self.estimatedSectionHeaderHeight = 0;
            self.estimatedSectionFooterHeight = 0;
        }
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame parentViewController:(UIViewController *)parentViewCtl
{
    self = [super initWithFrame:frame style:UITableViewStyleGrouped];
    if (self) {
        self.currentViewController = parentViewCtl;
        self.dataSource = self;
        self.delegate = self;
        if (@available(iOS 11.0, *)) {
            self.estimatedRowHeight = 0;
            self.estimatedSectionHeaderHeight = 0;
            self.estimatedSectionFooterHeight = 0;
        }
    }
    
    return self;
}

- (ZJBaseTVPrivateData *)privateData
{
    if (!_privateData) {
        _privateData = [[ZJBaseTVPrivateData alloc] init];
    }
    return _privateData;
}

#pragma mark - UITableViewDataLoad

- (NSArray *)datasArray {
    if (!_datasArray) {
        _datasArray = [NSArray array];
    }
    return _datasArray;
}

- (NSArray *)setupDatas
{
    return self.datasArray;
}

- (void)reloadData
{
    if (self.datasArray.count == 0) {
        self.datasArray = [self setupDatas];
    }
    __weak ZJBaseTableView *weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        if (weakSelf.datasArray.count == 0 && !weakSelf.tableFooterView) {
            weakSelf.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        }
        [super reloadData];
    });
}

- (void)updateData
{
    self.datasArray = [self setupDatas];
    [self reloadData];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [ZJBaseTableView numberOfSectionsInTableView:tableView datasArray:self.datasArray];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [ZJBaseTableView tableView:tableView numberOfRowsInSection:section datasArray:self.datasArray];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [ZJBaseTableView tableView:tableView cellForRowAtIndexPath:indexPath datasArray:self.datasArray config:self.privateData.config];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [ZJBaseTableView tableView:tableView heightForRowAtIndexPath:indexPath datasArray:self.datasArray privateData:self.privateData];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [ZJBaseTableView tableView:tableView didSelectRowAtIndexPath:indexPath datasArray:self.datasArray privateData:self.privateData currentViewController:self.currentViewController];
}

#pragma mark - Header & Footer

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return [ZJBaseTableView tableView:tableView heightForHeaderInSection:section privateData:self.privateData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return [ZJBaseTableView tableView:tableView heightForFooterInSection:section datasArray:self.datasArray privateData:self.privateData];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section;
{
    return [ZJBaseTableView tableView:tableView titleForHeaderInSection:section datasArray:self.datasArray];
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    return [ZJBaseTableView tableView:tableView titleForFooterInSection:section datasArray:self.datasArray];
}

#pragma mark - 静态实现类

+ (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView datasArray:(NSArray *)datasArray
{
    return datasArray.count;
}

+ (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section datasArray:(NSArray *)datasArray
{
    if (section >= datasArray.count) return 0;
    
    ZJSettingItemGroup *g = datasArray[section];
    return g.items.count;
}

+ (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath datasArray:(NSArray *)datasArray config:(ZJBaseTVConfig *)config
{
    if (indexPath.section >= datasArray.count) return nil;
    
    ZJSettingItemGroup *group = datasArray[indexPath.section];
    if (indexPath.row >= group.items.count) return nil;
    ZJSettingItem *item = group.items[indexPath.row];
    ZJSettingTableViewCell *cell = [ZJSettingTableViewCell cellWithTableView:tableView item:item config:config];

    return cell;
}

+ (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath datasArray:(NSArray *)datasArray privateData:(ZJBaseTVPrivateData *)privateData currentViewController:(UIViewController *)currentViewController
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];   //立即取消选中
    if (indexPath.section >= datasArray.count) return;

    ZJSettingItemGroup *group = datasArray[indexPath.section];
    if (indexPath.row >= group.items.count) return;
    ZJSettingItem *item = group.items[indexPath.row];
    
    if (item.operationHandle != nil) {
        item.operationHandle(item);
    } else if ([item isKindOfClass:[ZJSettingArrowItem class]]) {
        if (item.destVC && currentViewController) {
            ZJBaseTableViewController *vc = [[item.destVC alloc] init];
            vc.title = item.title;
            
            if ([vc respondsToSelector:@selector(privateData)]) {
                vc.privateData = item.privateData ? item.privateData : privateData;
            }
            
            [currentViewController.navigationController pushViewController:vc animated:YES];
        }
    }
}

+ (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath datasArray:(NSArray *)datasArray privateData:(ZJBaseTVPrivateData *)privateData
{
    if (indexPath.section >= datasArray.count) return 0;

    ZJSettingItemGroup *group = datasArray[indexPath.section];
    if (indexPath.row >= group.items.count) return 0;
    ZJSettingItem *item = group.items[indexPath.row];
    
    CGFloat rowHeight = 0;
    ZJBaseTVConfig *config = privateData.config;
    if (!config) return rowHeight;
    
    if (config.rowHeight) {
        rowHeight = config.rowHeight;
    }
    if (config && config.adapterEnable) {
        if (config.rowCacheHeight) {
            return config.rowCacheHeight;
        } else {
            CGFloat titleHeight = [item.title zj_sizeWithFont:[UIFont systemFontOfSize:16.0f] maxSize:CGSizeMake(ZJScreenWidth()*0.75, rowHeight)].height;
            CGFloat detailTitleHeight = 0;
            if (![NSString zj_isEmpty:item.detailTitle]) {
                detailTitleHeight = [item.detailTitle zj_sizeWithFont:[UIFont systemFontOfSize:12.0f] maxSize:CGSizeMake(ZJScreenWidth(), rowHeight)].height;
            }
            
            if (titleHeight + detailTitleHeight + 10.0f > rowHeight) {
                config.rowCacheHeight = rowHeight = titleHeight + detailTitleHeight + 10.0f;
            }
        }
    }
    
    return rowHeight;
}

+ (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section privateData:(ZJBaseTVPrivateData *)privateData
{
    return privateData.config.sectionHeaderHeight ? privateData.config.sectionHeaderHeight : 50.0f;
}

+ (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section datasArray:(NSArray *)datasArray privateData:(ZJBaseTVPrivateData *)privateData
{
    CGFloat footerHeight = 20.0f;
    if (privateData.config.sectionFooterHeight) {
        footerHeight = privateData.config.sectionFooterHeight;
    }
    if (privateData.config && privateData.config.adapterEnable) {
        if (privateData.config.footerCacheHeight) {
            footerHeight = privateData.config.footerCacheHeight;
        } else {
            ZJSettingItemGroup *group = datasArray[section];
            if (![NSString zj_isEmpty:group.footerTitle]) {
                CGFloat footerCacheHeight = [group.footerTitle zj_sizeWithFont:[UIFont systemFontOfSize:16.0f] maxSize:CGSizeMake(ZJScreenWidth()-40.0f, 100)].height;
                if (footerCacheHeight > footerHeight) {
                    privateData.config.footerCacheHeight = footerHeight = footerCacheHeight;
                }
            }
        }
    }
    
    if (section == datasArray.count - 1) {
        return footerHeight > 0 ? footerHeight : 20.f;
    }
    
    return 0.1f;
}

+ (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section datasArray:(NSArray *)datasArray
{
    if (section >= datasArray.count) return nil;
    
    ZJSettingItemGroup *group = datasArray[section];
    return group.headerTitle;
}

+ (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section datasArray:(NSArray *)datasArray
{
    if (section >= datasArray.count) return nil;
    
    ZJSettingItemGroup *group = datasArray[section];
    return group.footerTitle;
}


@end
