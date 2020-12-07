//
//  ZJSystem.h
//  ZJBaseUtils
//
//  Created by eafy on 2020/8/18.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, ZJ_SYS_LANGUAGE_TYPE) {   //系统语言类型
    ZJ_SYS_LANGUAGE_TYPE_EN = 0,        //英文
    ZJ_SYS_LANGUAGE_TYPE_ZH_Hans = 1,   //简体中文
    ZJ_SYS_LANGUAGE_TYPE_Hebrew = 2,    //希伯来文
    ZJ_SYS_LANGUAGE_TYPE_Spanish = 3,   //西班牙语
    ZJ_SYS_LANGUAGE_TYPE_German = 4,    //德语
    ZJ_SYS_LANGUAGE_TYPE_French = 5,    //法语
    ZJ_SYS_LANGUAGE_TYPE_Polish = 6,    //波兰文
    ZJ_SYS_LANGUAGE_TYPE_Portuguese = 7,//葡萄牙文
    ZJ_SYS_LANGUAGE_TYPE_Russian = 8,   //俄文
    ZJ_SYS_LANGUAGE_TYPE_Italian = 9,   //意大利文
    ZJ_SYS_LANGUAGE_TYPE_Slovak = 10,   //斯洛伐克文
    ZJ_SYS_LANGUAGE_TYPE_Turkey = 11,   //土耳其文
    ZJ_SYS_LANGUAGE_TYPE_ZH_Hant = 12,  //繁体中文
    ZJ_SYS_LANGUAGE_TYPE_Bulgarian = 13,//保加利亚文
    ZJ_SYS_LANGUAGE_TYPE_Swedish = 14,  //瑞典文
};

extern CGFloat ZJSysVersion(void);

@interface ZJSystem : NSObject

/// 项目名称
+ (NSString *)projectName;

/// App名称
+ (NSString *)appName;

/// App版本
+ (NSString *)appVersion;

/// App编译版本
+ (NSString *)appBuildVersion;

#pragma mark -

/// 获取当前系统语言字符串
+ (NSString *)currentLanguage;

/// 获取当前系统语言类型
+ (ZJ_SYS_LANGUAGE_TYPE)currentLanguageType;

/// 获取系统UUID
+ (NSString *)getUUID;

/// 获取指定长度的UUID
/// @param length UUID长度，最大64位
+ (NSString *)getUUID:(NSInteger)length;

/// 移除UUID记录
+ (void)removeUUID;

#pragma mark -

/// 跳转系统或者APP
/// @param url 需打开的URL链接
+ (BOOL)openUrl:(NSString *)url;

/// 打开设置界面
+ (BOOL)openSetting;

/// 麦克风权限（若未申请则会申请）
+ (BOOL)canRecordPermission;

/// 摄像机权限（若未申请则会申请）
+ (BOOL)canCameraPermission;

/// 系统相册权限（若未申请则会申请）
+ (BOOL)canPhotoPermission;

/// 通知权限（若未申请则会申请）
+ (BOOL)canNotificationPermission;

/// 定位权限（若未申请则会申请）
+ (BOOL)canLocationPermission;

@end

NS_ASSUME_NONNULL_END
