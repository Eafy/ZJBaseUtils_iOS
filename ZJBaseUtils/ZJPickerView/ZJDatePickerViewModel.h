//
//  ZJDatePickerViewModel.h
//  ZJBaseUtils
//
//  Created by eafy on 2021/1/14.
//  Copyright © 2021 ZJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZJPickerView.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZJDatePickerViewModel : NSObject

@property (nonatomic,assign) ZJPickerViewStyle dateType;
@property (nonatomic,strong) NSMutableArray<NSString *> *yearArray;
@property (nonatomic,strong) NSMutableArray<NSString *> *monthArray;
@property (nonatomic,strong) NSMutableArray<NSString *> *dayArray;
@property (nonatomic,strong) NSMutableArray<NSString *> *weekArray;
@property (nonatomic,strong) NSMutableArray<NSString *> *hourArray;
@property (nonatomic,strong) NSMutableArray<NSString *> *minuteArray;
@property (nonatomic,strong) NSMutableArray<NSString *> *secondArray;

/// 更新当前日期
/// @param date 日期
- (void)updateCurrentDate:(NSDate *)date;
- (void)updateDays:(NSString *)year mon:(NSString *)mon;

/// 获取年的索引
/// @param value 年数，<=0，当年
- (NSInteger)indexYear:(NSInteger)value;

/// 获取月的索引
/// @param value 月，<0，当月
- (NSInteger)indexMon:(NSInteger)value;

/// 获取天的索引
/// @param value 天，<0，当天
- (NSInteger)indexDay:(NSInteger)value;

/// 获取小时的索引
/// @param value 小时，<0，当时
- (NSInteger)indexHour:(NSInteger)value;

/// 获取分钟的索引
/// @param value 分钟，<0，当分
- (NSInteger)indexMin:(NSInteger)value;

/// 获取秒的索引
/// @param value 秒，<0，当秒
- (NSInteger)indexSec:(NSInteger)value;

@end

NS_ASSUME_NONNULL_END
