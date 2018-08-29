//
//  NSDate+Extension.m
//  BowenToolDemo
//
//  Created by 陈伟财 on 2018/8/29.
//  Copyright © 2018年 Bowen. All rights reserved.
//

#import "NSDate+Extension.h"

// Thanks, AshFurrow
static const unsigned componentFlags = (NSCalendarUnitYear| NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekOfYear |  NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekday | NSCalendarUnitWeekdayOrdinal);

@implementation NSDate (Extension)


#pragma mark - <<<<<< avoid bottlenecks >>>>>> -
+ (NSCalendar *)currentCalendar
{
    return [NSCalendar autoupdatingCurrentCalendar];
}

#pragma mark - <<<<<< Decomposing dates >>>>>> -
- (NSInteger)ua_nearestHour
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + D_MINUTE * 30;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    NSDateComponents *components = [[NSDate currentCalendar] components:NSCalendarUnitHour fromDate:newDate];
    return components.hour;
}

- (NSInteger)ua_hour
{
    NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
    return components.hour;
}

- (NSInteger)ua_minute
{
    NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
    return components.minute;
}

- (NSInteger)ua_seconds
{
    NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
    return components.second;
}

- (NSInteger)ua_day
{
    NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
    return components.day;
}

- (NSInteger)ua_month
{
    NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
    return components.month;
}

- (NSInteger)ua_week
{
    NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
    return components.weekOfYear;
}

- (NSInteger)ua_weekday
{
    NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
    return components.weekday;
}

- (NSInteger)ua_nthWeekday // e.g. 2nd Tuesday of the month is 2
{
    NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
    return components.weekdayOrdinal;
}

- (NSInteger)ua_year
{
    NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
    return components.year;
}


#pragma mark - <<<<<< Short string utilities >>>>>> -
- (NSString *)ua_stringWithFormat:(NSString *)format
{
    NSDateFormatter *formatter = [NSDateFormatter new];
    //formatter.locale = [NSLocale currentLocale]; // Necessary?
    formatter.dateFormat = format;
    return [formatter stringFromDate:self];
}

- (NSString *)ua_stringWithDateStyle:(NSDateFormatterStyle)dateStyle timeStyle: (NSDateFormatterStyle)timeStyle
{
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateStyle = dateStyle;
    formatter.timeStyle = timeStyle;
    //formatter.locale = [NSLocale currentLocale]; // Necessary?
    return [formatter stringFromDate:self];
}

+ (NSString *)ua_timeWithTimeIntervalString:(NSInteger )timeString
{
    // 格式化时间
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:[self ua_ymdHmsFormat]];
    
    // 毫秒值转化为秒
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:timeString/ 1000.0];
    NSString* dateString = [formatter stringFromDate:date];
    return dateString;
}

+ (NSString *)ua_stringWithDate:(NSDate *)date format:(NSString *)format
{
    return [date ua_stringWithFormat:format];
}

+ (NSDate *)ua_dateWithString:(NSString *)string format:(NSString *)format
{
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setDateFormat:format];
    
    NSDate *date = [inputFormatter dateFromString:string];
    
    return date;
}


- (NSString *)ua_shortString
{
    return [self ua_stringWithDateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterShortStyle];
}

- (NSString *)ua_shortTimeString
{
    return [self ua_stringWithDateStyle:NSDateFormatterNoStyle timeStyle:NSDateFormatterShortStyle];
}

- (NSString *)ua_shortDateString
{
    return [self ua_stringWithDateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterNoStyle];
}

- (NSString *)ua_mediumString
{
    return [self ua_stringWithDateStyle:NSDateFormatterMediumStyle timeStyle:NSDateFormatterMediumStyle ];
}

- (NSString *)ua_mediumTimeString
{
    return [self ua_stringWithDateStyle:NSDateFormatterNoStyle timeStyle:NSDateFormatterMediumStyle ];
}

- (NSString *)ua_mediumDateString
{
    return [self ua_stringWithDateStyle:NSDateFormatterMediumStyle  timeStyle:NSDateFormatterNoStyle];
}

- (NSString *)ua_longString
{
    return [self ua_stringWithDateStyle:NSDateFormatterLongStyle timeStyle:NSDateFormatterLongStyle ];
}

