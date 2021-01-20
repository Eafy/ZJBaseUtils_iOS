//
//  ZJSystem.m
//  ZJBaseUtils
//
//  Created by eafy on 2020/8/18.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import "ZJSystem.h"
#import <AVFoundation/AVFoundation.h>
#import <Photos/Photos.h>
#import <CoreLocation/CoreLocation.h>
#import <UserNotifications/UserNotifications.h>
#import "ZJSAMKeychain.h"
#import "NSString+ZJExt.h"
#import "NSString+ZJMD5.h"

extern CGFloat ZJSysVersion(void) {
    return [[[UIDevice currentDevice] systemVersion] doubleValue];
}

@implementation ZJSystem

+ (BOOL)isSimulator {
    return TARGET_IPHONE_SIMULATOR | TARGET_OS_SIMULATOR;
}

+ (NSString *)projectName {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleNameKey];
}

+ (NSString *)appName {
    NSString *appName = NSLocalizedStringFromTable(@"CFBundleDisplayName", @"InfoPlist", nil);
    if (!appName) {
        appName = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleExecutableKey];
    }
    return appName;
}

+ (NSString *)appVersion {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

+ (NSString *)appBuildVersion {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey];
}

+ (NSInteger)versionToNumber:(NSString *)version {
    if (!version) return 0;
    NSInteger versionValue = 0;
    NSInteger indexIn = 1;
    
    NSArray *versionArray = [version componentsSeparatedByString:@"."];
    for (int i=0; i<versionArray.count; i++) {
        NSString *ver = [versionArray objectAtIndex:(versionArray.count-1-i)];
        indexIn *= 1000;
        versionValue += [ver integerValue] * indexIn;
    }
    return versionValue;
}

#pragma mark -

+ (NSString *)currentLanguage
{
    NSString *preferredLang = [[NSLocale preferredLanguages] objectAtIndex:0];
    return preferredLang;
}

+ (ZJ_SYS_LANGUAGE_TYPE)currentLanguageType
{
    ZJ_SYS_LANGUAGE_TYPE type = ZJ_SYS_LANGUAGE_TYPE_EN;
    NSString *preferredLang = [self currentLanguage];
    if ([preferredLang hasPrefix:@"en"]) {  //英文
        type = ZJ_SYS_LANGUAGE_TYPE_EN;
    } else if ([preferredLang hasPrefix:@"zh"]) {   //中文
        type = ZJ_SYS_LANGUAGE_TYPE_ZH_Hans;
    } else if ([preferredLang hasPrefix:@"he"]) {   //希伯来语
        type = ZJ_SYS_LANGUAGE_TYPE_Hebrew;
    }
    
    return type;
}


+ (NSString *)getUUID
{
    NSString *openUUID = [[NSUserDefaults standardUserDefaults] objectForKey:@"zj_base_utils_device_UUID"];
    if (openUUID == nil) {
        NSString *udidStr = [NSString zj_stringRandomWithSize:64];
        openUUID = [udidStr zj_md5String];

        NSString *bundleID = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleIdentifier"];
        NSString *uniqueKeyItem = [ZJSAMKeychain passwordForService:bundleID account:@"zj_base_utils_device_UUID_keychain_account"];
        if (uniqueKeyItem == nil || [uniqueKeyItem length] == 0) {
            uniqueKeyItem = openUUID;
            [ZJSAMKeychain setPassword:openUUID forService:bundleID account:@"zj_base_utils_device_UUID_keychain_account"];
        }

        [[NSUserDefaults standardUserDefaults] setObject:uniqueKeyItem forKey:@"zj_base_utils_device_UUID"];
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
    NSString *openUUID = [[NSUserDefaults standardUserDefaults] objectForKey:@"zj_base_utils_device_UUID"];
    if (openUUID != nil) {
        NSString *bundleID = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleIdentifier"];
        NSString *uniqueKeyItem = [ZJSAMKeychain passwordForService:bundleID account:@"zj_base_utils_device_UUID_keychain_account"];
        if (uniqueKeyItem != nil || [uniqueKeyItem length] != 0) {
            [ZJSAMKeychain deletePasswordForService:bundleID account:@"zj_base_utils_device_UUID_keychain_account"];
        }

        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"zj_base_utils_device_UUID"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

#pragma mark -

+ (BOOL)openUrl:(NSString *)url
{
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:url]]) {
        if (@available(iOS 10.0, *)) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url] options:@{} completionHandler:^(BOOL success) {
            }];
            return YES;
        } else {
            return [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
        }
    } else {
        return NO;
    }
}

