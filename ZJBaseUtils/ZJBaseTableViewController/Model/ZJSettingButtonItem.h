//
//  ZJSettingButtonItem.h
//  ZJBaseUtils
//
//  Created by eafy on 2020/12/2.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import <ZJBaseUtils/ZJSettingItem.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZJSettingButtonItem : ZJSettingItem

/// 详情按钮
@property (nonatomic,strong) UIButton *detailBtn;

/// 按钮点击回调
@property (nonatomic,copy) void(^ _Nullable clickedBtnBlock)(UIButton * _Nonnull btn);

/// 默认YES
@property (nonatomic,assign) BOOL enable;

/// 普通样式图片
@property (nonatomic,copy) NSString *imageName;

/// 按钮文字
@property (nonatomic,copy) NSString *btnTitle;
/// 普通样式的文字颜色
@property (nonatomic,strong) UIColor *btnTitleColor;
/// 普通样式的文字字体
@property (nonatomic,strong) UIFont *btnTitleFont;

@end

NS_ASSUME_NONNULL_END
