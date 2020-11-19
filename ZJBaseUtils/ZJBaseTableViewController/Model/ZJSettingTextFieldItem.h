//
//  ZJSettingTextFieldItem.h
//  ZJBaseUtils
//
//  Created by eafy on 2020/9/29.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import "ZJSettingItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZJSettingTextFieldItem : ZJSettingItem

/// TextField
@property (nonatomic,strong) UITextField *detailTextField;

/// 内容
@property (nonatomic,copy) NSString *text;
/// 占位文字
@property (nonatomic,copy) NSString *placeholder;
/// 占位文字颜色
@property (nonatomic,strong) UIColor *placeholderColor;
/// 占位文字字体
@property (nonatomic,strong) UIFont *placeholderFont;
/// 清除按钮图标
@property (nonatomic,copy) NSString *clearBtnImgName;

@end

NS_ASSUME_NONNULL_END
