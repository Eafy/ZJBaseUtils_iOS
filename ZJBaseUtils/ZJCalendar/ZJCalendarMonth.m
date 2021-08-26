//
//  ZJCalendarMonth.m
//  ZJBaseUtils
//
//  Created by eafy on 2020/9/23.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import <ZJBaseUtils/ZJCalendarMonth.h>

@implementation ZJCalendarDay

- (BOOL)isEqualToCalendarDay:(ZJCalendarDay *)day {
    if (!day) {
        return NO;
    }
    if (day.year <= 0 || day.month <= 0 ){
        return NO;
    }
    if (day.year == self.year && day.month == self.month && day.day == self.day && [day.date isEqualToDate:self.date]) {
        return YES;
    }
    return NO;
}

@end


@implementation ZJCalendarMonth

@end
