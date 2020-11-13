//
//  ZJBaseTabBarController.h
//  ZJBaseUtils
//
//  Created by eafy on 2020/11/13.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZJBaseTabBarController : UITabBarController

//非xib使用，因viewDidLoad需要加载viewControllers
- (instancetype)initWithSubViewControllers:(NSArray *)array;

@end

NS_ASSUME_NONNULL_END
