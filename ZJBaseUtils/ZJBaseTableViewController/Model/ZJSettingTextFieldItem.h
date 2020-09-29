//
//  ZJSettingTextFieldItem.h
//  ZJBaseUtils
//
//  Created by eafy on 2020/9/29.
//  Copyright © 2020 ZJ<lizhijian_21@163.com>. All rights reserved.
//

#import <ZJBaseUtils/ZJSettingLabelItem.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZJSettingTextFieldItem : ZJSettingLabelItem

/// 占位文字
@property (nonatomic,copy) NSString *placeholder;
/// TextField
@property (nonatomic,strong) UITextField *detailTextField;

@end

NS_ASSUME_NONNULL_END
