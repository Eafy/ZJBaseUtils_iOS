//
//  ZJBaseTarbarItem.h
//  ZJBaseUtils
//
//  Created by eafy on 2020/11/14.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ZJBaseTBConfig.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZJBaseTarbarItem : NSObject

/// 显示控制器
@property (nonatomic, strong) UIViewController * _Nullable viewController;

/// 标题的默认图片
@property (nonatomic, copy) NSString * norImageName;
/// 标题的选中图片
@property (nonatomic, copy) NSString * selImageName;
/// 标题的默认标题
@property (nonatomic, copy) NSString * _Nullable norTitleName;
/// 标题的选中标题
@property (nonatomic, copy) NSString * _Nullable selTitleName;

/// 布局类型
@property (nonatomic, assign) ZJBTBConfigLayoutType layoutType;
/// 动画类型
@property (nonatomic, assign) ZJBTBConfigAnimType animType;

/// 标题的默认颜色 ，默认：#808080
@property (nonatomic, strong) UIColor *norTitleColor;
/// 标题的选中颜色 ，默认： #d81e06
@property (nonatomic, strong) UIColor *selTitleColor;
/// 图片的size ，默认 ：(28*28)
@property (nonatomic, assign) CGSize imageSize;
/// 标题文字大小 ，默认：12.f
@property (nonatomic, assign) CGFloat titleFont;
/// 标题的偏移值 (标题距离底部的距离 默认 2.f)
@property (nonatomic, assign) CGFloat titleOffset;
/// 图片的偏移值 (图片距离顶部的距离 默认 2.f)
@property (nonatomic, assign) CGFloat imageOffset;

@end

NS_ASSUME_NONNULL_END
