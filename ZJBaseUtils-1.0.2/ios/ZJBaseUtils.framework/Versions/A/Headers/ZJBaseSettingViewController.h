//
//  ZJBaseSettingViewController.h
//  ZJBaseUtils
//
//  Created by eafy on 2020/9/14.
//  Copyright © 2020 ZJ<lizhijian_21@163.com>. All rights reserved.
//

#import "ZJBaseViewController.h"
#import "ZJBaseTableViewConfig.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZJBaseSettingViewController : ZJBaseViewController

/// 表单全局配置参数
@property (nonatomic,strong) ZJBaseTableViewConfig *tableViewConfig;
/// 需要传递的数据（字典）
@property (nonatomic,strong) NSMutableDictionary  * _Nullable dataDic;
/// 需要传递的数据（对象）
@property (nonatomic) id _Nullable dataObject;
/// 需要传递的数据（指针）
@property (nonatomic,assign) char * _Nullable pData;

@end

NS_ASSUME_NONNULL_END
