//
//  JMSystem.m
//  JMBaseUtils
//
//  Created by lzj<lizhijian_21@163.com> on 2020/8/18.
//  Copyright © 2020 Jimi. All rights reserved.
//

#import "JMSystem.h"
#import "JMSAMKeychain.h"
#import "NSString+JMExt.h"
#import "NSString+JMMD5.h"

CGFloat JMSysVersion(void) {
    return [[[UIDevice currentDevice] systemVersion] doubleValue];
}

@implementation JMSystem

+ (NSString *)currentLanguage
{
    NSString *preferredLang = [[NSLocale preferredLanguages] objectAtIndex:0];
    return preferredLang;
}

+ (JM_SYS_LANGUAGE_TYPE)currentLanguageType
{
    JM_SYS_LANGUAGE_TYPE type = JM_SYS_LANGUAGE_TYPE_EN;
    NSString *preferredLang = [self currentLanguage];
    if ([preferredLang hasPrefix:@"en"]) {  //英文
        type = JM_SYS_LANGUAGE_TYPE_EN;
    } else if ([preferredLang hasPrefix:@"zh"]) {   //中文
        type = JM_SYS_LANGUAGE_TYPE_ZH_Hans;
    } else if ([preferredLang hasPrefix:@"he"]) {   //希伯来语
        type = JM_SYS_LANGUAGE_TYPE_Hebrew;
    }
    
    return type;
}

+ (NSString *)getUUID
{
    NSString *openUUID = [[NSUserDefaults standardUserDefaults] objectForKey:@"JM_base_utils_device_UUID"];
    if (openUUID == nil) {
        NSString *udidStr = [NSString jm_stringRandomWithSize:64];
        openUUID = [udidStr jm_md5String];

        NSString *bundleID = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleIdentifier"];
        NSString *uniqueKeyItem = [JMSAMKeychain passwordForService:bundleID account:@"JM_base_utils_device_UUID_keychain_account"];
        if (uniqueKeyItem == nil || [uniqueKeyItem length] == 0) {
            uniqueKeyItem = openUUID;
            [JMSAMKeychain setPassword:openUUID forService:bundleID account:@"JM_base_utils_device_UUID_keychain_account"];
        }

        [[NSUserDefaults standardUserDefaults] setObject:uniqueKeyItem forKey:@"JM_base_utils_device_UUID"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        openUUID = uniqueKeyItem;
    }

    return openUUID;
}

+ (NSString *)getUUID:(NSInteger)length
{
    NSString *openUUID = [self getUUID];
    if (length < 64) {
         openUUID = [openUUID substringToIndex:length];
     }

    return openUUID;
}

+ (void)removeUUID
{
    NSString *openUUID = [[NSUserDefaults standardUserDefaults] objectForKey:@"JM_base_utils_device_UUID"];
    if (openUUID != nil) {
        NSString *bundleID = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleIdentifier"];
        NSString *uniqueKeyItem = [JMSAMKeychain passwordForService:bundleID account:@"JM_base_utils_device_UUID_keychain_account"];
        if (uniqueKeyItem != nil || [uniqueKeyItem length] != 0) {
            [JMSAMKeychain deletePasswordForService:bundleID account:@"JM_base_utils_device_UUID_keychain_account"];
        }

        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"JM_base_utils_device_UUID"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

@end
