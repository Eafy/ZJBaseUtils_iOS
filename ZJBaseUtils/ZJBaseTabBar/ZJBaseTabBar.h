//
//  ZJBaseTabBar.h
//  ZJBaseUtils
//
//  Created by eafy on 2020/11/13.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ZJBaseTabBarDelegate;

@interface ZJBaseTabBar : UIView

@property(nonatomic,weak) id<ZJBaseTabBarDelegate> delegate;

/*
 *  提供给外界创建按键
 *  @param norName:默认状态的图片
 *  @param disName:高亮状态的图片
 */
- (void)addTabBarButtonWithNormalImageName:(NSString *)norName andDisableImageName:(NSString *)disName;

@end

@protocol ZJBaseTabBarDelegate <NSObject>

/**
 *  工具栏按钮被选中, 记录从哪里跳转到哪里. (方便以后做相应特效)
 */
- (void)tabBar:(ZJBaseTabBar *)tabBar selectedFrom:(NSInteger) from to:(NSInteger)to;

@end

NS_ASSUME_NONNULL_END
