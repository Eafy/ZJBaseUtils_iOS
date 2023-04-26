//
//  NSUserDefaults+ZJExt.m
//  ZJBaseUtils
//
//  Created by sean on 2023/4/26.
//  Copyright © 2023 ZJ. All rights reserved.
//

#import <ZJBaseUtils/NSUserDefaults+ZJExt.h>
#import <ZJBaseUtils/ZJSystem.h>

static NSString *__gZJGroupIdStr = nil;

@implementation NSUserDefaults (ZJExt)

+ (void)setGroupIdForUserDefaults:(NSString *)groupId {
    __gZJGroupIdStr = groupId;
}

+ (NSUserDefaults *)getUserDefaults {
    if (!__gZJGroupIdStr) {
        __gZJGroupIdStr = [NSString stringWithFormat:@"group.%@", [ZJSystem appBundleID]];
    }
    return [[NSUserDefaults alloc] initWithSuiteName:__gZJGroupIdStr];
}

+ (void)setWidgetValue:(nullable id)value forKey:(nullable NSString *)key {
    if (!key) return;
    NSUserDefaults *userDefaults = [self getUserDefaults];
    [userDefaults setValue:value forKey:key];
    [userDefaults synchronize];
}

+ (void)setWidgetDicValue:(nullable NSDictionary *)dic {
    if (!dic || dic.count == 0) return;
    NSUserDefaults *userDefaults = [self getUserDefaults];
    for (NSString *key in dic.allKeys) {
        [userDefaults setValue:[dic objectForKey:key] forKey:key];
    }
    [userDefaults synchronize];
}

+ (void)removeWidgetValueForKey:(nullable NSString *)key {
    if (!key) return;
    NSUserDefaults *userDefaults = [self getUserDefaults];
    [userDefaults removeObjectForKey:key];
    [userDefaults synchronize];
}

+ (void)removeWidgetValuesForKeys:(nullable NSArray *)keys {
    if (!keys || keys.count == 0) return;
    NSUserDefaults *userDefaults = [self getUserDefaults];
    for (NSString *key in keys) {
        [userDefaults removeObjectForKey:key];
    }
    [userDefaults synchronize];
}

+ (void)removeWidgetAllValue {
    NSUserDefaults *userDefaults = [self getUserDefaults];
    NSDictionary *dic = [userDefaults dictionaryRepresentation];
    for (NSString *key in dic.allKeys) {
        [userDefaults removeObjectForKey:key];
    }
    [userDefaults synchronize];
}

+ (nullable id)widgetValueForKey:(nullable NSString *)key {
    if (!key) return nil;
    NSUserDefaults *userDefaults = [self getUserDefaults];
    return [userDefaults valueForKey:key];
}

@end
