//
//  ZJCalendarCenter.m
//  ZJBaseUtils
//
//  Created by eafy on 2020/9/23.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import <ZJBaseUtils/ZJCalendarCenter.h>

@interface ZJCalendarCenter()

@property (nonatomic, strong) NSCalendar *greCalendar;
@property (nonatomic, strong) NSCalendar *chineseCalendar;
@property (nonatomic, strong) NSDateFormatter *dateFormatter;
@property (nonatomic, strong) NSArray *dayArray;
@property (nonatomic, strong) NSDateComponents *todayComponent;

@end

@implementation ZJCalendarCenter

- (instancetype)init
{
    if (self = [super init]) {
        self.greCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        self.chineseCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierChinese];
        self.dateFormatter = [[NSDateFormatter alloc] init];
        self.dateFormatter.dateFormat = @"yyyy-MM-dd";
    }
    return self;
}

/// 获取两个时间段之间的月份数据
/// @param startDate 开始时间 只会取到年月的值
/// @param endDate 结束时间
/// @param hasChinese 是否包含中国农历
- (NSArray *)getMonthArrayFrom:(NSDate *)startDate
                    andEndDate:(NSDate *)endDate
           withChineseCalendar:(BOOL)hasChinese {
 
    self.todayComponent = [self.greCalendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:[NSDate date]];
    NSMutableArray *months = [NSMutableArray array];
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth;
    NSDateComponents *startComponent= [self.greCalendar components:unitFlags fromDate:startDate];
    NSDateComponents *endComponent = [self.greCalendar components:unitFlags fromDate:endDate];
    NSDate *beginFirstDay = [self.greCalendar dateFromComponents:startComponent];

    if ([startDate compare:endDate] == NSOrderedDescending) {
        NSLog(@"error: endDate less than startDate");
        return nil;
    }
    NSDateComponents *delta = [self.greCalendar components:NSCalendarUnitMonth fromDateComponents:startComponent toDateComponents:endComponent options:0];
    NSInteger monthCount = delta.month;
    for (int i = 0; i<=monthCount; i++) {
        ZJCalendarMonth *monthModel = [[ZJCalendarMonth alloc] init];
        NSDateComponents *nextMonthComps = [[NSDateComponents alloc] init];
        [nextMonthComps setMonth:i];
        NSDate *newMonthDate = [self.greCalendar dateByAddingComponents:nextMonthComps toDate:beginFirstDay options:0];
        NSDateComponents *newCom= [self.greCalendar components:NSCalendarUnitYear | NSCalendarUnitMonth fromDate:newMonthDate];
        monthModel.date = newMonthDate;
        monthModel.year = newCom.year;
        monthModel.month = newCom.month;
        monthModel.dateString = [self.dateFormatter stringFromDate:newMonthDate];
        monthModel.days = [self getDayArrayFromMonth:newMonthDate withChineseCalendar:hasChinese];
        [months addObject:monthModel];
    }
    return [months mutableCopy];
}

/// 获取每个月每一天的数据源
- (NSArray *)getDayArrayFromMonth:(NSDate *)firstDate withChineseCalendar:(BOOL)hasChinese {
    
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday;
    NSDateComponents *startComponent= [self.greCalendar components:unitFlags fromDate:firstDate];
    NSInteger weekForStartDay = startComponent.weekday;
    NSInteger dayCount = [self.greCalendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:firstDate].length;
    // 判断日历有多少列
    NSInteger column = 0;
    NSInteger tempDay = dayCount + (weekForStartDay-1);
    column += tempDay / 7;
    column += tempDay % 7 != 0 ? 1 : 0;
    NSInteger totalDay = column * 7;
    
    NSDateComponents *tadayComponent= [self.greCalendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:[NSDate date]];
    NSMutableArray *days = [NSMutableArray array];
    for (int i = 0; i<totalDay; i++) {
        NSInteger day = i - (weekForStartDay - 1);
        ZJCalendarDay *dayModel = [[ZJCalendarDay alloc] init];
        if (day >= 0 && day < dayCount) {
            NSDateComponents *nextMonthComps = [[NSDateComponents alloc] init];
            [nextMonthComps setDay:day];
            NSDate *newDayDate = [self.greCalendar dateByAddingComponents:nextMonthComps toDate:firstDate options:0];
            NSDateComponents *dayCom = [self.greCalendar components:unitFlags fromDate:newDayDate];
            dayModel.year = dayCom.year;
            dayModel.month = dayCom.month;
            dayModel.day = dayCom.day;
            dayModel.week = dayCom.weekday;
            dayModel.date = newDayDate;
            dayModel.chineseDate = [self getChineseCalendar:newDayDate withComponents:dayCom];
            dayModel.diffTaday = [self.greCalendar components:NSCalendarUnitDay fromDateComponents:tadayComponent toDateComponents:dayCom options:0].day;
        } else {
            dayModel.year = 0;
            dayModel.month = 0;
            dayModel.day = 0;
            dayModel.week = 0;
        }
        [days addObject:dayModel];
    }
    return [days mutableCopy];
}