- (NSString *)ua_longTimeString
{
    return [self ua_stringWithDateStyle:NSDateFormatterNoStyle timeStyle:NSDateFormatterLongStyle ];
}

- (NSString *)ua_longDateString
{
    return [self ua_stringWithDateStyle:NSDateFormatterLongStyle  timeStyle:NSDateFormatterNoStyle];
}


#pragma mark - <<<<<< Retrieving intervals >>>>>> -
- (NSInteger)ua_minutesAfterDate:(NSDate *)aDate
{
    NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
    return (NSInteger) (ti / D_MINUTE);
}

- (NSInteger)ua_minutesBeforeDate:(NSDate *)aDate
{
    NSTimeInterval ti = [aDate timeIntervalSinceDate:self];
    return (NSInteger) (ti / D_MINUTE);
}

- (NSInteger)ua_hoursAfterDate:(NSDate *)aDate
{
    NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
    return (NSInteger) (ti / D_HOUR);
}

- (NSInteger)ua_hoursBeforeDate:(NSDate *)aDate
{
    NSTimeInterval ti = [aDate timeIntervalSinceDate:self];
    return (NSInteger) (ti / D_HOUR);
}

- (NSInteger)ua_daysAfterDate:(NSDate *)aDate
{
    NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
    return (NSInteger) (ti / D_DAY);
}

- (NSInteger)ua_daysBeforeDate:(NSDate *)aDate
{
    NSTimeInterval ti = [aDate timeIntervalSinceDate:self];
    return (NSInteger) (ti / D_DAY);
}

// Thanks, dmitrydims
// I have not yet thoroughly tested this
- (NSInteger)ua_distanceInDaysToDate:(NSDate *)anotherDate
{
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorianCalendar components:NSCalendarUnitDay fromDate:self toDate:anotherDate options:0];
    return components.day;
}


#pragma mark - <<<<<< Adjusting dates >>>>>> -
- (NSDate *)ua_dateByAddingYears:(NSInteger)dYears
{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setYear:dYears];
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
    return newDate;
}

- (NSDate *)ua_dateBySubtractingYears:(NSInteger)dYears
{
    return [self ua_dateByAddingYears:-dYears];
}

- (NSDate *)ua_dateByAddingMonths:(NSInteger)dMonths
{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setMonth:dMonths];
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
    return newDate;
}

- (NSDate *)ua_dateBySubtractingMonths:(NSInteger)dMonths
{
    return [self ua_dateByAddingMonths:-dMonths];
}

// Courtesy of dedan who mentions issues with Daylight Savings
- (NSDate *)ua_dateByAddingDays:(NSInteger)dDays
{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setDay:dDays];
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
    return newDate;
}

- (NSDate *)ua_dateBySubtractingDays:(NSInteger)dDays
{
    return [self ua_dateByAddingDays:(dDays * -1)];
}

- (NSDate *)ua_dateByAddingHours:(NSInteger)dHours
{
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + D_HOUR * dHours;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

- (NSDate *)ua_dateBySubtractingHours:(NSInteger)dHours
{
    return [self ua_dateByAddingHours:(dHours * -1)];
}

- (NSDate *)ua_dateByAddingMinutes:(NSInteger)dMinutes
{
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + D_MINUTE * dMinutes;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

- (NSDate *)ua_dateBySubtractingMinutes:(NSInteger)dMinutes
{
    return [self ua_dateByAddingMinutes: (dMinutes * -1)];
}

+ (NSDate *)ua_dateWithISOFormatString:(NSString *)dateString
{
    static NSDateFormatter *formatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatter = [[NSDateFormatter alloc] init];
        formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
        formatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ssZ";
    });
    return [formatter dateFromString:dateString];
}


#pragma mark - <<<<<< Relative dates from the current date >>>>>> -
+ (NSDate *)ua_dateTomorrow
{
    return [NSDate ua_dateWithDaysFromNow:1];
}

+ (NSDate *)ua_dateYesterday
{
    return [NSDate ua_dateWithDaysBeforeNow:1];
}

+ (NSDate *)ua_dateWithDaysFromNow:(NSInteger)days
{
    // Thanks, Jim Morrison
    return [[NSDate date] ua_dateByAddingDays:days];
}
+ (NSDate *)ua_dateWithDaysBeforeNow:(NSInteger)days
{
    // Thanks, Jim Morrison
    return [[NSDate date] ua_dateBySubtractingDays:days];
}

