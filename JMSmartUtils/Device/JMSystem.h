//
//  JMSystem.h
//  JMBaseUtils
//
//  Created by lzj<lizhijian_21@163.com> on 2020/8/18.
//  Copyright © 2020 Jimi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, JM_SYS_LANGUAGE_TYPE) {   //系统语言类型
    JM_SYS_LANGUAGE_TYPE_EN = 0,        //英文
    JM_SYS_LANGUAGE_TYPE_ZH_Hans = 1,   //简体中文
    JM_SYS_LANGUAGE_TYPE_Hebrew = 2,    //希伯来文
    JM_SYS_LANGUAGE_TYPE_Spanish = 3,   //西班牙语
    JM_SYS_LANGUAGE_TYPE_German = 4,    //德语
    JM_SYS_LANGUAGE_TYPE_French = 5,    //法语
    JM_SYS_LANGUAGE_TYPE_Polish = 6,    //波兰文
    JM_SYS_LANGUAGE_TYPE_Portuguese = 7,//葡萄牙文
    JM_SYS_LANGUAGE_TYPE_Russian = 8,   //俄文
    JM_SYS_LANGUAGE_TYPE_Italian = 9,   //意大利文
    JM_SYS_LANGUAGE_TYPE_Slovak = 10,   //斯洛伐克文
    JM_SYS_LANGUAGE_TYPE_Turkey = 11,   //土耳其文
    JM_SYS_LANGUAGE_TYPE_ZH_Hant = 12,  //繁体中文
    JM_SYS_LANGUAGE_TYPE_Bulgarian = 13,//保加利亚文
    JM_SYS_LANGUAGE_TYPE_Swedish = 14,  //瑞典文
};

extern CGFloat JMSysVersion(void);

@interface JMSystem : NSObject

/// 获取当前系统语言字符串
+ (NSString *)currentLanguage;

/// 获取当前系统语言类型
+ (JM_SYS_LANGUAGE_TYPE)currentLanguageType;

/// 获取系统UUID
+ (NSString *)getUUID;

/// 获取指定长度的UUID
/// @param length UUID长度，最大64位
+ (NSString *)getUUID:(NSInteger)length;

/// 移除UUID记录
+ (void)removeUUID;

@end

NS_ASSUME_NONNULL_END
