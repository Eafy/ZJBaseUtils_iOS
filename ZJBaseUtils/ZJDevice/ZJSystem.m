//
//  ZJSystem.m
//  ZJBaseUtils
//
//  Created by eafy on 2020/8/18.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import <ZJBaseUtils/ZJSystem.h>
#import <AVFoundation/AVFoundation.h>
#import <Photos/Photos.h>
#import <CoreLocation/CoreLocation.h>
#import <UserNotifications/UserNotifications.h>
#import <sys/utsname.h>
#import <Contacts/Contacts.h>
#import <ZJBaseUtils/ZJSAMKeychain.h>
#import <ZJBaseUtils/NSString+ZJExt.h>
#import <ZJBaseUtils/NSString+ZJMD5.h>

extern CGFloat ZJSysVersion(void) {
    return [[[UIDevice currentDevice] systemVersion] doubleValue];
}

@implementation ZJSystem

+ (BOOL)isSimulator {
    return TARGET_IPHONE_SIMULATOR | TARGET_OS_SIMULATOR;
}

+ (NSString *)systemVersion {
    return [[UIDevice currentDevice] systemVersion];
}

+ (NSString *)systemType {
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSASCIIStringEncoding];
    if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone 2G";
    if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone 3G";
    if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone 3GS";
    if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,2"]) return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,3"]) return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone 4S";
    if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone 5";
    if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone 5";
    if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone 5c";
    if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone 5c";
    if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone 5s";
    if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone 5s";
    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus";
    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone 6";
    if ([platform isEqualToString:@"iPhone8,1"]) return @"iPhone 6s";
    if ([platform isEqualToString:@"iPhone8,2"]) return @"iPhone 6s Plus";
    if ([platform isEqualToString:@"iPhone8,4"]) return @"iPhone SE";
    if ([platform isEqualToString:@"iPhone9,1"]) return @"iPhone 7";
    if ([platform isEqualToString:@"iPhone9,3"]) return @"iPhone 7";
    if ([platform isEqualToString:@"iPhone9,2"]) return @"iPhone 7 Plus";
    if ([platform isEqualToString:@"iPhone9,4"]) return @"iPhone 7 Plus";
    if([platform isEqualToString:@"iPhone10,1"]) return @"iPhone 8";
    if([platform isEqualToString:@"iPhone10,4"]) return @"iPhone 8";
    if([platform isEqualToString:@"iPhone10,2"]) return @"iPhone 8 Plus";
    if([platform isEqualToString:@"iPhone10,5"]) return @"iPhone 8 Plus";
    if([platform isEqualToString:@"iPhone10,3"]) return @"iPhone X";
    if([platform isEqualToString:@"iPhone10,6"]) return @"iPhone X";
    if ([platform isEqualToString:@"iPhone11,8"]) return @"iPhone XR";
    if ([platform isEqualToString:@"iPhone11,2"]) return @"iPhone XS";
    if ([platform isEqualToString:@"iPhone11,6"]) return @"iPhone XS Max";
    if ([platform isEqualToString:@"iPhone11,4"]) return @"iPhone XS Max";
    if ([platform isEqualToString:@"iPhone12,1"]) return @"iPhone 11";
    if ([platform isEqualToString:@"iPhone12,3"]) return @"iPhone 11 Pro";
    if ([platform isEqualToString:@"iPhone12,5"]) return @"iPhone 11 Pro Max";
    if ([platform isEqualToString:@"iPhone12,8"]) return @"iPhone SE(2nd generation)";
    if ([platform isEqualToString:@"iPhone13,1"]) return @"iPhone 12 mini";
    if ([platform isEqualToString:@"iPhone13,2"]) return @"iPhone 12";
    if ([platform isEqualToString:@"iPhone13,3"]) return @"iPhone 12 Pro";
    if ([platform isEqualToString:@"iPhone13,4"]) return @"iPhone 12 Pro Max";
    if ([platform isEqualToString:@"iPhone14,4"]) return @"iPhone 13 mini";
    if ([platform isEqualToString:@"iPhone14,5"]) return @"iPhone 13";
    if ([platform isEqualToString:@"iPhone14,2"]) return @"iPhone 13 Pro";
    if ([platform isEqualToString:@"iPhone14,3"]) return @"iPhone 13 Pro Max";
    if ([platform isEqualToString:@"iPhone14,6"]) return @"iPhone SE 3";
    if ([platform isEqualToString:@"iPhone14,7"]) return @"iPhone 14";
    if ([platform isEqualToString:@"iPhone14,8"]) return @"iPhone 14 Plus";
    if ([platform isEqualToString:@"iPhone15,2"]) return @"iPhone 14 Pro";
    if ([platform isEqualToString:@"iPhone15,3"]) return @"iPhone 14 Pro Max";
    
    if ([platform isEqualToString:@"iPad1,1"]) return @"iPad 1G";
    if ([platform isEqualToString:@"iPad2,1"]) return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,2"]) return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,3"]) return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,4"]) return @"iPad 2";
    if ([platform isEqualToString:@"iPad3,1"]) return @"iPad 3";
    if ([platform isEqualToString:@"iPad3,2"]) return @"iPad 3";
    if ([platform isEqualToString:@"iPad3,3"]) return @"iPad 3";
    if ([platform isEqualToString:@"iPad3,4"]) return @"iPad 4";
    if ([platform isEqualToString:@"iPad3,5"]) return @"iPad 4";
    if ([platform isEqualToString:@"iPad3,6"]) return @"iPad 4";
    if ([platform isEqualToString:@"iPad6,11"]) return @"iPad 5";
    if ([platform isEqualToString:@"iPad6,12"]) return @"iPad 5";
    if ([platform isEqualToString:@"iPad7,5"]) return @"iPad 6";
    if ([platform isEqualToString:@"iPad7,6"]) return @"iPad 6";
    if ([platform isEqualToString:@"iPad7,11"]) return @"iPad 7";
    if ([platform isEqualToString:@"iPad7,12"]) return @"iPad 7";
    if ([platform isEqualToString:@"iPad11,6"]) return @"iPad 8";
    if ([platform isEqualToString:@"iPad11,7"]) return @"iPad 8";
    if ([platform isEqualToString:@"iPad12,1"]) return @"iPad 9";
    if ([platform isEqualToString:@"iPad12,2"]) return @"iPad 9";
    if ([platform isEqualToString:@"iPad13,18"]) return @"iPad 10";
    if ([platform isEqualToString:@"iPad13,19"]) return @"iPad 10";
    
    if ([platform isEqualToString:@"iPad4,1"]) return @"iPad Air";
    if ([platform isEqualToString:@"iPad4,2"]) return @"iPad Air";
    if ([platform isEqualToString:@"iPad4,3"]) return @"iPad Air";
    if ([platform isEqualToString:@"iPad5,3"]) return @"iPad Air 2";
    if ([platform isEqualToString:@"iPad5,4"]) return @"iPad Air 2";
    if ([platform isEqualToString:@"iPad11,3"]) return @"iPad Air 3";
    if ([platform isEqualToString:@"iPad11,4"]) return @"iPad Air 3";
    if ([platform isEqualToString:@"iPad13,1"]) return @"iPad Air 4";
    if ([platform isEqualToString:@"iPad13,2"]) return @"iPad Air 4";
    if ([platform isEqualToString:@"iPad13,16"]) return @"iPad Air 5";
    if ([platform isEqualToString:@"iPad13,17"]) return @"iPad Air 5";
    
    if ([platform isEqualToString:@"iPad2,5"]) return @"iPad Mini 1G";
    if ([platform isEqualToString:@"iPad2,6"]) return @"iPad Mini 1G";
    if ([platform isEqualToString:@"iPad2,7"]) return @"iPad Mini 1G";
    if ([platform isEqualToString:@"iPad4,4"]) return @"iPad Mini 2G";
    if ([platform isEqualToString:@"iPad4,5"]) return @"iPad Mini 2G";
    if ([platform isEqualToString:@"iPad4,6"]) return @"iPad Mini 2G";
    if ([platform isEqualToString:@"iPad4,7"]) return @"iPad Mini 3";
    if ([platform isEqualToString:@"iPad4,8"]) return @"iPad Mini 3";
    if ([platform isEqualToString:@"iPad4,9"]) return @"iPad Mini 3";
    if ([platform isEqualToString:@"iPad5,1"]) return @"iPad Mini 4";
    if ([platform isEqualToString:@"iPad5,2"]) return @"iPad Mini 4";
    if ([platform isEqualToString:@"iPad5,3"]) return @"iPad Mini 4";
    if ([platform isEqualToString:@"iPad11,1"]) return @"iPad Mini 5";
    if ([platform isEqualToString:@"iPad11,2"]) return @"iPad Mini 5";
    if ([platform isEqualToString:@"iPad14,1"]) return @"iPad Mini 6";
    if ([platform isEqualToString:@"iPad14,2"]) return @"iPad Mini 6";
    
    if ([platform isEqualToString:@"iPad6,3"]) return @"iPad Pro 9.7";
    if ([platform isEqualToString:@"iPad6,4"]) return @"iPad Pro 9.7";
    if ([platform isEqualToString:@"iPad7,3"]) return @"iPad Pro 10.5-inch";
    if ([platform isEqualToString:@"iPad7,4"]) return @"iPad Pro 10.5-inch";
    if ([platform isEqualToString:@"iPad6,7"]) return @"iPad Pro 12.9";
    if ([platform isEqualToString:@"iPad6,8"]) return @"iPad Pro 12.9";
    if ([platform isEqualToString:@"iPad8,1"]) return @"iPad Pro 11-inch";
    if ([platform isEqualToString:@"iPad8,2"]) return @"iPad Pro 11-inch";
    if ([platform isEqualToString:@"iPad8,3"]) return @"iPad Pro 11-inch";
    if ([platform isEqualToString:@"iPad8,4"]) return @"iPad Pro 11-inch";
    if ([platform isEqualToString:@"iPad8,9"]) return @"iPad Pro 11-inch 2nd gen";
    if ([platform isEqualToString:@"iPad8,10"]) return @"iPad Pro 11-inch 2nd gen";
    if ([platform isEqualToString:@"iPad13,4"]) return @"iPad Pro 11-inch 3nd gen";
    if ([platform isEqualToString:@"iPad13,5"]) return @"iPad Pro 11-inch 3nd gen";
    if ([platform isEqualToString:@"iPad13,6"]) return @"iPad Pro 11-inch 3nd gen";
    if ([platform isEqualToString:@"iPad13,7"]) return @"iPad Pro 11-inch 3nd gen";
    if ([platform isEqualToString:@"iPad7,1"]) return @"iPad Pro 12.9-inch 2nd gen";
    if ([platform isEqualToString:@"iPad7,2"]) return @"iPad Pro 12.9-inch 2nd gen";
    if ([platform isEqualToString:@"iPad8,5"]) return @"iPad Pro 12.9-inch 3rd gen";
    if ([platform isEqualToString:@"iPad8,6"]) return @"iPad Pro 12.9-inch 3rd gen";
    if ([platform isEqualToString:@"iPad8,7"]) return @"iPad Pro 12.9-inch 3rd gen";
    if ([platform isEqualToString:@"iPad8,8"]) return @"iPad Pro 12.9-inch 3rd gen";
    if ([platform isEqualToString:@"iPad8,11"]) return @"iPad Pro 12.9-inch 4th gen";
    if ([platform isEqualToString:@"iPad8,12"]) return @"iPad Pro 12.9-inch 4th gen";
    if ([platform isEqualToString:@"iPad13,8"]) return @"iPad Pro 12.9-inch 5th gen";
    if ([platform isEqualToString:@"iPad13,9"]) return @"iPad Pro 12.9-inch 5th gen";
    if ([platform isEqualToString:@"iPad13,10"]) return @"iPad Pro 12.9-inch 5th gen";
    if ([platform isEqualToString:@"iPad13,11"]) return @"iPad Pro 12.9-inch 5th gen";
    if ([platform isEqualToString:@"iPad14,5"]) return @"iPad Pro 12.9-inch 6th gen";
    if ([platform isEqualToString:@"iPad14,6"]) return @"iPad Pro 12.9-inch 6th gen";
    
    if ([platform isEqualToString:@"i386"]) return @"iPhone Simulator";
    if ([platform isEqualToString:@"x86_64"]) return @"iPhone Simulator";
    
    if ([platform isEqualToString:@"iPod1,1"]) return @"iPod Touch 1G";
    if ([platform isEqualToString:@"iPod2,1"]) return @"iPod Touch 2G";
    if ([platform isEqualToString:@"iPod3,1"]) return @"iPod Touch 3G";
    if ([platform isEqualToString:@"iPod4,1"]) return @"iPod Touch 4G";
    if ([platform isEqualToString:@"iPod5,1"]) return @"iPod Touch 5G";
    if ([platform isEqualToString:@"iPod7,1"]) return @"iPod Touch 6G";
    if ([platform isEqualToString:@"iPod9,1"]) return @"iPod Touch 7G";
    
    return platform;
}

