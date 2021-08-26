//
//  ZJCalendarCenter.h
//  ZJBaseUtils
//
//  Created by eafy on 2020/9/23.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ZJBaseUtils/ZJCalendarMonth.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZJCalendarCenter : NSObject

/// 获取两个时间段之间的月份数据
/// @param startDate 开始时间 只会取到年月的值
/// @param endDate 结束时间
/// @param hasChinese 是否包含中国农历
- (NSArray *)getMonthArrayFrom:(NSDate *)startDate
                    andEndDate:(NSDate *)endDate
           withChineseCalendar:(BOOL)hasChinese;
@end

NS_ASSUME_NONNULL_END