+ (BOOL)openSetting
{
    return [self openUrl:UIApplicationOpenSettingsURLString];
}

+ (BOOL)canRecordPermission
{
    __block BOOL bCanRecord = YES;
    AVAudioSession *session = [AVAudioSession sharedInstance];
    if (session.recordPermission == AVAudioSessionRecordPermissionUndetermined) {
        [session requestRecordPermission:^(BOOL granted) {
            bCanRecord = granted;
        }];
    } else if (session.recordPermission == AVAudioSessionRecordPermissionDenied) {
        bCanRecord = NO;
    }
    
    return bCanRecord;
}

+ (BOOL)canCameraPermission
{
    NSNumber *value = [[NSUserDefaults standardUserDefaults] objectForKey:@"kZJBaseUtils_canCameraPermission"];
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    
    if (!value && authStatus == AVAuthorizationStatusNotDetermined) {
        [[NSUserDefaults standardUserDefaults] setObject:@1 forKey:@"kZJBaseUtils_canCameraPermission"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        return  YES;
    } else if (authStatus == AVAuthorizationStatusAuthorized) {
        return YES;
    }

    return NO;
}

+ (BOOL)canPhotoPermission
{
    NSNumber *value = [[NSUserDefaults standardUserDefaults] objectForKey:@"kZJBaseUtils_canPhotoPermission"];
    PHAuthorizationStatus authStatus = PHAuthorizationStatusNotDetermined;
    if (@available(iOS 14.0, *)) {
        authStatus = [PHPhotoLibrary authorizationStatusForAccessLevel:PHAccessLevelReadWrite];
    } else {
        authStatus = [PHPhotoLibrary authorizationStatus];
    }
    
    if (!value && authStatus == PHAuthorizationStatusNotDetermined) {
        [[NSUserDefaults standardUserDefaults] setObject:@1 forKey:@"kZJBaseUtils_canPhotoPermission"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        return  YES;
    } else if (authStatus == PHAuthorizationStatusAuthorized) {
        return YES;
    }

    return NO;
}

+ (void)requestPhotoPermission:(void(^)(BOOL success))handler
{
    if (@available(iOS 14.0, *)) {
        [PHPhotoLibrary requestAuthorizationForAccessLevel:PHAccessLevelReadWrite handler:^(PHAuthorizationStatus status) {
            if (handler) {
                handler(status == PHAuthorizationStatusAuthorized);
            }
        }];
    } else {
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            if (handler) {
                handler(status == PHAuthorizationStatusAuthorized);
            }
        }];
    }
}

+ (BOOL)canNotificationPermission
{
    __block BOOL bCan = YES;
    if (@available(iOS 10.0, *)) {
        [[UNUserNotificationCenter currentNotificationCenter] getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
            if (settings.authorizationStatus == UNAuthorizationStatusDenied) {
                bCan = NO;
            }
        }];
    } else {
        if ([[UIApplication sharedApplication] currentUserNotificationSettings].types == UIUserNotificationTypeNone) {
            bCan = NO;
        }
    }
    
    return bCan;
}

+ (BOOL)canLocationPermission
{
    CLAuthorizationStatus authStatus = [CLLocationManager authorizationStatus];
    if (authStatus == kCLAuthorizationStatusRestricted ||
        authStatus == kCLAuthorizationStatusDenied) {
        return NO;
    } else if (authStatus == kCLAuthorizationStatusNotDetermined) {
        CLLocationManager *cllocation = [[CLLocationManager alloc] init];
        [cllocation requestWhenInUseAuthorization];
        return YES;
    } else {
        return YES;
    }
}


@end
