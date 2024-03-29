//
//  ZJBaseTableView.h
//  ZJBaseUtils
//
//  Created by eafy on 2020/11/11.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ZJBaseUtils/ZJSettingTableViewCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZJBaseTableView : UITableView

@property (nonatomic, weak, nullable) id <UITableViewDataSource> dataSourceSelf;
@property (nonatomic, weak, nullable) id <UITableViewDelegate> delegateSelf;

@property (readonly) NSArray * _Nullable dataSourceArray;

/// Item或上一个界面透传过来的数据
@property (nonatomic,strong) ZJBaseTVPrivateData *privateData;

- (instancetype)initWithFrame:(CGRect)frame parentViewController:(UIViewController *)parentViewCtl;

/// 加载数据，需要重载
- (NSArray<ZJSettingItemGroup *> *)setupDatas;

/// 设置设局
/// @param setupDatas 数据源
- (void)setSetupDatas:(NSArray<ZJSettingItemGroup *> *)setupDatas;

/// 加载数据(不刷新源数据)
- (void)reloadData;

/// 更新数据
- (void)updateData;

/// 更新集群数据
/// @param section 第几个集群
- (void)updateDataWithSection:(NSUInteger)section;

/// 更新某行数据
/// @param section 第几个集群
/// @param row 行数
- (void)updateDataWithSection:(NSUInteger)section row:(NSUInteger)row;

#pragma mark - 

/// 获取Item
/// @param section 第几段
/// @param row 第几行
- (ZJSettingItem * _Nullable)itemWithSection:(NSUInteger)section row:(NSUInteger)row;

/// 获取Cell
/// @param section 第几段
/// @param row 第几行
- (UITableViewCell *)cellWithSection:(NSUInteger)section row:(NSUInteger)row;

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
