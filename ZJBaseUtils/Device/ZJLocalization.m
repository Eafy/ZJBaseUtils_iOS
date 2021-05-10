//
//  ZJLocalization.h
//  ZJBaseUtils
//
//  Created by eafy on 2020/8/18.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import "ZJLocalization.h"

NSString *const kLocalizationLanguageEn = @"en";     //英文
NSString *const kLocalizationLanguageZh_Hans = @"zh-Hans";     //简体中文
NSString *const kLocalizationLanguageRu = @"ru";     //俄罗斯
NSString *const kLocalizationLanguageFr = @"fr";     //法文
NSString *const kLocalizationLanguageIt = @"it";     //意大利文
NSString *const kLocalizationLanguageEs = @"es";     //西班牙文

NSString *const kLocalizationLanguage = @"kLocalizationLanguage";
NSString *const kLocalizationLanguageNotiChanged = @"kLocalizationLanguageChanged";    //语言变更通知

@interface ZJLocalization ()

@property (nonatomic,strong) NSBundle *bundle;
@property (nonatomic,copy) NSString *currentLanguage;

@end

@implementation ZJLocalization
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
    
    [[NSUserDefaults standardUserDefaults] setObject:languageStr forKey:kLocalizationLanguage];
    [[NSUserDefaults standardUserDefaults] synchronize];
    self.currentLanguage = [self loadLanguageBundle];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kLocalizationLanguageNotiChanged object:nil];
}

- (NSString *)loadLanguageBundle {
    NSString *defaultLanguage = [[NSUserDefaults standardUserDefaults] objectForKey:kLocalizationLanguage];
    if (!defaultLanguage) {
        defaultLanguage = [[NSLocale preferredLanguages] objectAtIndex:0];
        [[NSUserDefaults standardUserDefaults] setObject:defaultLanguage forKey:kLocalizationLanguage];
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

@implementation NSString (ZJLocalization)

- (NSString *)localized {
    return [ZJLocalization.shared valueWithKey:self];
}

@end
