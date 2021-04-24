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
#import "ZJLocalization.h"
#import "NSString+ZJExt.h"

@interface ZJBaseTableView () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSArray * _Nullable datasArray;      //TableView数据源
@property (nonatomic,strong) UIViewController *currentViewController;

@end

@implementation ZJBaseTableView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
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

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
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

- (NSArray<ZJSettingItemGroup *> *)setupDatas
{
    return self.datasArray;
}

- (void)setSetupDatas:(NSArray<ZJSettingItemGroup *> *)setupDatas {
    self.datasArray = setupDatas;
    if (setupDatas.count == 0 && !self.tableFooterView) {
        self.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    }
    [super reloadData];
}

- (void)reloadData
{
    if (!self.privateData.config.lineColor) {
        self.privateData.config.lineColor = self.backgroundColor;
    }
    if (self.datasArray.count == 0) {
        self.datasArray = [self setupDatas];
    }

    if (self.datasArray.count == 0 && !self.tableFooterView) {
        self.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    }
    [super reloadData];
}

- (void)updateData
{
    self.datasArray = [self setupDatas];
    
    __weak ZJBaseTableView *weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakSelf reloadData];
    });
}

#pragma mark - 

- (ZJSettingItem *)itemWithSection:(NSUInteger)section row:(NSUInteger)row
{
    if (section >= self.datasArray.count) return nil;
    ZJSettingItemGroup *group = [self.datasArray objectAtIndex:section];
    if (row >= group.items.count) return nil;
    
    ZJSettingItem *item = [group.items objectAtIndex:row];
    return item;
}

- (UITableViewCell *)cellWithSection:(NSUInteger)section row:(NSUInteger)row
{
    return [self cellForRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:section]];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (_dataSourceSelf && [self.dataSourceSelf respondsToSelector:@selector(numberOfSectionsInTableView:)]) {
        return [self.dataSourceSelf numberOfSectionsInTableView:tableView];
    }
    
    return [ZJBaseTableView numberOfSectionsInTableView:tableView datasArray:self.datasArray];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_dataSourceSelf && [self.dataSourceSelf respondsToSelector:@selector(tableView:numberOfRowsInSection:)]) {
        return [self.dataSourceSelf tableView:tableView numberOfRowsInSection:section];
    }
    
    return [ZJBaseTableView tableView:tableView numberOfRowsInSection:section datasArray:self.datasArray];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_dataSourceSelf && [self.dataSourceSelf respondsToSelector:@selector(tableView:cellForRowAtIndexPath:)]) {
        return [self.dataSourceSelf tableView:tableView cellForRowAtIndexPath:indexPath];
    }
    
    return [ZJBaseTableView tableView:tableView cellForRowAtIndexPath:indexPath datasArray:self.datasArray config:self.privateData.config];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section;
{
    if (_dataSourceSelf && [self.dataSourceSelf respondsToSelector:@selector(tableView:titleForHeaderInSection:)]) {
        return [self.dataSourceSelf tableView:tableView titleForHeaderInSection:section];
    }
    
    return [ZJBaseTableView tableView:tableView titleForHeaderInSection:section datasArray:self.datasArray];
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    if (_dataSourceSelf && [self.dataSourceSelf respondsToSelector:@selector(tableView:titleForFooterInSection:)]) {
        return [self.dataSourceSelf tableView:tableView titleForFooterInSection:section];
    }
    
    return [ZJBaseTableView tableView:tableView titleForFooterInSection:section datasArray:self.datasArray];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_dataSourceSelf && [self.dataSourceSelf respondsToSelector:@selector(tableView:canEditRowAtIndexPath:)]) {
        return [self.dataSourceSelf tableView:tableView canEditRowAtIndexPath:indexPath];
    }
    return NO;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_dataSourceSelf && [self.dataSourceSelf respondsToSelector:@selector(tableView:canMoveRowAtIndexPath:)]) {
        return [self.dataSourceSelf tableView:tableView canMoveRowAtIndexPath:indexPath];
    }
    return NO;
}