+ (NSDate *)ua_dateWithHoursFromNow:(NSInteger)dHours
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + D_HOUR * dHours;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

+ (NSDate *)ua_dateWithHoursBeforeNow:(NSInteger)dHours
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - D_HOUR * dHours;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

+ (NSDate *)ua_dateWithMinutesFromNow:(NSInteger)dMinutes
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + D_MINUTE * dMinutes;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

+ (NSDate *)ua_dateWithMinutesBeforeNow:(NSInteger)dMinutes
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - D_MINUTE * dMinutes;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}


#pragma mark - <<<<<< Date extremes >>>>>> -
- (NSDate *)ua_beginOfDay
{
    NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
    components.hour = 0;
    components.minute = 0;
    components.second = 0;
    return [[NSDate currentCalendar] dateFromComponents:components];
}

// Thanks gsempe & mteece
- (NSDate *)ua_lastOfDay
{
    NSDateComponents *components = [[NSDate currentCalendar] components:componentFlags fromDate:self];
    components.hour = 23; // Thanks Aleksey Kononov
    components.minute = 59;
    components.second = 59;
    return [[NSDate currentCalendar] dateFromComponents:components];
}

- (NSDate *)ua_begindayOfWeek
{
    NSInteger weekday = [self ua_weekday];
    NSInteger dayBefor = (weekday+5)%7;
    
    NSDate *nowDate = [self ua_beginOfDay];
    return [nowDate ua_dateBySubtractingDays:dayBefor];
}

- (NSDate *)ua_lastdayOfWeek
{
    NSInteger weekday = [self ua_weekday];
    NSInteger dayBefor = (8-weekday)%7;
    
    NSDate *nowDate = [self ua_lastOfDay];
    return [nowDate ua_dateByAddingDays:dayBefor];
}

- (NSDate *)ua_begindayOfMonth
{
    return [[self ua_begindayOfMonth] ua_beginOfDay];
}
- (NSDate *)ua_lastdayOfMonth
{
    return [[self ua_lastdayOfMonth] ua_lastOfDay];
}
- (NSDate *)ua_begindayOfQuarter
{
    double interval = 0;
    NSDate *beginDate = nil;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar setFirstWeekday:2];//设定周一为周首日
    BOOL ok = [calendar rangeOfUnit:NSCalendarUnitQuarter startDate:&beginDate interval:&interval forDate:self];
    if (!ok)
    {
        return self;
    }
    else
    {
        return beginDate;
    }
}

- (NSDate *)ua_lastdayOfQuarter
{
    double interval = 0;
    NSDate *beginDate = nil;
    NSDate *endDate = nil;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar setFirstWeekday:2];//设定周一为周首日
    BOOL ok = [calendar rangeOfUnit:NSCalendarUnitQuarter startDate:&beginDate interval:&interval forDate:self];
    if (!ok)
    {
        return self;
    }
    else
    {
        //获取最后一天的起始时间
        endDate = [beginDate dateByAddingTimeInterval:interval];
        
        //获取最后一天的结束时间
        return [[endDate ua_dateBySubtractingMinutes:1] ua_lastOfDay];
    }
}

- (NSDate *)ua_begindayOfYear
{
    ;
    NSString *yearStr = [NSString stringWithFormat:@"%ld-01-01 00:00:00", (long)self.ua_year];
    return [NSDate ua_dateWithString:yearStr format:[self ua_ymdHmsFormat]];
}
- (NSDate *)ua_lastdayOfYear
{
    NSString *yearStr = [NSString stringWithFormat:@"%ld-12-31 23:59:59", (long)self.ua_year];
    return [NSDate ua_dateWithString:yearStr format:[self ua_ymdHmsFormat]];
}


#pragma mark - <<<<<< Comparing dates >>>>>> -
- (BOOL)ua_isEqualToDateIgnoringTime:(NSDate *)aDate
{
    NSDateComponents *components1 = [[NSDate currentCalendar] components:componentFlags fromDate:self];
    NSDateComponents *components2 = [[NSDate currentCalendar] components:componentFlags fromDate:aDate];
    return ((components1.year == components2.year) &&
            (components1.month == components2.month) &&
            (components1.day == components2.day));
}

