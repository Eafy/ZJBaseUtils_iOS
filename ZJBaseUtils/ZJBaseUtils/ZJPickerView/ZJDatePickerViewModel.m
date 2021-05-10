//
//  ZJDatePickerViewModel.m
//  ZJBaseUtils
//
//  Created by eafy on 2021/1/14.
//  Copyright © 2021 ZJ. All rights reserved.
//

#import "ZJDatePickerViewModel.h"
#import "NSDate+ZJExt.h"

#define ZJDatePickerViewModelYearCount 50

@interface ZJDatePickerViewModel ()

@property (nonatomic,strong) NSDate *daysDate;
@property (nonatomic,strong) NSDate *currentDate;

@end

@implementation ZJDatePickerViewModel

- (NSMutableArray<NSString *> *)yearArray {
    if (!_yearArray) {
        NSInteger start = [self.currentDate year];
        
        NSMutableArray *array = [NSMutableArray array];
        for (NSInteger i = -ZJDatePickerViewModelYearCount/2; i < ZJDatePickerViewModelYearCount/2; i++) {
            [array addObject:[NSString stringWithFormat:@"%04ld", start + i]];
        }
        _yearArray = array;
    }
    
    return _yearArray;
}

- (NSMutableArray<NSString *> *)monthArray {
    if (!_monthArray) {
        NSMutableArray *array = [NSMutableArray array];
        for (NSInteger i = 1; i <= 12; i++) {
            [array addObject:[NSString stringWithFormat:@"%02ld", i]];
        }
        _monthArray = array;
    }
    
    return _monthArray;
}

- (NSMutableArray<NSString *> *)dayArray {
    if (!_dayArray) {
        NSDate *date = self.daysDate ? self.daysDate : self.currentDate;
        NSInteger days = [date days];

        NSMutableArray *array = [NSMutableArray array];
        for (NSInteger i = 1; i <= days; i ++) {
            [array addObject:[NSString stringWithFormat:@"%02ld", i]];
        }
        _dayArray = array;
    }

    return _dayArray;
}


- (NSMutableArray<NSString *> *)hourArray {
    if (!_hourArray) {
        NSMutableArray *array = [NSMutableArray array];
        for (NSInteger i = 0; i < 24; i++) {
            [array addObject:[NSString stringWithFormat:@"%02ld", i]];
        }
        _hourArray = array;
    }
    
    return _hourArray;
}

- (NSMutableArray<NSString *> *)minuteArray {
    if (!_minuteArray) {
        NSMutableArray *array = [NSMutableArray array];
        for (NSInteger i = 0; i < 60; i++) {
            [array addObject:[NSString stringWithFormat:@"%02ld", i]];
        }
        _minuteArray = array;
    }
    
    return _minuteArray;
}

- (NSMutableArray *)secondArray {
    if (!_secondArray) {
        NSMutableArray *array = [NSMutableArray array];
        for (NSInteger i = 0; i < 60; i++) {
            [array addObject:[NSString stringWithFormat:@"%02ld", i]];
        }
        _secondArray = array;
    }
    return _secondArray;
}

#pragma mark -

- (NSDate *)currentDate {
    return _currentDate ? _currentDate : [NSDate date];
}

- (void)updateCurrentDate:(NSDate *)date
{
    _currentDate = date;
}

- (void)updateDays:(NSString *)year mon:(NSString *)mon {
    _daysDate = [NSDate zj_timeFromString:[NSString stringWithFormat:@"%04ld-%02d-01 00:00:00", [year integerValue], [mon intValue]] formatter:NSDateFormat_yyyy_MM_dd_HH_mm_ss];
    _dayArray = nil;
}

- (NSInteger)indexYear:(NSInteger)value {
    if (value <= 0) {
        value = ZJDatePickerViewModelYearCount/2;
        if (value < self.yearArray.count) {
            return value;
        }
    } else {
        NSString *date = [NSString stringWithFormat:@"%04ld", value];
        for (NSInteger i=0; i<ZJDatePickerViewModelYearCount; i++) {
            NSString *dateT = [self.yearArray objectAtIndex:i];
            if ([dateT isEqualToString:date]) {
                return i;
            }
        }
    }
    return 0;
}

- (NSInteger)indexMon:(NSInteger)value {
    NSInteger count = self.monthArray.count;
    if (value > count) {
        return 0;
    } else if (value >= 0) {
        return value - 1;
    }
    
    NSString *date = [NSString stringWithFormat:@"%02ld", [self.currentDate month]];
    for (NSInteger i=0; i<self.monthArray.count; i++) {
        NSString *dateT = [self.monthArray objectAtIndex:i];
        if ([dateT isEqualToString:date]) {
            return i;
        }
    }

    return 0;
}

- (NSInteger)indexDay:(NSInteger)value {
    NSInteger count = self.dayArray.count;
    if (value > count) {
        return 0;
    } else if (value > 0) {    //从1开始
        return value - 1;
    }
    
    NSString *date = [NSString stringWithFormat:@"%02ld", [self.currentDate day]];
    for (NSInteger i=0; i<self.dayArray.count; i++) {
        NSString *dateT = [self.dayArray objectAtIndex:i];
        if ([dateT isEqualToString:date]) {
            return i;
        }
    }

    return 0;
}

- (NSInteger)indexHour:(NSInteger)value {
    NSInteger count = self.hourArray.count;
    if (value > count) {
        return 0;
    } else if (value >= 0) {    //从0开始
        return value;
    }
    
    NSString *date = [NSString stringWithFormat:@"%02ld", [self.currentDate hour]];
    for (NSInteger i=0; i<self.hourArray.count; i++) {
        NSString *dateT = [self.hourArray objectAtIndex:i];
        if ([dateT isEqualToString:date]) {
            return i;
        }
    }

    return 0;
}

- (NSInteger)indexMin:(NSInteger)value {
    NSInteger count = self.minuteArray.count;
    if (value > count) {
        return 0;
    } else if (value >= 0) {    //从0开始
        return value;
    }
    
    NSString *date = [NSString stringWithFormat:@"%02ld", [self.currentDate min]];
    for (NSInteger i=0; i<self.minuteArray.count; i++) {
        NSString *dateT = [self.minuteArray objectAtIndex:i];
        if ([dateT isEqualToString:date]) {
            return i;
        }
    }

    return 0;
}

- (NSInteger)indexSec:(NSInteger)value {
    NSInteger count = self.secondArray.count;
    if (value > count) {
        return 0;
    } else if (value >= 0) {    //从0开始
        return value;
    }
    
    NSString *date = [NSString stringWithFormat:@"%02ld", [self.currentDate sec]];
    for (NSInteger i=0; i<self.secondArray.count; i++) {
        NSString *dateT = [self.secondArray objectAtIndex:i];
        if ([dateT isEqualToString:date]) {
            return i;
        }
    }

    return 0;
}

@end
