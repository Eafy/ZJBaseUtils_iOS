//
//  NSDate+ZJExt.m
//  ZJBaseUtils
//
//  Created by eafy on 2020/8/11.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import "NSDate+ZJExt.h"

@implementation NSDate (ZJExt)

NSString *const NSDateFormat_yyyy_MM_dd_HH_mm_ss = @"yyyy-MM-dd HH:mm:ss";
NSString *const NSDateFormat_yyyyMMddHHmmss = @"yyyyMMddHHmmss";
NSString *const NSDateFormat_yyyy_MM_dd = @"yyyy-MM-dd";
NSString *const NSDateFormat_dd_MM_yyyy = @"dd-MM-yyyy";
NSString *const NSDateFormat_yyyyMMdd = @"yyyyMMdd";

NSString *const NSDateFormat_Time = @"HH:mm:ss";
NSString *const NSDateFormat_Hour_Min = @"HH:mm";
NSString *const NSDateFormat_Min_Sec = @"mm:ss";

NSString *const NSDateFormat_Year = @"yyyy";
NSString *const NSDateFormat_Month = @"MM";
NSString *const NSDateFormat_Day = @"dd";
NSString *const NSDateFormat_Hour = @"HH";
NSString *const NSDateFormat_Min = @"mm";
NSString *const NSDateFormat_Sec = @"ss";

#pragma mark -

- (NSString *)zj_toString:(NSString *)dateFormatStr
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:dateFormatStr];
    return [dateFormat stringFromDate:self];
}

- (NSString *)zj_toUTCString:(NSString *)dateFormatStr
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    [dateFormat setDateFormat:dateFormatStr];
    return [dateFormat stringFromDate:self];
}

- (NSDate *)zj_localDate
{
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:self];
    NSDate *localDate = [self dateByAddingTimeInterval:interval];
    
    return localDate;
}

- (NSDate *)zj_utcDate
{
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:self];
    NSDate *utcDate = [self dateByAddingTimeInterval:-interval];
    
    return utcDate;
}

- (NSUInteger)zj_daysOfMonth
{
    NSCalendar *calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:self];
    return range.length;
}

- (NSInteger)zj_intervalFromUTC
{
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    return [zone secondsFromGMTForDate:self];
}

- (NSDate *)zj_zero
{
    NSCalendar *calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [calendar components:NSUIntegerMax fromDate:self];
    components.hour = 0;
    components.minute = 0;
    components.second = 0;
    components.nanosecond = 0;
    
    NSTimeInterval ts = [[calendar dateFromComponents:components] timeIntervalSince1970];
    return [NSDate dateWithTimeIntervalSince1970:ts];
}

- (NSDate *)zj_monthBegin
{
    NSCalendar *calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [calendar components:NSUIntegerMax fromDate:self];
    components.hour = 0;
    components.minute = 0;
    components.second = 0;
    components.nanosecond = 0;
    components.day = 1;
    
    NSTimeInterval ts = [[calendar dateFromComponents:components] timeIntervalSince1970];
    return [NSDate dateWithTimeIntervalSince1970:ts];
}

- (BOOL)zj_isLeapYear
{
    NSUInteger year = [[self zj_toString:NSDateFormat_Year] integerValue];
    if ((year % 4  == 0 && year % 100 != 0) || year % 400 == 0) {
        return YES;
    }
    return NO;
}

- (NSMutableDictionary *)zj_toTimeDictionary
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    [dateFormat setDateFormat:NSDateFormat_yyyy_MM_dd];
    [dic setObject:[dateFormat stringFromDate:self] forKey:NSDateFormat_yyyy_MM_dd];
    
    [dateFormat setDateFormat:NSDateFormat_Year];
    [dic setObject:[dateFormat stringFromDate:self] forKey:NSDateFormat_Year];
    
    [dateFormat setDateFormat:NSDateFormat_Month];
    [dic setObject:[dateFormat stringFromDate:self] forKey:NSDateFormat_Month];
    
    [dateFormat setDateFormat:NSDateFormat_Day];
    [dic setObject:[dateFormat stringFromDate:self] forKey:NSDateFormat_Day];
    
    [dateFormat setDateFormat:NSDateFormat_Hour];
    [dic setObject:[dateFormat stringFromDate:self] forKey:NSDateFormat_Hour];
    
    [dateFormat setDateFormat:NSDateFormat_Min];
    [dic setObject:[dateFormat stringFromDate:self] forKey:NSDateFormat_Min];
    
    [dateFormat setDateFormat:NSDateFormat_Sec];
    [dic setObject:[dateFormat stringFromDate:self] forKey:NSDateFormat_Sec];
    
    return dic;
}

- (NSDateFormatter *)zj_utcDateFormatter:(NSString *)dateFormatStr
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    if (dateFormatStr.length > 0) {
        [dateFormat setDateFormat:dateFormatStr];
    }
    return dateFormat;
}

#pragma mark - StaticAPI

+ (NSDate *)zj_localDate
{
    return [[NSDate date] zj_localDate];
}

+ (NSDate *)zj_utcDate
{
    return [[NSDate date] zj_utcDate];
}

+ (NSTimeInterval)zj_utcTime:(NSTimeInterval)time
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    date = [date zj_utcDate];
    return [date timeIntervalSince1970];
}

+ (NSTimeInterval)zj_localTime:(NSTimeInterval)time
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    date = [date zj_localDate];
    return [date timeIntervalSince1970];
}

+ (NSMutableDictionary *)zj_timeDictionary:(NSTimeInterval)time
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    return [date zj_toTimeDictionary];
}

+ (NSDate *)zj_timeFromString:(NSString *)dateStr formatter:(NSString *)formatter
{
    NSDateFormatter *formater = [[NSDateFormatter alloc]init];
    [formater setDateFormat:formatter];
    NSDate *date = [formater dateFromString:dateStr];
    return date;
}

#pragma mark -

- (NSInteger)year {
    return [[self zj_toString:NSDateFormat_Year] integerValue];
}

- (NSInteger)month {
    return [[self zj_toString:NSDateFormat_Month] integerValue];
}

- (NSInteger)day {
    return [[self zj_toString:NSDateFormat_Day] integerValue];
}

- (NSInteger)hour {
    return [[self zj_toString:NSDateFormat_Hour] integerValue];
}

- (NSInteger)min {
    return [[self zj_toString:NSDateFormat_Min] integerValue];
}

- (NSInteger)sec {
    return [[self zj_toString:NSDateFormat_Sec] integerValue];
}

- (NSInteger)days {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger days = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:self].length;
    return days;
}

@end
