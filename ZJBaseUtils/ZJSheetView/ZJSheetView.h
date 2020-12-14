//
//  ZJSheetView.h
//  ZJBaseUtils
//
//  Created by eafy on 2020/12/14.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZJSheetAction.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZJSheetView : UIView

/// 标题
@property (nonatomic,copy) NSString * _Nullable title;
/// 标题颜色：0x181E28
@property (nonatomic,strong) UIColor *titleColor;
/// 标题字体：常规16
@property (nonatomic,strong) UIFont *titleFont;

/// 圆角，默认8.0
@property (nonatomic,assign) CGFloat cornerRadius;
/// 背景遮罩透明度，默认0.7
@property (nonatomic,assign) CGFloat maskAlpha;

+ (instancetype)sheetView;

+ (instancetype)sheetViewWithTitle:(NSString * _Nullable)title;

/// 添加按钮
/// @param action 按钮
- (void)addAction:(ZJSheetAction *)action;

/// 添加默认取消选项
- (ZJSheetAction *)addCancelAction;

/// 显示
- (void)show;

/// 移除
- (void)dismiss;

@end

NS_ASSUME_NONNULL_END
