//
//  ZJBaseNavigationController.h
//  ZJBaseUtils
//
//  Created by eafy on 2020/9/16.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZJBaseNavigationController : UINavigationController

@property (nonatomic, assign) NSArray<Class> *hideNavBarArray;

@end

NS_ASSUME_NONNULL_END
