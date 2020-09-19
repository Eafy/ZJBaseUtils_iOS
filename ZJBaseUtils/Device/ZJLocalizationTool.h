//
//  ZJLocalizationTool.h
//  ZJBaseUtils
//
//  Created by eafy on 2020/8/18.
//  Copyright © 2020 ZJ<lizhijian_21@163.com>. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZJSingleton.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZJLocalizationTool : NSObject
singleton_h();

/// 设置本地语言包
/// @param languageStr 本地化语言缩写
- (void)setLocaleLanguage:(NSString *)languageStr;

@end

@interface NSString (ZJLocalization)

/// 本地化语言
- (NSString *)localized;

@end

NS_ASSUME_NONNULL_END
