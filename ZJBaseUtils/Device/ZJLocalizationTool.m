//
//  ZJLocalizationTool.h
//  ZJBaseUtils
//
//  Created by eafy on 2020/8/18.
//  Copyright © 2020 ZJ<lizhijian_21@163.com>. All rights reserved.
//

#import "ZJLocalizationTool.h"

#define kZJLocalizationLanguage @"kZJLocalizationLanguage"

@interface ZJLocalizationTool ()

@property (nonatomic,strong) NSBundle *bundle;
@property (nonatomic,copy) NSString *currentLanguage;

@end

@implementation ZJLocalizationTool
singleton_m();

- (void)initData {
    self.currentLanguage = [self loadLanguageBundle];
}

- (NSString *)valueWithKey:(NSString *)key {
    if (self.bundle) {
        return NSLocalizedStringWithDefaultValue(key, @"Localizable", self.bundle, @"", @"");
    } else {
        return NSLocalizedString(key, comment: @"");
    }
}

- (void)setLanguage:(NSString *)languageStr {
    if (languageStr && [self.currentLanguage isEqualToString:languageStr]) {
        return;
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:languageStr forKey:kZJLocalizationLanguage];
    [[NSUserDefaults standardUserDefaults] synchronize];
    self.currentLanguage = [self loadLanguageBundle];
}

- (NSString *)loadLanguageBundle {
    NSString *defaultLanguage = [[NSUserDefaults standardUserDefaults] objectForKey:kZJLocalizationLanguage];
    NSString *systemLanguage = [[NSLocale preferredLanguages] objectAtIndex:0];
    if (!defaultLanguage || ![defaultLanguage isEqualToString:systemLanguage]) {
        defaultLanguage = systemLanguage;
        [[NSUserDefaults standardUserDefaults] setObject:defaultLanguage forKey:kZJLocalizationLanguage];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    NSString *path = [[NSBundle mainBundle] pathForResource:defaultLanguage ofType:@"lproj"];
    if (path) {
        _bundle = [NSBundle bundleWithPath:path];
    }
    
    return defaultLanguage;
}

#pragma mark -

- (void)setLocaleLanguage:(NSString *)languageStr
{
    [self setLanguage:languageStr];
}

@end

@implementation NSString (JMLocalization)

- (NSString *)localized {
    return [ZJLocalizationTool.shared valueWithKey:self];
}

@end