/// 转换农历日期信息
- (NSString *)getChineseCalendar:(NSDate *)date withComponents:(NSDateComponents *)components{
    NSString *chineseDateStr = [self getChineseStr:date];
    if (components.year == self.todayComponent.year && components.month == self.todayComponent.month && components.day == self.todayComponent.day) {
        chineseDateStr = @"今天";
    }
    if(components.month == 1 && components.day == 1){
        chineseDateStr = @"元旦";
    }else if(components.month == 2 && components.day == 14){
        chineseDateStr = @"情人节";
    }else if(components.month == 3 && components.day == 8){
        chineseDateStr = @"妇女节";
    }else if(components.month == 4 && components.day == 1){
        chineseDateStr = @"愚人节";
    }else if(components.month == 4 && (components.day == 4 || components.day == 5 || components.day == 6)){
        if ([self isQingMing:components.year month:components.month day:components.day]) {
            chineseDateStr = @"清明节";
        }
    }else if(components.month == 5 && components.day == 1){
        chineseDateStr = @"劳动节";
    }else if(components.month == 5 && components.day == 4){
        chineseDateStr = @"青年节";
    }else if(components.month == 6 && components.day == 1){
        chineseDateStr = @"儿童节";
    }else if(components.month == 8 && components.day == 1){
        chineseDateStr = @"建军节";
    }else if(components.month == 9 && components.day == 10){
        chineseDateStr = @"教师节";
    }else if(components.month == 10 && components.day == 1){
        chineseDateStr = @"国庆节";
    }else if(components.month == 1 && components.day == 1){
        chineseDateStr = @"元旦";
    }else if(components.month == 11 && components.day == 11){
        chineseDateStr = @"光棍节";
    }else if(components.month == 12 && components.day == 25){
        chineseDateStr = @"圣诞节";
    }
    return chineseDateStr;
}

/// 清明节日期的计算 [Y*D+C]-L
/// 公式解读：Y=年数后2位，D=0.2422，L=闰年数，21世纪C=4.81，20世纪=5.59。
/// @param year 年
/// @param month 月
/// @param day 日
- (BOOL)isQingMing:(NSInteger )year month:(NSUInteger )month day:(NSUInteger )day {
    if(month == 4){
        NSInteger pre = year / 100;
        double c = 4.81;
        if(pre == 19){
            c = 5.59;
        }
        NSInteger y = (year % 100);
        int qingMingDay = (y * 0.2422 + c) - y / 4;
        if (day == qingMingDay) {
            return YES;
        }
    }
    return NO;
}

- (NSString *)getChineseStr:(NSDate *)date {
    NSDateComponents *comp = [self.chineseCalendar components:NSCalendarUnitMonth|NSCalendarUnitDay fromDate:date];
    if (comp.day>0 && comp.day<31) {
        if (comp.day==1 && comp.month==1) {
            return @"春节";
        }else{
            return self.dayArray[comp.day-1];
        }
    }
    return @"";
}

- (NSArray *)dayArray {
    if (!_dayArray) {
        _dayArray = @[@"初一",@"初二",@"初三",@"初四",@"初五",@"初六",@"初七",@"初八",@"初九",@"初十",
                      @"十一",@"十二",@"十三",@"十四",@"十五",@"十六",@"十七",@"十八",@"十九",@"二十",
                      @"廿一",@"廿二",@"廿三",@"廿四",@"廿五",@"廿六",@"廿七",@"廿八",@"廿九",@"三十"];
    }
    return _dayArray;
}

@end
