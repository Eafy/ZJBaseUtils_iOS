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

/// 是否是模拟器
+ (BOOL)isSimulator;

/// 系统版本
+ (NSString *)systemVersion;

/// 系统型号
+ (NSString *)systemType;

/// 获取Bundle ID
+ (NSString *)appBundleID;

/// 项目名称
+ (NSString *)projectName;

/// App名称
+ (NSString *)appName;

/// App版本
+ (NSString *)appVersion;

/// App编译版本
+ (NSString *)appBuildVersion;

/// 版本字符串转换为整形(每个点占4位，即1000)
/// @param version 版本号，3位纯数字，比如：1.0.0
+ (NSInteger)versionToNumber:(NSString *)version;

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

/// 获取UUID(根据GroupID)
/// @param groupID 为nil时，默认获取bid前2个位
+ (NSString *)getUUIDWithGroupID:(NSString * _Nullable)groupID;

/// 获取UUID(根据GroupID)
/// @param groupID 为nil时，默认获取bid前2个位
/// @param bid 兼容上次的bid
+ (NSString *)getUUIDWithGroupID:(NSString * _Nullable)groupID preBid:(NSString * _Nullable)bid;

/// 移除UUID记录
/// @param groupID groupID 为nil时，默认获取bid前2个位
+ (void)removeUUIDWithGroupId:(NSString * _Nullable)groupID;

#pragma mark -

/// 跳转系统或者APP
/// @param url 需打开的URL链接
+ (BOOL)openUrl:(NSString *)url;

/// 打开设置界面
+ (BOOL)openSetting;

/// 是否有麦克风权限（不申请）
+ (BOOL)canRecordPermission;

/// 请求麦克风权限
/// @param handler 回调
+ (void)requestRecordPermission:(void(^)(BOOL success))handler;

/// 判断摄像机权限（不申请）
+ (BOOL)canCameraPermission;

/// 请求摄像机权限
/// @param handler 回调
+ (void)requestCameraPermission:(void(^)(BOOL success))handler;

/// 判断系统相册权限（不申请）
+ (BOOL)canPhotoPermission;

/// 申请相册权限
/// @param handler 回调
+ (void)requestPhotoPermission:(void(^)(BOOL success))handler;

/// 通知权限（若未申请则会申请）
+ (void)canNotificationPermission:(void(^)(BOOL success))handler;

/// 定位权限（若未申请则会申请）
+ (BOOL)canLocationPermission;

/// 通讯录权限
+ (BOOL)canContactsPermission;

/// 请求通讯录权限
/// @param handler 回调
+ (void)requestContactsPermission:(void(^)(BOOL success))handler;

@end

NS_ASSUME_NONNULL_END
