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
    
    self.tableViewConfig.switchOnTintColor = [UIColor redColor];
}

- (NSArray<JMSettingItemGroup *> *)setupDatas
{
    NSMutableArray *datasArray = [[NSMutableArray alloc] init];
    
    JMSettingItemGroup *group1 = [[JMSettingItemGroup alloc] init];
    NSMutableArray *itemArray = [NSMutableArray array];
    
    JMSettingItem *item = [[JMSettingArrowItem alloc] initWithIcon:@"icon_debugging_success"  title:@"Arrow".localized destClass:nil];
    item.subTitle = @"副标题";
    item.detailTitle = @"详情";
    item.titleHintIcon = @"icon_debugging_fail";
    [itemArray addObject:item];

    item = [[JMSettingArrowItem alloc] initWithIcon:@"icon_debugging_success"  title:@"Arrow有副标题".localized destClass:nil];
    item.subTitle = @"副标题";
    [itemArray addObject:item];

    item = [[JMSettingArrowItem alloc] initWithIcon:@""  title:@"Arrow有详情".localized destClass:nil];
    item.detailTitle = @"详情";
    [itemArray addObject:item];

    item = [[JMSettingSwitchItem alloc] initWithIcon:@"" title:@"Switch"];
    item.subTitle = @"副标题";
    item.detailTitle = @"详情";
    [itemArray addObject:item];

    item = [[JMSettingLabelItem alloc] initWithIcon:@"" title:@"Label"];
    item.subTitle = @"副标题111111111111111";
    item.detailTitle = @"详情22222222222222";
    [itemArray addObject:item];

    JMSettingLabelItem *item2 = [[JMSettingLabelItem alloc] initWithIcon:@"" title:@"CenterLable"];
    item2.subTitle = @"副标题111111111111111";
    item2.detailTitle = @"详情22222222222222";
    item2.isCenterModel = YES;
    [itemArray addObject:item2];
    
    JMSettingTextFieldItem *item1 = [[JMSettingTextFieldItem alloc] initWithIcon:@"" title:@"TextField"];
    item1.subTitle = @"副标题111111111111111";
    item1.detailTitle = @"详情22222222222222";
    item1.placeholder = @"123";
    [itemArray addObject:item1];
    
    
    JMSettingRadioItem *radioItem = [[JMSettingRadioItem alloc] initWithIcon:@"" title:@"Radio"];
    radioItem.subTitle = @"副标题111111111111111";
    radioItem.titleArray = @[@"test1", @"test2"];
    radioItem.stateArray = @[@YES, @NO];
    radioItem.normalIcon = @"icon_debugging_fail";
    radioItem.selectIcon = @"icon_debugging_success";
    radioItem.radioModel = YES;
    [itemArray addObject:radioItem];
    
    group1.items = itemArray;
    [datasArray addObject:group1];
    
    return datasArray;
}

@end
