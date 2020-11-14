//
//  ZJBaseTabBarButton.h
//  ZJBaseUtils
//
//  Created by eafy on 2020/11/13.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZJBaseTBBadge.h"
#import "ZJBaseTarbarItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZJBaseTabBarButton : UIView

/// 是有选中
@property (nonatomic, assign) BOOL selected;

/// 参数配置
@property (nonatomic, strong) ZJBaseTarbarItem * _Nullable item;

/// 标注
@property (nonatomic, strong) ZJBaseTBBadge *badge;

///全局参数配置
@property (nonatomic, strong) ZJBaseTabBarConfig *config;

@end

NS_ASSUME_NONNULL_END
