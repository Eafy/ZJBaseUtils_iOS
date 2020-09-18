//
//  JMLocalizationTool.m
//  JMSmartUtils
//
//  Created by 李治健 on 2020/9/14.
//  Copyright © 2020 Jimi. All rights reserved.
//

#import "JMLocalizationTool.h"

#define kLocalizationLanguage @"kLocalizationLanguage"

@interface JMLocalizationTool ()

@property (nonatomic,strong) NSBundle *bundle;
@property (nonatomic,copy) NSString *currentLanguage;

@end

@implementation JMLocalizationTool
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
}

- (NSString *)loadLanguageBundle {
    NSString *defaultLanguage = [[NSUserDefaults standardUserDefaults] objectForKey:kLocalizationLanguage];
    NSString *systemLanguage = [[NSLocale preferredLanguages] objectAtIndex:0];
    if (!defaultLanguage || ![defaultLanguage isEqualToString:systemLanguage]) {
        defaultLanguage = systemLanguage;
        [[NSUserDefaults standardUserDefaults] setObject:defaultLanguage forKey:kLocalizationLanguage];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    NSString *path = [[NSBundle mainBundle] pathForResource:defaultLanguage ofType:@"lproj"];
    if (path) {
        _bundle = [NSBundle bundleWithPath:path];
    }
    
    return defaultLanguage;
}

@end

@implementation NSString (JMLocalization)

- (NSString *)localized {
    return [JMLocalizationTool.shared valueWithKey:self];
}

@end
