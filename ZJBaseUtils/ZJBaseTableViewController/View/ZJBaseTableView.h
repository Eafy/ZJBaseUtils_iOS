//
//  ZJBaseTableView.h
//  ZJBaseUtils
//
//  Created by eafy on 2020/11/11.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZJSettingTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZJBaseTableView : UITableView

@property (nonatomic,strong,readonly) NSArray * _Nullable datasArray;

/// Item或上一个界面透传过来的数据
@property (nonatomic,strong) ZJBaseTVPrivateData *privateData;

- (instancetype)initWithFrame:(CGRect)frame parentViewController:(UIViewController *)parentViewCtl;

/// 加载数据，需要重载
- (NSArray<ZJSettingItemGroup *> *)setupDatas;

/// 加载数据(不刷新源数据)
- (void)reloadData;

/// 更新数据
- (void)updateData;

/// 已存在数据
- (NSArray *)datasArray;

#pragma mark - 提供给ZJBaseTableViewController使用

+ (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView datasArray:(NSArray *)datasArray;
+ (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section datasArray:(NSArray *)datasArray;
+ (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath datasArray:(NSArray *)datasArray config:(ZJBaseTVConfig *)config;
+ (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath datasArray:(NSArray *)datasArray privateData:(ZJBaseTVPrivateData *)privateData currentViewController:(UIViewController *)currentViewController;
+ (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath datasArray:(NSArray *)datasArray privateData:(ZJBaseTVPrivateData *)privateData;
+ (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section privateData:(ZJBaseTVPrivateData *)privateData;
+ (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section datasArray:(NSArray *)datasArray privateData:(ZJBaseTVPrivateData *)privateData;
+ (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section datasArray:(NSArray *)datasArray;
+ (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section datasArray:(NSArray *)datasArray;

@end

NS_ASSUME_NONNULL_END
