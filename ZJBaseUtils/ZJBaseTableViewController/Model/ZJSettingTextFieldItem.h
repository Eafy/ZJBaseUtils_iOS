//
//  ZJSettingTextFieldItem.h
//  ZJBaseUtils
//
//  Created by eafy on 2020/9/29.
//  Copyright © 2020 ZJ<lizhijian_21@163.com>. All rights reserved.
//

#import "ZJSettingItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZJSettingTextFieldItem : ZJSettingItem

/// 内容
@property (nonatomic,copy) NSString *text;
/// 占位文字
@property (nonatomic,copy) NSString *placeholder;
/// TextField
@property (nonatomic,strong) UITextField *detailTextField;

@end

NS_ASSUME_NONNULL_END
