//
//  ZJLocalization.h
//  ZJBaseUtils
//
//  Created by eafy on 2020/8/18.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZJSingleton.h"

NS_ASSUME_NONNULL_BEGIN

extern NSString *const kLocalizationLanguageEn;     //英文
extern NSString *const kLocalizationLanguageZh_Hans;     //简体中文
extern NSString *const kLocalizationLanguageRu;     //俄罗斯
extern NSString *const kLocalizationLanguageFr;     //法文
extern NSString *const kLocalizationLanguageIt;     //意大利文
extern NSString *const kLocalizationLanguageEs;     //西班牙文

extern NSString *const kLocalizationLanguageNotiChanged;    //语言变更通知

@interface ZJLocalization : NSObject
singleton_h();

/// 设置本地语言包
/// @param languageStr 本地化语言缩写
- (void)setLanguage:(NSString *)languageStr;

@end

@interface NSString (ZJLocalization)

/// 本地化语言
- (NSString *)localized;

@end

NS_ASSUME_NONNULL_END