#pragma mark - 

+ (NSString *)appBundleID {
    return [[NSBundle mainBundle] bundleIdentifier];
}

+ (NSString *)projectName {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleNameKey];
}

+ (NSString *)appName {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] localizedInfoDictionary];
    NSString *appName = [infoDictionary objectForKey:@"CFBundleDisplayName"];
    if (!appName) {
        appName = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];
    }
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
        NSString *bundleID = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleIdentifier"];
        NSString *uniqueKeyItem = [ZJSAMKeychain passwordForService:bundleID account:@"zj_base_utils_device_UUID_keychain_account"];
        if (uniqueKeyItem == nil || [uniqueKeyItem length] == 0) {
            uniqueKeyItem = [[NSString zj_stringRandomWithSize:64] zj_md5String];
            [ZJSAMKeychain setPassword:uniqueKeyItem forService:bundleID account:@"zj_base_utils_device_UUID_keychain_account"];
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

+ (NSString *)getUUIDWithGroupID:(NSString *)groupID
{
    NSString *openUUID = [[NSUserDefaults standardUserDefaults] objectForKey:@"zj_base_utils_device_UUID"];
    if (openUUID == nil) {
        if (!groupID) {
            NSString *bundleID = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleIdentifier"];
            NSArray *idList = [bundleID componentsSeparatedByString:@"."];
            if (idList.count >= 2) {
                groupID = [NSString stringWithFormat:@"%@.%@.*", idList[0], idList[1]];
            }
        }
        
        NSString *uniqueKeyItem = [ZJSAMKeychain passwordForService:groupID account:@"zj_base_utils_device_UUID_keychain_account"];
        if (uniqueKeyItem == nil || [uniqueKeyItem length] == 0) {
            uniqueKeyItem = [[NSString zj_stringRandomWithSize:64] zj_md5String];
            [ZJSAMKeychain setPassword:uniqueKeyItem forService:groupID account:@"zj_base_utils_device_UUID_keychain_account"];
        }

        [[NSUserDefaults standardUserDefaults] setObject:uniqueKeyItem forKey:@"zj_base_utils_device_UUID"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        openUUID = uniqueKeyItem;
    }

    return openUUID;
}

+ (NSString *)getUUIDWithGroupID:(NSString *)groupID preBid:(NSString *)bid
{
    NSString *openUUID = [[NSUserDefaults standardUserDefaults] objectForKey:@"zj_base_utils_device_UUID"];
    if (openUUID == nil) {
        if (!groupID && !bid) {
            NSString *bundleID = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleIdentifier"];
            NSArray *idList = [bundleID componentsSeparatedByString:@"."];
            if (idList.count >= 2) {
                groupID = [NSString stringWithFormat:@"%@.%@.*", idList[0], idList[1]];
            }
        }
        
        NSString *uniqueKeyItem = nil;
        if (bid) {
            uniqueKeyItem = [ZJSAMKeychain passwordForService:bid account:@"zj_base_utils_device_UUID_keychain_account"];
        }
        if (!uniqueKeyItem) {
            uniqueKeyItem = [ZJSAMKeychain passwordForService:groupID account:@"zj_base_utils_device_UUID_keychain_account"];
        }
        
        if (uniqueKeyItem == nil || [uniqueKeyItem length] == 0) {
            uniqueKeyItem = [[NSString zj_stringRandomWithSize:64] zj_md5String];
            [ZJSAMKeychain setPassword:uniqueKeyItem forService:groupID account:@"zj_base_utils_device_UUID_keychain_account"];
        }

        [[NSUserDefaults standardUserDefaults] setObject:uniqueKeyItem forKey:@"zj_base_utils_device_UUID"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        openUUID = uniqueKeyItem;
    }

    return openUUID;
}

+ (void)removeUUIDWithGroupId:(NSString * _Nullable)groupID
{
    NSString *openUUID = [[NSUserDefaults standardUserDefaults] objectForKey:@"zj_base_utils_device_UUID"];
    if (openUUID != nil) {
        if (!groupID) {
            NSString *bundleID = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleIdentifier"];
            NSArray *idList = [bundleID componentsSeparatedByString:@"."];
            if (idList.count >= 2) {
                groupID = [NSString stringWithFormat:@"%@.%@.*", idList[0], idList[1]];
            }
        }
        NSString *uniqueKeyItem = [ZJSAMKeychain passwordForService:groupID account:@"zj_base_utils_device_UUID_keychain_account"];
        if (uniqueKeyItem != nil || [uniqueKeyItem length] != 0) {
            [ZJSAMKeychain deletePasswordForService:groupID account:@"zj_base_utils_device_UUID_keychain_account"];
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
    AVAudioSession *session = [AVAudioSession sharedInstance];
    return session.recordPermission == AVAudioSessionRecordPermissionGranted;
}

+ (void)requestRecordPermission:(void(^)(BOOL success))handler {
    __block BOOL bCanRecord = YES;
    AVAudioSession *session = [AVAudioSession sharedInstance];
    if (session.recordPermission == AVAudioSessionRecordPermissionUndetermined) {
        [session requestRecordPermission:^(BOOL granted) {
            if (handler) handler(granted);
        }];
        return;
    } else if (session.recordPermission == AVAudioSessionRecordPermissionDenied) {
        bCanRecord = NO;
    }
    
    if (handler) handler(bCanRecord);
}

+ (BOOL)canCameraPermission
{
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusAuthorized) {
        return YES;
    }

    return NO;
}

+ (void)requestCameraPermission:(void(^)(BOOL success))handler
{
    if ([self canCameraPermission]) {
        if (handler) {
            dispatch_async(dispatch_get_main_queue(), ^{
                handler(YES);
            });
        }
    } else {
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            if (handler) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    handler(granted);
                });
            }
        }];
    }
}

