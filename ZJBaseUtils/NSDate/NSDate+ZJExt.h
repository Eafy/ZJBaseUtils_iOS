//
//  NSDate+ZJExt.h
//  ZJBaseUtils
//
//  Created by eafy on 2020/8/11.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 日期格式为 @"yyyy-MM-dd HH:mm:ss"
extern NSString *const NSDateFormat_yyyy_MM_dd_HH_mm_ss;

/// 日期格式为 @"yyyyMMddHHmmss"
extern NSString *const NSDateFormat_yyyyMMddHHmmss;

/// 日期格式为 @"yyyy-MM-dd"
extern NSString *const NSDateFormat_yyyy_MM_dd;

/// 日期格式为 @"dd-MM-yyyy"
extern NSString *const NSDateFormat_dd_MM_yyyy;

/// 日期格式为 @"yyyyMMdd"
extern NSString *const NSDateFormat_yyyyMMdd;

/// 日期格式为 @"yyyy"
extern NSString *const NSDateFormat_Year;

/// 日期格式为 @"MM"
extern NSString *const NSDateFormat_Month;

/// 日期格式为 @"dd"
extern NSString *const NSDateFormat_Day;

/// 日期格式为 @"HH"
extern NSString *const NSDateFormat_Hour;

/// 日期格式为 @"mm"
extern NSString *const NSDateFormat_Min;

/// 日期格式为 @"ss"
extern NSString *const NSDateFormat_Sec;


@interface NSDate (ZJExt)

/// 获取日期字符串
/// @param dateFormatStr 时间格式字符串，如，‘MM-dd’
- (NSString *)zj_toString:(NSString *)dateFormatStr;

/// 转换为本地时区的Date
- (NSDate *)zj_localDate;

/// 转换为0时区的Date
- (NSDate *)zj_utcDate;

/// 获取当月的天数
- (NSUInteger)zj_daysOfMonth;

/// 获取本地时区与0时区的时差时间（秒）
- (NSInteger)zj_intervalFromUTC;

/// 获取当天零点时间
- (NSDate *)zj_zero;

/// 是否为闰年
- (BOOL)zj_isLeapYear;

/// 将时间拆分成具体单位并存入字典
- (NSMutableDictionary *)zj_toTimeDictionary;

/// 将日期格式化字符串转成NSDateFormatter
/// @param dateFormatStr 转换后的NSDateFormatter
- (NSDateFormatter *)zj_utcDateFormatter:(NSString *)dateFormatStr;

#pragma mark - StaticAPI

/// 获取当前时区的时间
+ (NSDate *)zj_localDate;

/// 获取当前UTC的时间
+ (NSDate *)zj_utcDate;

/// 将时间转换为UTC时间
/// @param time 要转的时间，单位秒
+ (NSTimeInterval)zj_utcTime:(NSTimeInterval)time;

/// 将时间转换为当期时区时间
/// @param time 要转的时间，单位秒
+ (NSTimeInterval)zj_localTime:(NSTimeInterval)time;

/// 将某一时间，单位秒，转为日期拆分成具体的时间单位，存入字典
/// @param time 要转的时间，单位秒
+ (NSMutableDictionary *)zj_timeDictionary:(NSTimeInterval)time;

/// 将格式化的字符串时间转换为NSDate
/// @param dateStr 格式化日期
/// @param formatter 格式化字符串
+ (NSDate *)zj_timeFromString:(NSString *)dateStr formatter:(NSString *)formatter;

#pragma mark -

/// 当前年
- (NSInteger)year;
/// 当前月
- (NSInteger)month;
/// 当前天
- (NSInteger)day;
/// 当前小时
- (NSInteger)hour;
/// 当前分钟
- (NSInteger)min;
/// 当前秒
- (NSInteger)sec;

/// 当月天数
- (NSInteger)days;

@end

NS_ASSUME_NONNULL_END
