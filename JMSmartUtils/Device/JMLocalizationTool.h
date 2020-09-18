//
//  JMLocalizationTool.h
//  JMSmartUtils
//
//  Created by 李治健 on 2020/9/14.
//  Copyright © 2020 Jimi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JMSingleton.h"

NS_ASSUME_NONNULL_BEGIN

@interface JMLocalizationTool : NSObject
singleton_h();

/// 设置本地语言包
/// @param languageStr 本地化语言缩写
- (void)setLocaleLanguage:(NSString *)languageStr;

@end

@interface NSString (JMLocalization)

/// 本地化语言
- (NSString *)localized;

@end

NS_ASSUME_NONNULL_END
