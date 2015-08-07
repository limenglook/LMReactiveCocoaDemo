//
//  NSDate+LM.h
//  LMCategory
//
//  Created by 李蒙 on 15/7/9.
//  Copyright (c) 2015年 李蒙. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    /**
     *  e.g.2014-03-04 13:23:35:67
     */
    LMDateFormatWithAll,
    /**
     *  e.g.2014-03-04 13:23:35
     */
    LMDateFormatWithDateAndTime,     //
    /**
     *  e.g.13:23:35
     */
    LMDateFormatWithTime,
    /**
     *  e.g.13:23
     */
    LMDateFormatWithTimeHourMinute,
    /**
     *  e.g.13:23:35:67
     */
    LMDateFormatWithPreciseTime,
    
    /**
     *  e.g.2014-03-04
     */
    LMDateFormatWithYearMonthDay,
    /**
     *  e.g.2014-03
     */
    LMDateFormatWithYearMonth,
    /**
     *  e.g.03-04
     */
    LMDateFormatWithMonthDay,
    /**
     *  e.g.2014
     */
    LMDateFormatWithYear,
    /**
     *  e.g.03
     */
    LMDateFormatWithMonth,
    /**
     *  e.g.04
     */
    LMDateFormatWithDay,
} LMDateFormat;

@interface NSDate (LM)

/**
 *  将NSDate转为NSString
 *
 *  @param format LMDateFormat
 *
 *  @return NSString
 */
- (NSString *)lm_stringWithDateFormat:(LMDateFormat)format;

/**
 *  取出年、月、日
 *
 *  @return e.g.2015-01-02
 */
- (NSDate *)lm_subDateWithYearMothDay;

/**
 *  是否为今天
 *
 *  @return 是/不是
 */
- (BOOL)lm_isToday;

/**
 *  是否为昨天
 *
 *  @return 是/不是
 */
- (BOOL)lm_isYesterday;

/**
 *  是否为今年
 *
 *  @return 是/不是
 */
- (BOOL)lm_isThisYear;

/**
 *  获得与当前时间的差距
 *
 *  @return NSDateComponents
 */
- (NSDateComponents *)lm_deltaWithNow;

/**
 *  获取日
 *
 *  @return 日
 */
- (NSUInteger)lm_day;

/**
 *  获取月
 *
 *  @return 月
 */
- (NSUInteger)lm_month;

/**
 *  获取年
 *
 *  @return 年
 */
- (NSUInteger)lm_year;

/**
 *  获取小时
 *
 *  @return 小时
 */
- (NSUInteger)lm_hour;

/**
 *  获取分钟
 *
 *  @return 分钟
 */
- (NSUInteger)lm_minute;

/**
 *  获取秒
 *
 *  @return 秒
 */
- (NSUInteger)lm_second;

/**
 *  获取一年的总天数
 *
 *  @return 天
 */
- (NSUInteger)lm_daysInYear;

/**
 *  获取某月的天数
 *
 *  @param month 月
 *
 *  @return 获取某月的天数
 */
- (NSUInteger)lm_daysInMonth:(NSUInteger)month;

/**
 *  判断是否是闰年
 *
 *  @return 闰年/平年
 */
- (BOOL)lm_isLeapYear;

/**
 *  years年后的日期
 *
 *  @param years 年
 *
 *  @return 日期
 */
- (NSDate *)lm_offsetYears:(NSInteger)years;

/**
 *  months月后的日期
 *
 *  @param months 月
 *
 *  @return 日期
 */
- (NSDate *)lm_offsetMonths:(NSInteger)months;

/**
 *  days天的日期
 *
 *  @param days 天
 *
 *  @return 日期
 */
- (NSDate *)lm_offsetDays:(NSInteger)days;

/**
 *  hours小时后的日期
 *
 *  @param hours 小时
 *
 *  @return 日期
 */
- (NSDate *)lm_offsetHours:(NSInteger)hours;

@end

@interface NSString (LMDateFormat)

/**
 *  将NSString转为NSDate
 *
 *  @param format LMDateFormat
 *
 *  @return NSDate
 */
- (NSDate *)lm_dateWithDateFormat:(LMDateFormat)format;

@end
