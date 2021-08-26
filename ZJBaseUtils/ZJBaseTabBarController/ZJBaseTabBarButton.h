//
//  ZJBaseTabBarButton.h
//  ZJBaseUtils
//
//  Created by eafy on 2020/11/13.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ZJBaseUtils/ZJBaseTBBadge.h>
#import <ZJBaseUtils/ZJBaseTarbarItem.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZJBaseTabBarButton : UIControl

/// 参数配置
@property (nonatomic, strong) ZJBaseTarbarItem * _Nullable item;

/// 标注
@property (nonatomic, strong) ZJBaseTBBadge *badge;

/// 全局参数配置
@property (nonatomic, strong) ZJBaseTabBarConfig *config;

/// 是否中心按钮
@property (nonatomic, assign) BOOL isCenter;

@end

NS_ASSUME_NONNULL_END
