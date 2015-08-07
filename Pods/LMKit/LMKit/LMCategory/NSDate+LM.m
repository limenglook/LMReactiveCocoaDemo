//
//  NSDate+LM.m
//  LMCategory
//
//  Created by 李蒙 on 15/7/9.
//  Copyright (c) 2015年 李蒙. All rights reserved.
//

#import "NSDate+LM.h"

@implementation NSDate (LM)

#pragma mark 将NSDate转为NSString
 
- (NSString *)lm_stringWithDateFormat:(LMDateFormat)format
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:[NSDate formatString:format]];
    NSString *date_time = [NSString stringWithString:[dateFormatter stringFromDate:self]];
    
    return date_time;
}

+ (NSString *)formatString:(LMDateFormat)format
{
    NSString *formatString;
    switch (format) {
        case LMDateFormatWithAll:
            formatString = @"yyyy-MM-dd HH:mm:ss:SS";
            break;
        case LMDateFormatWithDateAndTime:
            formatString = @"yyyy-MM-dd HH:mm:ss";
            break;
        case LMDateFormatWithTime:
            formatString = @"HH:mm:ss";
            break;
        case LMDateFormatWithTimeHourMinute:
            formatString = @"HH:mm";
            break;
        case LMDateFormatWithPreciseTime:
            formatString = @"HH:mm:ss:SS";
            break;
        case LMDateFormatWithYearMonthDay:
            formatString = @"yyyy-MM-dd";
            break;
        case LMDateFormatWithYearMonth:
            formatString = @"yyyy-MM";
            break;
        case LMDateFormatWithMonthDay:
            formatString = @"MM-dd";
            break;
        case LMDateFormatWithYear:
            formatString = @"yyyy";
            break;
        case LMDateFormatWithMonth:
            formatString = @"MM";
            break;
        case LMDateFormatWithDay:
            formatString = @"dd";
            break;
            
        default:
            break;
    }
    
    return formatString;
}

#pragma mark -.-

#pragma mark 取出年、月、日

- (NSDate *)lm_subDateWithYearMothDay
{
    return [[self lm_stringWithDateFormat:LMDateFormatWithYearMonthDay] lm_dateWithDateFormat:LMDateFormatWithYearMonthDay];
}

#pragma mark 是否为今天

- (BOOL)lm_isToday
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unit = NSCalendarUnitDay | NSCalendarUnitMonth |  NSCalendarUnitYear;
    
    NSDateComponents *nowComponents = [calendar components:unit fromDate:[NSDate date]];
    
    NSDateComponents *selfComponents = [calendar components:unit fromDate:self];
    
    return (selfComponents.year == nowComponents.year) && (selfComponents.month == nowComponents.month) && (selfComponents.day == nowComponents.day);
}

#pragma mark 是否为昨天

- (BOOL)lm_isYesterday
{
    NSDate *nowDate = [[NSDate date] lm_subDateWithYearMothDay];
    NSDate *selfDate = [self lm_subDateWithYearMothDay];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *cmps = [calendar components:NSCalendarUnitDay fromDate:selfDate toDate:nowDate options:0];
    
    return cmps.day == 1;
}

#pragma mark 是否为今年

- (BOOL)lm_isThisYear
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unit = NSCalendarUnitYear;

    NSDateComponents *nowComponents = [calendar components:unit fromDate:[NSDate date]];
    NSDateComponents *selfComponents = [calendar components:unit fromDate:self];
    
    return nowComponents.year == selfComponents.year;
}

#pragma mark 获得与当前时间的差距

- (NSDateComponents *)lm_deltaWithNow
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSUInteger unit = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    
    return [calendar components:unit fromDate:self toDate:[NSDate date] options:0];
}

#pragma mark - 获取日、月、年、小时、分钟、秒

- (NSUInteger)lm_day
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    NSDateComponents *components = [calendar components:(NSCalendarUnitDay) fromDate:self];
#else
    NSDateComponents *components = [calendar components:(NSDayCalendarUnit) fromDate:self];
#endif
    
    return [components day];
}

- (NSUInteger)lm_month
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    NSDateComponents *components = [calendar components:(NSCalendarUnitMonth) fromDate:self];
#else
    NSDateComponents *components = [calendar components:(NSMonthCalendarUnit) fromDate:self];
#endif
    
    return [components month];
}

- (NSUInteger)lm_year
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    NSDateComponents *components = [calendar components:(NSCalendarUnitYear) fromDate:self];
#else
    NSDateComponents *components = [calendar components:(NSYearCalendarUnit) fromDate:self];
#endif
    
    return [components year];
}

- (NSUInteger)lm_hour
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    NSDateComponents *components = [calendar components:(NSCalendarUnitHour) fromDate:self];
#else
    NSDateComponents *components = [calendar components:(NSHourCalendarUnit) fromDate:self];
#endif
    
    return [components hour];
}

- (NSUInteger)lm_minute
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    NSDateComponents *components = [calendar components:(NSCalendarUnitMinute) fromDate:self];
#else
    NSDateComponents *components = [calendar components:(NSMinuteCalendarUnit) fromDate:self];
#endif
    
    return [components minute];
}

- (NSUInteger)lm_second
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    NSDateComponents *components = [calendar components:(NSCalendarUnitSecond) fromDate:self];
#else
    NSDateComponents *components = [calendar components:(NSSecondCalendarUnit) fromDate:self];
#endif
    
    return [components second];
}

#pragma mark - 获取一年的总天数

- (NSUInteger)lm_daysInYear
{
    return [self lm_isLeapYear] ? 366 : 365;
}

#pragma mark - 获取某月的天数

- (NSUInteger)lm_daysInMonth:(NSUInteger)month
{
    if (month > 12) {
        
        return 0;
    }
    
    switch (month) {
        case 1:
        case 3:
        case 5:
        case 7:
        case 8:
        case 10:
        case 12:
            return 31;
            break;
        case 2:
            return [self lm_isLeapYear] ? 29 : 28;
        default:
            return 30;
            break;
    }
}

#pragma mark - 判断是否是闰年

- (BOOL)lm_isLeapYear
{
    NSUInteger year = [self lm_year];
    
    if ((year % 4  == 0 && year % 100 != 0) || year % 400 == 0) {
        
        return YES;
    }
    
    return NO;
}

#pragma mark - offset后的日期

- (NSDate *)lm_offsetYears:(NSInteger)years
{
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
#else
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
#endif
    
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setYear:years];
    
    return [gregorian dateByAddingComponents:components toDate:self options:0];
}

- (NSDate *)lm_offsetMonths:(NSInteger)months
{
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
#else
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
#endif
    
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setMonth:months];
    
    return [gregorian dateByAddingComponents:components toDate:self options:0];
}

- (NSDate *)lm_offsetDays:(NSInteger)days
{
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
#else
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
#endif
    
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setDay:days];
    
    return [gregorian dateByAddingComponents:components toDate:self options:0];
}

- (NSDate *)lm_offsetHours:(NSInteger)hours
{
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
#else
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
#endif
    
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setHour:hours];
    
    return [gregorian dateByAddingComponents:components toDate:self options:0];
}

@end

@implementation NSString (LMDateFormat)

#pragma mark 将NSString转为NSDate

- (NSDate *)lm_dateWithDateFormat:(LMDateFormat)format
{
    NSDateFormatter *LMDateFormatter = [[NSDateFormatter alloc] init];
    
    [LMDateFormatter setDateFormat:[NSDate formatString:format]];
    NSDate *date = [LMDateFormatter dateFromString:self];
    
    return date;
}

@end