- (BOOL)ua_isToday
{
    return [self ua_isEqualToDateIgnoringTime:[NSDate date]];
}

- (BOOL)ua_isTomorrow
{
    return [self ua_isEqualToDateIgnoringTime:[NSDate ua_dateTomorrow]];
}

- (BOOL)ua_isYesterday
{
    return [self ua_isEqualToDateIgnoringTime:[NSDate ua_dateYesterday]];
}

// This hard codes the assumption that a week is 7 days
- (BOOL)ua_isSameWeekAsDate:(NSDate *)aDate
{
    NSDateComponents *components1 = [[NSDate currentCalendar] components:componentFlags fromDate:self];
    NSDateComponents *components2 = [[NSDate currentCalendar] components:componentFlags fromDate:aDate];
    
    // Must be same week. 12/31 and 1/1 will both be week "1" if they are in the same week
    if (components1.weekOfYear != components2.weekOfYear) return NO;
    
    // Must have a time interval under 1 week. Thanks @aclark
    return (fabs([self timeIntervalSinceDate:aDate]) < D_WEEK);
}

- (BOOL)ua_isThisWeek
{
    return [self ua_isSameWeekAsDate:[NSDate date]];
}

- (BOOL)ua_isNextWeek
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + D_WEEK;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return [self ua_isSameWeekAsDate:newDate];
}

- (BOOL)ua_isLastWeek
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - D_WEEK;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return [self ua_isSameWeekAsDate:newDate];
}

