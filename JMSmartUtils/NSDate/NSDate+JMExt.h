//
//  NSDate+JMExt.h
//  JMBaseUtils
//
//  Created by lzj<lizhijian_21@163.com> on 2020/8/11.
//  Copyright © 2020 lzj<lizhijian_21@163.com><lizhijian_21@163.com>. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 日期格式为 @"yyyy-MM-dd HH:mm:ss"
extern NSString *NSDateFormat_yyyy_MM_dd_HH_mm_ss(void);

/// 日期格式为 @"yyyyMMddHHmmss"
extern NSString *NSDateFormat_yyyyMMddHHmmss(void);

/// 日期格式为 @"yyyy-MM-dd"
extern NSString *NSDateFormat_yyyy_MM_dd(void);

/// 日期格式为 @"dd-MM-yyyy"
extern NSString *NSDateFormat_dd_MM_yyyy(void);

/// 日期格式为 @"yyyyMMdd"
extern NSString *NSDateFormat_yyyyMMdd(void);

/// 日期格式为 @"yyyy"
extern NSString *NSDateFormat_Year(void);

/// 日期格式为 @"MM"
extern NSString *NSDateFormat_Month(void);

/// 日期格式为 @"dd"
extern NSString *NSDateFormat_Day(void);

/// 日期格式为 @"HH"
extern NSString *NSDateFormat_Hour(void);

/// 日期格式为 @"mm"
extern NSString *NSDateFormat_Min(void);

/// 日期格式为 @"ss"
extern NSString *NSDateFormat_Sec(void);


@interface NSDate (JMExt)

/// 获取日期字符串
/// @param dateFormatStr 时间格式字符串，如，‘MM-dd’
- (NSString *)jm_toString:(NSString *)dateFormatStr;

/// 转换为本地时区的Date
- (NSDate *)jm_localDate;

/// 转换为0时区的Date
- (NSDate *)jm_utcDate;

/// 获取当月的天数
- (NSUInteger)jm_daysOfMonth;

/// 获取本地时区与0时区的时差时间（秒）
- (NSInteger)jm_intervalFromUTC;

/// 获取当天零点时间
- (NSDate *)jm_zero;

/// 是否为闰年
- (BOOL)jm_isLeapYear;

/// 将时间拆分成具体单位并存入字典
- (NSMutableDictionary *)jm_toTimeDictionary;

/// 将日期格式化字符串转成NSDateFormatter
/// @param dateFormatStr 转换后的NSDateFormatter
- (NSDateFormatter *)jm_utcDateFormatter:(NSString *)dateFormatStr;

#pragma mark - StaticAPI

/// 获取当前时区的时间
+ (NSDate *)jm_localDate;

/// 获取当前UTC的时间
+ (NSDate *)jm_utcDate;

/// 将时间转换为UTC时间
/// @param time 要转的时间，单位秒
+ (NSTimeInterval)jm_utcTime:(NSTimeInterval)time;

/// 将时间转换为当期时区时间
/// @param time 要转的时间，单位秒
+ (NSTimeInterval)jm_localTime:(NSTimeInterval)time;

/// 将某一时间，单位秒，转为日期拆分成具体的时间单位，存入字典
/// @param time 要转的时间，单位秒
+ (NSMutableDictionary *)jm_timeDictionary:(NSTimeInterval)time;


@end

NS_ASSUME_NONNULL_END
