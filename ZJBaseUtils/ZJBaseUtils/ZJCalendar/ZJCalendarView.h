//
//  ZJCalendarView.h
//  ZJBaseUtils
//
//  Created by eafy on 2020/9/22.
//  Copyright © 2020 ZJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZJCalendarMonth.h"

/// 回调block参数
typedef void(^jmCalendarSelectedBlcok)(NSArray<ZJCalendarDay *> *array);

@interface ZJCalendarView : UIView

/// 初始化日历选择器
/// @param type 日历选择类型，默认All
/// @param startDate 开始时间 只会取到年月的值
/// @param endDate 结束时间
/// @param hasChinese 是否包含中国农历（暂不支持）
/// @param enable 过期是否可用
/// @param completion 完成回调
- (instancetype)initWithSelectedType:(ZJCalendarSelectedType)type fromStartDate:(NSDate *)startDate andEndDate:(NSDate *)endDate withChineseCalendar:(BOOL)hasChinese expiredEnable:(BOOL)enable completion:(void(^)(NSArray<ZJCalendarDay *> *))completion;

/// 显示
/// @param view 显示在那个view上
- (void)showInView:(UIView *)view;

/// 跳转日历月份
- (void)showDate:(NSDate *)date;

/// 关闭
- (void)dismiss;

@end

