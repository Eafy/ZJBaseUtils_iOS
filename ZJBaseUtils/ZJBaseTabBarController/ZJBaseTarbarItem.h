//
//  ZJBaseTarbarItem.h
//  ZJBaseUtils
//
//  Created by eafy on 2020/11/14.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <ZJBaseUtils/ZJBaseTabBarConfig.h>

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

@end

NS_ASSUME_NONNULL_END
