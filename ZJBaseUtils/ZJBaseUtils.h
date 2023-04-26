//
//  ZJBaseUtils.h
//  ZJBaseUtils
//
//  Created by eafy on 2020/8/11.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import <ZJBaseUtils/ZJUtilsDef.h>
#import <ZJBaseUtils/ZJSingleton.h>
#import <ZJBaseUtils/NSDate+ZJExt.h>
#import <ZJBaseUtils/NSFileManager+ZJExt.h>
#import <ZJBaseUtils/NSObject+ZJExt.h>
#import <ZJBaseUtils/NSString+ZJExt.h>
#import <ZJBaseUtils/NSString+ZJSHA.h>
#import <ZJBaseUtils/NSString+ZJRSA.h>
#import <ZJBaseUtils/NSString+ZJAESDES.h>
#import <ZJBaseUtils/NSString+ZJMD5.h>
#import <ZJBaseUtils/NSString+ZJJSON.h>
#import <ZJBaseUtils/NSString+ZJIMGExt.h>
#import <ZJBaseUtils/NSMutableAttributedString+ZJExt.h>
#import <ZJBaseUtils/NSData+ZJExt.h>
#import <ZJBaseUtils/NSData+ZJRSA.h>
#import <ZJBaseUtils/NSData+ZJAESDES.h>
#import <ZJBaseUtils/NSDictionary+ZJExt.h>
#import <ZJBaseUtils/NSArray+ZJExt.h>
#import <ZJBaseUtils/NSThread+ZJExt.h>
#import <ZJBaseUtils/CAAnimation+ZJExt.h>
#import <ZJBaseUtils/NSNumber+ZJExt.h>
#import <ZJBaseUtils/NSUserDefaults+ZJExt.h>

#import <ZJBaseUtils/UIColor+ZJExt.h>
#import <ZJBaseUtils/UIImage+ZJExt.h>
#import <ZJBaseUtils/UIImage+ZJQR.h>
#import <ZJBaseUtils/UISearchBar+ZJExt.h>
#import <ZJBaseUtils/CLLocation+ZJExt.h>

#import <ZJBaseUtils/UIView+ZJExt.h>
#import <ZJBaseUtils/UIView+ZJFrame.h>
#import <ZJBaseUtils/UIView+ZJGesture.h>
#import <ZJBaseUtils/UIView+ZJGradient.h>
#import <ZJBaseUtils/UIView+ZJShadow.h>
#import <ZJBaseUtils/UIView+ZJAnimation.h>
#import <ZJBaseUtils/UIButton+ZJExt.h>
#import <ZJBaseUtils/UIButton+ZJGradient.h>
#import <ZJBaseUtils/UIImageView+ZJExt.h>
#import <ZJBaseUtils/UIViewController+ZJExt.h>
#import <ZJBaseUtils/ZJTextField.h>
#import <ZJBaseUtils/ZJTextView.h>
#import <ZJBaseUtils/ZJSearchBar.h>

#import <ZJBaseUtils/ZJModelFilter.h>
#import <ZJBaseUtils/ZJModelFilterGet.h>
#import <ZJBaseUtils/ZJModelFilterSet.h>
#import <ZJBaseUtils/ZJModelPairs.h>

#import <ZJBaseUtils/ZJBundleRes.h>
#import <ZJBaseUtils/ZJThread.h>
#import <ZJBaseUtils/ZJSystem.h>
#import <ZJBaseUtils/ZJScreen.h>
#import <ZJBaseUtils/ZJLocalization.h>
#import <ZJBaseUtils/ZJPhoto.h>
#import <ZJBaseUtils/ZJPickerView.h>
#import <ZJBaseUtils/ZJSlider.h>
#import <ZJBaseUtils/ZJAlertView.h>
#import <ZJBaseUtils/ZJSheetView.h>
#import <ZJBaseUtils/ZJMessageBoard.h>
#import <ZJBaseUtils/ZJRedDotView.h>
#import <ZJBaseUtils/ZJStepBar.h>
#import <ZJBaseUtils/ZJLine.h>
#import <ZJBaseUtils/ZJInputPlayPwdView.h>
#import <ZJBaseUtils/ZJInputTextView.h>
#import <ZJBaseUtils/ZJSwitch.h>
#import <ZJBaseUtils/ZJButton.h>
#import <ZJBaseUtils/ZJLabel.h>
#import <ZJBaseUtils/ZJSegmentedControl.h>
#import <ZJBaseUtils/ZJUploadView.h>
#import <ZJBaseUtils/ZJCalendarView.h>
#import <ZJBaseUtils/ZJAvatarView.h>
#import <ZJBaseUtils/ZJProgressBar.h>
#import <ZJBaseUtils/ZJSensorManager.h>
#import <ZJBaseUtils/ZJGpsUtils.h>

#import <ZJBaseUtils/ZJBaseViewController.h>
#import <ZJBaseUtils/ZJBaseNavigationController.h>
#import <ZJBaseUtils/ZJBaseTableViewController.h>
#import <ZJBaseUtils/ZJBaseTableView.h>
#import <ZJBaseUtils/ZJBaseTabBarController.h>

@interface ZJBaseUtils : NSObject

/// 配置基础库
+ (void)config;

@end
