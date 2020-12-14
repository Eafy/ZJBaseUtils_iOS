//
//  ZJBaseUtils.h
//  ZJBaseUtils
//
//  Created by eafy on 2020/8/11.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import "ZJUtilsDef.h"
#import "ZJSingleton.h"
#import "NSDate+ZJExt.h"
#import "NSFileManager+ZJExt.h"
#import "NSObject+ZJExt.h"
#import "NSString+ZJExt.h"
#import "NSString+ZJSHA.h"
#import "NSString+ZJRSA.h"
#import "NSString+ZJAESDES.h"
#import "NSString+ZJMD5.h"
#import "NSString+ZJJSON.h"
#import "NSString+ZJIMGExt.h"
#import "NSData+ZJExt.h"
#import "NSData+ZJRSA.h"
#import "NSData+ZJAESDES.h"
#import "NSDictionary+ZJExt.h"
#import "NSArray+ZJExt.h"
#import "NSThread+ZJExt.h"
#import "CAAnimation+ZJExt.h"

#import "UIColor+ZJExt.h"
#import "UIImage+ZJExt.h"
#import "UIImage+ZJQR.h"

#import "UIView+ZJExt.h"
#import "UIView+ZJFrame.h"
#import "UIView+ZJGesture.h"
#import "UIView+ZJGradient.h"
#import "UIView+ZJShadow.h"
#import "UIButton+ZJExt.h"
#import "UIButton+ZJGradient.h"
#import "UIImageView+ZJExt.h"
#import "UIViewController+ZJExt.h"
#import "ZJTextField.h"
#import "ZJTextView.h"

#import "ZJModelFilter.h"
#import "ZJModelFilterGet.h"
#import "ZJModelFilterSet.h"
#import "ZJModelPairs.h"

#import "ZJThread.h"
#import "ZJSystem.h"
#import "ZJScreen.h"
#import "ZJLocalization.h"
#import "ZJPhoto.h"
#import "ZJPickerView.h"
#import "ZJSlider.h"
#import "ZJAlertView.h"
#import "ZJSheetView.h"
#import "ZJMessageBoard.h"

#import "ZJBaseViewController.h"
#import "ZJBaseNavigationController.h"
#import "ZJBaseTableViewController.h"
#import "ZJBaseTableView.h"
#import "ZJBaseTabBarController.h"



NS_ASSUME_NONNULL_BEGIN

@interface ZJBaseUtils : NSObject

/// 获取bundle包内默认路径
/// @param imageName 图片名称
+ (nullable NSString *)imageNamePath:(NSString * _Nullable)imageName;

/// 获取bundle包内默认图片
/// @param imageName 图片名称
+ (nullable UIImage *)imageNamed:(NSString * _Nullable)imageName;

/// 获取bundle包内默认路径
/// @param bundleName bundle名称
/// @param imageName 图片名称
+ (nullable NSString *)imageNamedPathWithBundle:(NSString *)bundleName imageName:(NSString * _Nullable)imageName;

/// 获取bundle包内默认图片
/// @param bundleName bundle名称
/// @param imageName 图片名称
+ (nullable UIImage *)imageNamedWithBundle:(NSString *)bundleName imageName:(NSString * _Nullable)imageName;

@end

NS_ASSUME_NONNULL_END
