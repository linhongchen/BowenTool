//
//  NSDate+Extension_ua.h
//  BowenToolDemo
//
//  Created by 陈伟财 on 2018/2/23.
//  Copyright © 2018年 Bowen. All rights reserved.
//

#import <Foundation/Foundation.h>

#define D_MINUTE    60
#define D_HOUR        3600
#define D_DAY        86400
#define D_WEEK        604800
#define D_YEAR        31556926

@interface NSDate (Extension_ua)

#pragma mark - <<<<<< avoid bottlenecks >>>>>> -
+ (NSCalendar *) currentCalendar;

#pragma mark - <<<<<< Decomposing dates >>>>>> -
@property (readonly) NSInteger ua_nearestHour;
@property (readonly) NSInteger ua_hour;
@property (readonly) NSInteger ua_minute;
@property (readonly) NSInteger ua_seconds;
@property (readonly) NSInteger ua_day;
@property (readonly) NSInteger ua_month;
@property (readonly) NSInteger ua_week;
@property (readonly) NSInteger ua_weekday;
@property (readonly) NSInteger ua_nthWeekday; // e.g. 2nd Tuesday of the month == 2
@property (readonly) NSInteger ua_year;

#pragma mark - <<<<<< Short string utilities >>>>>> -
- (NSString *)ua_stringWithDateStyle:(NSDateFormatterStyle)dateStyle timeStyle: (NSDateFormatterStyle)timeStyle;
- (NSString *)ua_stringWithFormat:(NSString *)format;
+ (NSString *)ua_timeWithTimeIntervalString:(NSInteger)timeString;
+ (NSString *)ua_stringWithDate:(NSDate *)date format:(NSString *)format;
+ (NSDate *)ua_dateWithString:(NSString *)string format:(NSString *)format;

@property (nonatomic, readonly) NSString *ua_shortString;
@property (nonatomic, readonly) NSString *ua_shortDateString;
@property (nonatomic, readonly) NSString *ua_shortTimeString;
@property (nonatomic, readonly) NSString *ua_mediumString;
@property (nonatomic, readonly) NSString *ua_mediumDateString;
@property (nonatomic, readonly) NSString *ua_mediumTimeString;
@property (nonatomic, readonly) NSString *ua_longString;
@property (nonatomic, readonly) NSString *ua_longDateString;
@property (nonatomic, readonly) NSString *ua_longTimeString;


#pragma mark - <<<<<< Retrieving intervals >>>>>> -
- (NSInteger)ua_minutesAfterDate:(NSDate *)aDate;
- (NSInteger)ua_minutesBeforeDate:(NSDate *)aDate;
- (NSInteger)ua_hoursAfterDate:(NSDate *)aDate;
- (NSInteger)ua_hoursBeforeDate:(NSDate *)aDate;
- (NSInteger)ua_daysAfterDate:(NSDate *)aDate;
- (NSInteger)ua_daysBeforeDate:(NSDate *)aDate;
- (NSInteger)ua_distanceInDaysToDate:(NSDate *)anotherDate;

#pragma mark - <<<<<< Adjusting dates >>>>>> -
- (NSDate *)ua_dateByAddingYears:(NSInteger)dYears;
- (NSDate *)ua_dateBySubtractingYears:(NSInteger)dYears;
- (NSDate *)ua_dateByAddingMonths:(NSInteger)dMonths;
- (NSDate *)ua_dateBySubtractingMonths:(NSInteger)dMonths;
- (NSDate *)ua_dateByAddingDays:(NSInteger)dDays;
- (NSDate *)ua_dateBySubtractingDays:(NSInteger)dDays;
- (NSDate *)ua_dateByAddingHours:(NSInteger)dHours;
- (NSDate *)ua_dateBySubtractingHours:(NSInteger)dHours;
- (NSDate *)ua_dateByAddingMinutes:(NSInteger)dMinutes;
- (NSDate *)ua_dateBySubtractingMinutes:(NSInteger)dMinutes;
+ (NSDate *)ua_dateWithISOFormatString:(NSString *)dateString;

#pragma mark - <<<<<< Relative dates from the current date >>>>>> -
+ (NSDate *)ua_dateTomorrow;
+ (NSDate *)ua_dateYesterday;
+ (NSDate *)ua_dateWithDaysFromNow:(NSInteger)days;
+ (NSDate *)ua_dateWithDaysBeforeNow:(NSInteger)days;
+ (NSDate *)ua_dateWithHoursFromNow:(NSInteger)dHours;
+ (NSDate *)ua_dateWithHoursBeforeNow:(NSInteger)dHours;
+ (NSDate *)ua_dateWithMinutesFromNow:(NSInteger)dMinutes;
+ (NSDate *)ua_dateWithMinutesBeforeNow:(NSInteger)dMinutes;


#pragma mark - <<<<<< Date extremes >>>>>> -
- (NSDate *)ua_beginOfDay;
- (NSDate *)ua_lastOfDay;

- (NSDate *)ua_begindayOfWeek;
- (NSDate *)ua_lastdayOfWeek;

- (NSDate *)ua_begindayOfMonth;
- (NSDate *)ua_lastdayOfMonth;

