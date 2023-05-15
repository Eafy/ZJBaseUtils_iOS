//
//  NSUserDefaults+ZJExt.m
//  ZJBaseUtils
//
//  Created by eafy on 2023/4/26.
//  Copyright © 2023 ZJ. All rights reserved.
//

#import <ZJBaseUtils/NSUserDefaults+ZJExt.h>
#import <ZJBaseUtils/ZJSystem.h>

static NSString *__gZJGroupIdStr = nil;

@implementation NSUserDefaults (ZJExt)

+ (void)zj_setGroupIdForUserDefaults:(NSString *)groupId {
    __gZJGroupIdStr = groupId;
}

+ (NSUserDefaults *)zj_getUserDefaults {
    if (!__gZJGroupIdStr) {
        __gZJGroupIdStr = [NSString stringWithFormat:@"group.%@", [ZJSystem appBundleID]];
    }
    return [[NSUserDefaults alloc] initWithSuiteName:__gZJGroupIdStr];
}

+ (void)zj_setWidgetValue:(nullable id)value forKey:(nullable NSString *)key {
    if (!key) return;
    NSUserDefaults *userDefaults = [self zj_getUserDefaults];
    [userDefaults setValue:value forKey:key];
    [userDefaults synchronize];
}

+ (void)zj_setWidgetDicValue:(nullable NSDictionary *)dic {
    if (!dic || dic.count == 0) return;
    NSUserDefaults *userDefaults = [self zj_getUserDefaults];
    for (NSString *key in dic.allKeys) {
        [userDefaults setValue:[dic objectForKey:key] forKey:key];
    }
    [userDefaults synchronize];
}

+ (void)zj_removeWidgetValueForKey:(nullable NSString *)key {
    if (!key) return;
    NSUserDefaults *userDefaults = [self zj_getUserDefaults];
    [userDefaults removeObjectForKey:key];
    [userDefaults synchronize];
}

+ (void)zj_removeWidgetValuesForKeys:(nullable NSArray *)keys {
    if (!keys || keys.count == 0) return;
    NSUserDefaults *userDefaults = [self zj_getUserDefaults];
    for (NSString *key in keys) {
        [userDefaults removeObjectForKey:key];
    }
    [userDefaults synchronize];
}

+ (void)zj_removeWidgetAllValue {
    NSUserDefaults *userDefaults = [self zj_getUserDefaults];
    NSDictionary *dic = [userDefaults dictionaryRepresentation];
    for (NSString *key in dic.allKeys) {
        [userDefaults removeObjectForKey:key];
    }
    [userDefaults synchronize];
}

+ (nullable id)zj_widgetValueForKey:(nullable NSString *)key {
    if (!key) return nil;
    NSUserDefaults *userDefaults = [self zj_getUserDefaults];
    return [userDefaults valueForKey:key];
}

@end