// Thanks, mspasov
- (BOOL)ua_isSameMonthAsDate:(NSDate *)aDate
{
    NSDateComponents *components1 = [[NSDate currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth fromDate:self];
    NSDateComponents *components2 = [[NSDate currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth fromDate:aDate];
    return ((components1.month == components2.month) &&
            (components1.year == components2.year));
}

- (BOOL)ua_isThisMonth
{
    return [self ua_isSameMonthAsDate:[NSDate date]];
}

// Thanks Marcin Krzyzanowski, also for adding/subtracting years and months
- (BOOL)ua_isLastMonth
{
    return [self ua_isSameMonthAsDate:[[NSDate date] ua_dateBySubtractingMonths:1]];
}

- (BOOL)ua_isNextMonth
{
    return [self ua_isSameMonthAsDate:[[NSDate date] ua_dateByAddingMonths:1]];
}

- (BOOL)ua_isSameYearAsDate:(NSDate *)aDate
{
    NSDateComponents *components1 = [[NSDate currentCalendar] components:NSCalendarUnitYear fromDate:self];
    NSDateComponents *components2 = [[NSDate currentCalendar] components:NSCalendarUnitYear fromDate:aDate];
    return (components1.year == components2.year);
}

- (BOOL)ua_isThisYear
{
    // Thanks, baspellis
    return [self ua_isSameYearAsDate:[NSDate date]];
}

- (BOOL)ua_isNextYear
{
    NSDateComponents *components1 = [[NSDate currentCalendar] components:NSCalendarUnitYear fromDate:self];
    NSDateComponents *components2 = [[NSDate currentCalendar] components:NSCalendarUnitYear fromDate:[NSDate date]];
    
    return (components1.year == (components2.year + 1));
}

- (BOOL)ua_isLastYear
{
    NSDateComponents *components1 = [[NSDate currentCalendar] components:NSCalendarUnitYear fromDate:self];
    NSDateComponents *components2 = [[NSDate currentCalendar] components:NSCalendarUnitYear fromDate:[NSDate date]];
    
    return (components1.year == (components2.year - 1));
}

- (BOOL)ua_isEarlierThanDate:(NSDate *)aDate
{
    return ([self compare:aDate] == NSOrderedAscending);
}

- (BOOL)ua_isLaterThanDate:(NSDate *)aDate
{
    return ([self compare:aDate] == NSOrderedDescending);
}

// Thanks, markrickert
- (BOOL)ua_isInFuture
{
    return ([self ua_isLaterThanDate:[NSDate date]]);
}

// Thanks, markrickert
- (BOOL)ua_isInPast
{
    return ([self ua_isEarlierThanDate:[NSDate date]]);
}

- (BOOL)ua_isTypicallyWeekend
{
    NSDateComponents *components = [[NSDate currentCalendar] components:NSCalendarUnitWeekday fromDate:self];
    if ((components.weekday == 1) ||
        (components.weekday == 7))
        return YES;
    return NO;
}

- (BOOL)ua_isTypicallyWorkday
{
    return ![self ua_isTypicallyWeekend];
}

//判断是否是润年-YES表示润年，NO表示平年
- (BOOL)ua_isLeapYear
{
    return [NSDate ua_isLeapYear:self];
}

+ (BOOL)ua_isLeapYear:(NSDate *)date
{
    NSUInteger year = [date ua_year];
    if ((year % 4  == 0 && year % 100 != 0) || year % 400 == 0) {
        return YES;
    }
    return NO;
}


- (NSUInteger)ua_daysInYear
{
    return [NSDate ua_daysInYear:self];
}

+ (NSUInteger)ua_daysInYear:(NSDate *)date
{
    return [self ua_isLeapYear:date] ? 366 : 365;
}


- (NSUInteger)ua_weekOfYear
{
    return [NSDate ua_weekOfYear:self];
}

+ (NSUInteger)ua_weekOfYear:(NSDate *)date
{
    NSUInteger i;
    NSUInteger year = [date ua_year];
    
    NSDate *lastdate = [date ua_lastdayOfMonth];
    
    for (i = 1;[[lastdate ua_dateByAddingDays:-7 * i] ua_year] == year; i++)
    {
        
    }
    
    return i;
}

- (NSString *)ua_formatYMD
{
    return [NSDate ua_formatYMD:self];
}

+ (NSString *)ua_formatYMD:(NSDate *)date
{
    return [NSString stringWithFormat:@"%tu-%02tu-%02tu",[date ua_year], [date ua_month], [date ua_day]];
}

- (NSUInteger)ua_weeksOfMonth
{
    return [NSDate ua_weeksOfMonth:self];
}

+ (NSUInteger)ua_weeksOfMonth:(NSDate *)date
{
    return [[date ua_lastdayOfMonth] ua_weekOfYear] - [[date ua_begindayOfMonth] ua_weekOfYear] + 1;
}


- (NSUInteger)ua_daysAgo
{
    return [NSDate ua_daysAgo:self];
}

+ (NSUInteger)ua_daysAgo:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    NSDateComponents *components = [calendar components:(NSCalendarUnitDay)
                                               fromDate:date
                                                 toDate:[NSDate date]
                                                options:0];
#else
    NSDateComponents *components = [calendar components:(NSDayCalendarUnit)
                                               fromDate:date
                                                 toDate:[NSDate date]
                                                options:0];
#endif
    
    return [components day];
}

+ (NSInteger)ua_weekday:(NSDate *)date
{
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [gregorian components:(NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitWeekday) fromDate:date];
    NSInteger weekday = [comps weekday];
    
    return weekday;
}

- (NSString *)ua_dayFromWeekday
{
    return [NSDate ua_dayFromWeekday:self];
}

+ (NSString *)ua_dayFromWeekday:(NSDate *)date
{
    switch([date ua_weekday])
    {
        case 1:
            return @"星期天";
            break;
        case 2:
            return @"星期一";
            break;
        case 3:
            return @"星期二";
            break;
        case 4:
            return @"星期三";
            break;
        case 5:
            return @"星期四";
            break;
        case 6:
            return @"星期五";
            break;
        case 7:
            return @"星期六";
            break;
        default:
            break;
    }
    return @"";
}

+ (NSString *)ua_monthWithMonthNumber:(NSInteger)month
{
    switch(month)
    {
        case 1:
            return @"January";
            break;
        case 2:
            return @"February";
            break;
        case 3:
            return @"March";
            break;
        case 4:
            return @"April";
            break;
        case 5:
            return @"May";
            break;
        case 6:
            return @"June";
            break;
        case 7:
            return @"July";
            break;
        case 8:
            return @"August";
            break;
        case 9:
            return @"September";
            break;
        case 10:
            return @"October";
            break;
        case 11:
            return @"November";
            break;
        case 12:
            return @"December";
            break;
        default:
            break;
    }
    return @"";
}


- (NSUInteger)ua_daysInMonth:(NSUInteger)month
{
    return [NSDate ua_daysInMonth:self month:month];
}

+ (NSUInteger)ua_daysInMonth:(NSDate *)date month:(NSUInteger)month
{
    switch (month)
    {
        case 1: case 3: case 5: case 7: case 8: case 10: case 12:
            return 31;
        case 2:
            return [date ua_isLeapYear] ? 29 : 28;
    }
    return 30;
}

- (NSUInteger)ua_daysInMonth
{
    return [NSDate ua_daysInMonth:self];
}

+ (NSUInteger)ua_daysInMonth:(NSDate *)date
{
    return [self ua_daysInMonth:date month:[date ua_month]];
}

- (NSString *)ua_timeInfo
{
    return [NSDate ua_timeInfoWithDate:self];
}

+ (NSString *)ua_timeInfoWithDate:(NSDate *)date
{
    return [self ua_timeInfoWithDateString:[self ua_stringWithDate:date format:[self ua_ymdHmsFormat]]];
}

+ (NSString *)ua_timeInfoWithDateString:(NSString *)dateString
{
    NSDate *date = [self ua_dateWithString:dateString format:[self ua_ymdHmsFormat]];
    
    NSDate *curDate = [NSDate date];
    NSTimeInterval time = -[date timeIntervalSinceDate:curDate];
    
    int month = (int)([curDate ua_month] - [date ua_month]);
    int year = (int)([curDate ua_year] - [date ua_year]);
    int day = (int)([curDate ua_day] - [date ua_day]);
    
    NSTimeInterval retTime = 1.0;
    if (time < 3600)
    { // 小于一小时
        retTime = time / 60;
        retTime = retTime <= 0.0 ? 1.0 : retTime;
        return [NSString stringWithFormat:@"%.0f分钟前", retTime];
    }
    else if (time < 3600 * 24)
    { // 小于一天，也就是今天
        retTime = time / 3600;
        retTime = retTime <= 0.0 ? 1.0 : retTime;
        return [NSString stringWithFormat:@"%.0f小时前", retTime];
    }
    else if (time < 3600 * 24 * 2)
    {
        return @"昨天";
    }
    // 第一个条件是同年，且相隔时间在一个月内
    // 第二个条件是隔年，对于隔年，只能是去年12月与今年1月这种情况
    else if ((abs(year) == 0 && abs(month) <= 1)
             || (abs(year) == 1 && [curDate ua_month] == 1 && [date ua_month] == 12))
    {
        int retDay = 0;
        if (year == 0)
        { // 同年
            if (month == 0)
            { // 同月
                retDay = day;
            }
        }
        
        if (retDay <= 0)
        {
            // 获取发布日期中，该月有多少天
            int totalDays = (int)[self ua_daysInMonth:date month:[date ua_month]];
            
            // 当前天数 + （发布日期月中的总天数-发布日期月中发布日，即等于距离今天的天数）
            retDay = (int)[curDate ua_day] + (totalDays - (int)[date ua_day]);
        }
        
        return [NSString stringWithFormat:@"%d天前", (abs)(retDay)];
    }
    else
    {
        if (abs(year) <= 1)
        {
            if (year == 0)
            { // 同年
                return [NSString stringWithFormat:@"%d个月前", abs(month)];
            }
            
            // 隔年
            int month = (int)[curDate ua_month];
            int preMonth = (int)[date ua_month];
            if (month == 12 && preMonth == 12) {// 隔年，但同月，就作为满一年来计算
                return @"1年前";
            }
            return [NSString stringWithFormat:@"%d个月前", (abs)(12 - preMonth + month)];
        }
        
        return [NSString stringWithFormat:@"%d年前", abs(year)];
    }
    
    return @"1小时前";
}


- (NSString *)ua_ymdFormat
{
    return [NSDate ua_ymdFormat];
}

- (NSString *)ua_hmsFormat
{
    return [NSDate ua_hmsFormat];
}

- (NSString *)ua_ymdHmsFormat
{
    return [NSDate ua_ymdHmsFormat];
}

+ (NSString *)ua_ymdFormat
{
    return @"yyyy-MM-dd";
}

+ (NSString *)ua_hmsFormat
{
    return @"HH:mm:ss";
}

+ (NSString *)ua_ymdHmsFormat
{
    return [NSString stringWithFormat:@"%@ %@", [self ua_ymdFormat], [self ua_hmsFormat]];
}

@end