- (NSDate *)ua_begindayOfQuarter;
- (NSDate *)ua_lastdayOfQuarter;

- (NSDate *)ua_begindayOfYear;
- (NSDate *)ua_lastdayOfYear;

#pragma mark - <<<<<< Comparing dates >>>>>> -
- (BOOL)ua_isEqualToDateIgnoringTime:(NSDate *)aDate;

- (BOOL)ua_isToday;
- (BOOL)ua_isTomorrow;
- (BOOL)ua_isYesterday;

- (BOOL)ua_isSameWeekAsDate:(NSDate *)aDate;
- (BOOL)ua_isThisWeek;
- (BOOL)ua_isNextWeek;
- (BOOL)ua_isLastWeek;

- (BOOL)ua_isSameMonthAsDate:(NSDate *)aDate;
- (BOOL)ua_isThisMonth;
- (BOOL)ua_isNextMonth;
- (BOOL)ua_isLastMonth;

- (BOOL)ua_isSameYearAsDate:(NSDate *)aDate;
- (BOOL)ua_isThisYear;
- (BOOL)ua_isNextYear;
- (BOOL)ua_isLastYear;

- (BOOL)ua_isEarlierThanDate:(NSDate *)aDate;
- (BOOL)ua_isLaterThanDate:(NSDate *)aDate;

- (BOOL)ua_isInFuture;
- (BOOL)ua_isInPast;

// Date roles
- (BOOL)ua_isTypicallyWorkday;
- (BOOL)ua_isTypicallyWeekend;

//判断是否是润年-YES表示润年，NO表示平年
- (BOOL)ua_isLeapYear;
+ (BOOL)ua_isLeapYear:(NSDate *)date;


/**
 * 获取一年中的总天数
 */
- (NSUInteger)ua_daysInYear;
+ (NSUInteger)ua_daysInYear:(NSDate *)date;


/**
 * 获取该日期是该年的第几周
 */
- (NSUInteger)ua_weekOfYear;
+ (NSUInteger)ua_weekOfYear:(NSDate *)date;

/**
 * 获取格式化为YYYY-MM-dd格式的日期字符串
 */
- (NSString *)ua_formatYMD;
+ (NSString *)ua_formatYMD:(NSDate *)date;

/**
 * 返回当前月一共有几周(可能为4,5,6)
 */
- (NSUInteger)ua_weeksOfMonth;
+ (NSUInteger)ua_weeksOfMonth:(NSDate *)date;

/**
 * 距离该日期前几天
 */
- (NSUInteger)ua_daysAgo;
+ (NSUInteger)ua_daysAgo:(NSDate *)date;

/**
 *  获取星期几
 *
 *  @return Return weekday number
 *  [1 - Sunday]
 *  [2 - Monday]
 *  [3 - Tuerday]
 *  [4 - Wednesday]
 *  [5 - Thursday]
 *  [6 - Friday]
 *  [7 - Saturday]
 */
//- (NSInteger)ua_weekday;
+ (NSInteger)ua_weekday:(NSDate *)date;

/**
 *  获取星期几(名称)
 *
 *  @return Return weekday as a localized string
 *  [1 - Sunday]
 *  [2 - Monday]
 *  [3 - Tuerday]
 *  [4 - Wednesday]
 *  [5 - Thursday]
 *  [6 - Friday]
 *  [7 - Saturday]
 */
- (NSString *)ua_dayFromWeekday;
+ (NSString *)ua_dayFromWeekday:(NSDate *)date;


/**
 *  Get the month as a localized string from the given month number
 *
 *  @param month The month to be converted in string
 *  [1 - January]
 *  [2 - February]
 *  [3 - March]
 *  [4 - April]
 *  [5 - May]
 *  [6 - June]
 *  [7 - July]
 *  [8 - August]
 *  [9 - September]
 *  [10 - October]
 *  [11 - November]
 *  [12 - December]
 *
 *  @return Return the given month as a localized string
 */
+ (NSString *)ua_monthWithMonthNumber:(NSInteger)month;


/**
 * 获取指定月份的天数
 */
- (NSUInteger)ua_daysInMonth:(NSUInteger)month;
+ (NSUInteger)ua_daysInMonth:(NSDate *)date month:(NSUInteger)month;

/**
 * 获取当前月份的天数
 */
- (NSUInteger)ua_daysInMonth;
+ (NSUInteger)ua_daysInMonth:(NSDate *)date;

/**
 * 返回x分钟前/x小时前/昨天/x天前/x个月前/x年前
 */
- (NSString *)ua_timeInfo;
+ (NSString *)ua_timeInfoWithDate:(NSDate *)date;
+ (NSString *)ua_timeInfoWithDateString:(NSString *)dateString;

/**
 * 分别获取yyyy-MM-dd/HH:mm:ss/yyyy-MM-dd HH:mm:ss格式的字符串
 */
- (NSString *)ua_ymdFormat;
- (NSString *)ua_hmsFormat;
- (NSString *)ua_ymdHmsFormat;
+ (NSString *)ua_ymdFormat;
+ (NSString *)ua_hmsFormat;
+ (NSString *)ua_ymdHmsFormat;

@end