- (nullable NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    if (_dataSourceSelf && [self.dataSourceSelf respondsToSelector:@selector(sectionIndexTitlesForTableView:)]) {
        return [self.dataSourceSelf sectionIndexTitlesForTableView:tableView];
    }
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    if (_dataSourceSelf && [self.dataSourceSelf respondsToSelector:@selector(tableView:sectionForSectionIndexTitle:atIndex:)]) {
        return [self.dataSourceSelf tableView:tableView sectionForSectionIndexTitle:title atIndex:index];
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_dataSourceSelf && [self.dataSourceSelf respondsToSelector:@selector(tableView:commitEditingStyle:forRowAtIndexPath:)]) {
        [self.dataSourceSelf tableView:tableView commitEditingStyle:editingStyle forRowAtIndexPath:indexPath];
    }
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    if (_dataSourceSelf && [self.dataSourceSelf respondsToSelector:@selector(tableView:moveRowAtIndexPath:toIndexPath:)]) {
        [self.dataSourceSelf tableView:tableView moveRowAtIndexPath:sourceIndexPath toIndexPath:destinationIndexPath];
    }
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_delegateSelf && [self.delegateSelf respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
        [self.delegateSelf tableView:tableView didSelectRowAtIndexPath:indexPath];
    } else {
        [ZJBaseTableView tableView:tableView didSelectRowAtIndexPath:indexPath datasArray:self.datasArray privateData:self.privateData currentViewController:self.currentViewController];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_delegateSelf && [self.delegateSelf respondsToSelector:@selector(tableView:heightForRowAtIndexPath:)]) {
        return [self.delegateSelf tableView:tableView heightForRowAtIndexPath:indexPath];
    }
    
    return [ZJBaseTableView tableView:tableView heightForRowAtIndexPath:indexPath datasArray:self.datasArray privateData:self.privateData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (_delegateSelf && [self.delegateSelf respondsToSelector:@selector(tableView:heightForHeaderInSection:)]) {
        return [self.delegateSelf tableView:tableView heightForHeaderInSection:section];
    }
    
    return [ZJBaseTableView tableView:tableView heightForHeaderInSection:section privateData:self.privateData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (_delegateSelf && [self.delegateSelf respondsToSelector:@selector(tableView:heightForFooterInSection:)]) {
        return [self.delegateSelf tableView:tableView heightForFooterInSection:section];
    }
    
    return [ZJBaseTableView tableView:tableView heightForFooterInSection:section datasArray:self.datasArray privateData:self.privateData];
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (_delegateSelf && [self.delegateSelf respondsToSelector:@selector(tableView:viewForHeaderInSection:)]) {
        return [self.delegateSelf tableView:tableView viewForHeaderInSection:section];
    }
    return nil;
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
    
    if (config.cornerRadius > 0 || tableView.separatorStyle == UITableViewCellSeparatorStyleNone) {
        NSInteger count = [self tableView:tableView numberOfRowsInSection:indexPath.section datasArray:datasArray];
        
        if (config.cornerRadius > 0) {
            if (count == 1) {
                cell.cornerType = UIRectCornerAllCorners;
            } else if (indexPath.row == 0) {
                cell.cornerType = UIRectCornerTopLeft | UIRectCornerTopRight;
            } else if (indexPath.row == count - 1) {
                cell.cornerType = UIRectCornerBottomLeft | UIRectCornerBottomRight;
            }
        }
        if (tableView.separatorStyle == UITableViewCellSeparatorStyleNone) {
            cell.isShowLine = (indexPath.row != count - 1);
        }
    }

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
            ZJBaseTableViewController *vc = nil;
            BOOL isTableView = NO;
            
            if ([item.destVC isSubclassOfClass:[ZJBaseTableViewController class]]) {
                vc = [(ZJBaseTableViewController *)[item.destVC alloc] initWithStyle:tableView.style];
                isTableView = YES;
            } else {
                vc = [[item.destVC alloc] init];
            }
            vc.title = item.title;
            
            if ([vc respondsToSelector:@selector(privateData)]) {
                vc.privateData = item.privateData ? item.privateData : privateData;
                if (isTableView) {
                    vc.privateData.separatorStyle = tableView.separatorStyle;
                }
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
