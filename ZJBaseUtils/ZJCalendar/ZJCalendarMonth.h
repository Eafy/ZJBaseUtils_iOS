//
//  ZJCalendarMonth.h
//  ZJUXKit
//
//  Created by eafy on 2020/9/23.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import <Foundation/Foundation.h>

/// 日历选择类型
typedef enum : NSUInteger {
    ZJCalendarSelectedTypeSingle = 1 << 0,      //单选
    ZJCalendarSelectedTypeMultiple = 1 << 1,    //多选
    ZJCalendarSelectedTypeRang = 1 << 2,        //区域选择
} ZJCalendarSelectedType;


// MARK:- 日
@interface ZJCalendarDay : NSObject

@property (nonatomic, copy) NSString *chineseDate;
@property (nonatomic, strong) NSDate *date;
@property (nonatomic, assign) NSUInteger year;
@property (nonatomic, assign) NSUInteger month;
@property (nonatomic, assign) NSUInteger day;
@property (nonatomic, assign) NSUInteger week;

/// 和今天日期差值(秒)
@property (nonatomic, assign) NSInteger diffTaday;

/// 选择状态
@property (nonatomic, assign) BOOL isSelected;
/// 开始选择Item
@property (nonatomic, assign) BOOL isBeginSelected;
/// 结束选择Item
@property (nonatomic, assign) BOOL isEndSelected;

- (BOOL)isEqualToCalendarDay:(ZJCalendarDay *)day;

@end

// MARK:- 月
@interface ZJCalendarMonth : NSObject

@property (nonatomic, strong) NSArray *days;
@property (nonatomic, strong) NSDate *date;
@property (nonatomic, copy) NSString *dateString;
@property (nonatomic, assign) NSUInteger year;
@property (nonatomic, assign) NSUInteger month;

@end
