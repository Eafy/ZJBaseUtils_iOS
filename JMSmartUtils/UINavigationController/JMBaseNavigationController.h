//
//  JMBaseNavigationController.h
//  JMSmartUtils
//
//  Created by 李治健 on 2020/9/16.
//  Copyright © 2020 Jimi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JMBaseNavigationController : UINavigationController

@property (nonatomic, assign) NSArray<Class> *hideNavBarArray;

@end

NS_ASSUME_NONNULL_END