+ (BOOL)canPhotoPermission
{
    PHAuthorizationStatus authStatus = PHAuthorizationStatusNotDetermined;
    if (@available(iOS 14.0, *)) {
        authStatus = [PHPhotoLibrary authorizationStatusForAccessLevel:PHAccessLevelReadWrite];
    } else {
        authStatus = [PHPhotoLibrary authorizationStatus];
    }
    
    if (authStatus == PHAuthorizationStatusAuthorized) {
        return YES;
    } else if (@available(iOS 14.0, *)) {
        if (authStatus == PHAuthorizationStatusLimited) {
            return YES;
        }
    }

    return NO;
}

+ (void)requestPhotoPermission:(void(^)(BOOL success))handler
{
    if ([self canPhotoPermission]) {
        if (handler) {
            dispatch_async(dispatch_get_main_queue(), ^{
                handler(YES);
            });
        }
    } else if (@available(iOS 14.0, *)) {
        [PHPhotoLibrary requestAuthorizationForAccessLevel:PHAccessLevelReadWrite handler:^(PHAuthorizationStatus status) {
            if (handler) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    handler(status == PHAuthorizationStatusAuthorized || status == PHAuthorizationStatusLimited);
                });
            }
        }];
    } else {
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            if (handler) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    handler(status == PHAuthorizationStatusAuthorized);
                });
            }
        }];
    }
}

+ (void)canNotificationPermission:(void(^)(BOOL success))handler;
{
    __block BOOL bCan = YES;
    if (@available(iOS 10.0, *)) {
        [[UNUserNotificationCenter currentNotificationCenter] getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
            if (settings.authorizationStatus == UNAuthorizationStatusDenied) {
                if (handler) handler(NO);
            } else {
                if (handler) handler(YES);
            }
        }];
    } else {
        if ([[UIApplication sharedApplication] currentUserNotificationSettings].types == UIUserNotificationTypeNone) {
            if (handler) handler(NO);
        } else {
            if (handler) handler(YES);
        }
    }
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

+ (BOOL)canContactsPermission
{
    CNAuthorizationStatus state = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
    if (state == CNAuthorizationStatusDenied ||
        state == CNAuthorizationStatusRestricted) {
        return NO;
    }
    return YES;
}

+ (void)requestContactsPermission:(void(^)(BOOL success))handler
{
    CNAuthorizationStatus state = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
    if (state == kCLAuthorizationStatusNotDetermined) {
        [[[CNContactStore alloc] init] requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if (handler) handler(granted);
        }];
    } else if (handler) {
        handler(NO);
    }
}

@end
