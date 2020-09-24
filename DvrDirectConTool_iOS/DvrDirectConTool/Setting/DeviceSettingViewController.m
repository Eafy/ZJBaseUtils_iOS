//
//  DeviceSettingViewController.m
//  DvrDirectConTool
//
//  Created by 李治健 on 2020/9/23.
//  Copyright © 2020 Jimi. All rights reserved.
//

#import "DeviceSettingViewController.h"

@interface DeviceSettingViewController ()

@end

@implementation DeviceSettingViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置".localized;
    
    self.tableViewConfig = [[JMBaseTableViewConfig alloc] init];
    self.tableViewConfig.rowHeight = 56.0;
}

- (NSArray<JMSettingItemGroup *> *)setupDatas
{
    NSMutableArray *datasArray = [[NSMutableArray alloc] init];
    
    JMSettingItemGroup *group1 = [[JMSettingItemGroup alloc] init];
    NSMutableArray *itemArray = [NSMutableArray array];
    JMSettingItem *item = [[JMSettingArrowItem alloc] initWithIcon:@"icon_debugging_success"  title:@"网络设置".localized destClass:nil];
    item.subTitle = @"123sdasadasd";
    item.detailTitle = @"1111111111111111";
    [itemArray addObject:item];
    
    item = [[JMSettingArrowItem alloc] initWithIcon:@""  title:@"网络设置".localized destClass:nil];
    [itemArray addObject:item];
    
    group1.items = itemArray;
    [datasArray addObject:group1];
    
    return datasArray;
}

@end
