//
//  NSDate+Utils.h
//  V6
//
//  Created by aidong on 15/8/11.
//  Copyright (c) 2015年 aidong. All rights reserved.
//

#import <Foundation/Foundation.h>

#define D_MINUTE            (60.f)
#define D_HOUR              (60.f    * D_MINUTE)
#define D_DAY               (24.f    * D_HOUR)
#define D_WEEK              (7.f     * D_DAY)
#define D_YEAR              (365.f   * D_DAY)

@interface NSDate (Utils)

+ (NSDate *)dateWithYear:(NSInteger)year
                   month:(NSInteger)month
                     day:(NSInteger)day
                    hour:(NSInteger)hour
                  minute:(NSInteger)minute
                  second:(NSInteger)second;

+ (NSInteger)daysOffsetBetweenStartDate:(NSDate *)startDate endDate:(NSDate *)endDate;

+ (NSDate *)dateWithHour:(int)hour
                  minute:(int)minute;

#pragma mark - Getter
- (NSInteger)year;
- (NSInteger)month;
- (NSInteger)day;
- (NSInteger)hour;
- (NSInteger)minute;
- (NSInteger)second;
- (NSString *)weekday;


#pragma mark - Time string
- (NSString *)timeHourMinute;
- (NSString *)timeHourMinuteWithPrefix;
- (NSString *)timeHourMinuteWithSuffix;
- (NSString *)timeHourMinuteWithPrefix:(BOOL)enablePrefix suffix:(BOOL)enableSuffix;

#pragma mark - Date String
- (NSString *)stringTime;
- (NSString *)stringMonthDay;
- (NSString *)stringYearMonthDay;
- (NSString *)stringYearMonthDayHourMinuteSecond;
+ (NSString *)stringYearMonthDayWithDate:(NSDate *)date;      //date为空时返回的是当前年月日
+ (NSString *)stringLoacalDate;

#pragma mark - Date formate
+ (NSString *)dateFormatString;
+ (NSString *)timeFormatString;
+ (NSString *)timestampFormatString;
+ (NSString *)timestampFormatStringSubSeconds;

#pragma mark - Date adjust
- (NSDate *) dateByAddingDays: (NSInteger) dDays;
- (NSDate *) dateBySubtractingDays: (NSInteger) dDays;

#pragma mark - Relative dates from the date
+ (NSDate *) dateTomorrow;
+ (NSDate *) dateYesterday;
+ (NSDate *) dateWithDaysFromNow: (NSInteger) days;
+ (NSDate *) dateWithDaysBeforeNow: (NSInteger) days;
+ (NSDate *) dateWithHoursFromNow: (NSInteger) dHours;
+ (NSDate *) dateWithHoursBeforeNow: (NSInteger) dHours;
+ (NSDate *) dateWithMinutesFromNow: (NSInteger) dMinutes;
+ (NSDate *) dateWithMinutesBeforeNow: (NSInteger) dMinutes;
+ (NSDate *) dateStandardFormatTimeZeroWithDate: (NSDate *) aDate;  //标准格式的零点日期
- (NSInteger) daysBetweenCurrentDateAndDate;                     //负数为过去，正数为未来

#pragma mark - Date compare
- (BOOL)isEqualToDateIgnoringTime: (NSDate *) aDate;
- (NSString *)stringYearMonthDayCompareToday;                 //返回“今天”，“明天”，“昨天”，或年月日

#pragma mark - Date and string convert
+ (NSDate *)dateFromString:(NSString *)string;
+ (NSDate *)dateFromString:(NSString *)string withFormat:(NSString *)format;
- (NSString *)string;
- (NSString *)stringCutSeconds;

#pragma mark - Date and Timestamp and DateString
/** 获取当前时间,返回时间 */
+ (NSDate *)getCurrentDate;

/** 获取当前时间的时间戳,返回字符串 */
+ (NSString *)getCurrentDateTimestamp;

/**
 *  格式时间 转 NSDate（如：时间2015-10-15)
 */
+ (NSDate *)getDateWithDateString:(NSString *)dateString formatter:(NSString *)formatter;

/**
 *  格式时间 转 时间戳 （如：时间2015-10-15)
 
 */
+ (NSString *)getTimestampWithDateString:(NSString *)dateString formatter:(NSString *)formatter;

/**
 *  格式时间 转 其它格式时间 （如：2015-10-15 转 2015年10月15日)
 */
+ (NSString *)getDateStringWithFormatString:(NSString *)formatter
                           originDateString:(NSString *)originDateString
                         originFormatString:(NSString *)originFormatString;
/**
 *  通过 NSDate 获取时间戳
 */
+ (NSString *)getTimestampFromDate:(NSDate *)date;

/**
 *  Formatter 格式 yyyyMMddHHmmss
 *  Timestamp 10位时间戳
 *  获取日期字符串 Formatter样式 如：2016-09-15
 */
+ (NSString *)setDateWithFormatString:(NSString *)formatter Timestamp:(NSString *)timesp;

/**
 设置dateFormatter 默认 @“yyyy-MM-dd”
 */
+ (NSDateFormatter *)setDateFormatterWithFormatterString:(NSString *)formatterString;

/**
 根据 时间戳 和 时间格式（NSDateFormatter）设置时间显示样式 如：2016-09-16
 */
+ (NSString *)setDateStringWithTimesTamp:(NSString *)timesp dateFomatter:(NSDateFormatter *)dateFormatter;

/**
 *  获取默认日期字符串 2015-11-25
 */
+ (NSString *)getDefaultDateFromTimestamp:(NSString *)timesp;

/**
 *  获取日期字符串 20151125
 */
+ (NSString *)get_yyyyMMdd_DateFromTimestamp:(NSString *)timesp;

/**
 *  获取日期字符串 20151125120101
 */
+ (NSString *)get_yyyyMMddHHmmss_DateFromTimestamp:(NSString *)timesp;

/**
 *  获取日期字符串 2015-11-25 12:00
 */
+ (NSString *)get_yyyy_MM_dd_HH_mm_DateFromTimestamp:(NSString *)timesp;

/**
 *  获取日期字符串 2015/11/25 12:00
 */
+ (NSString *)get_yyyyMMdd_HH_mm_DateFromTimestamp:(NSString *)timesp;

/**
 *  获取日期字符串 2015-11-25 12:00:00
 */
+ (NSString *)get_yyyy_MM_dd_HH_mm_ss_DateFromTimestamp:(NSString *)timesp;

/**
 *  获取日期字符串 2015年11月25日
 */
+ (NSString *)get_Nian_Yue_Ri_DateFromTimestamp:(NSString *)timesp;


/**
 *  某个时间据当前时间多少天之内
 */
+ (BOOL)isFromCurrentTimeToTimestamp:(NSString *)timesp TheDays:(double)days;

/**
 *  某两个时间之间有多少秒
 */
+ (NSTimeInterval)intervalFromTimesp:(NSString *)timesp latterTimesp:(NSString *)latterTimesp;

+ (NSString *)convertStringFromInterval:(NSTimeInterval)timeInterval;

/**
 *  某个时间据当前时间多少秒
 */
+ (NSTimeInterval)intervalFromConvertString:(NSString *)timestring;

/**
 *  获取日期时间字符串 "刚刚" "15分钟前"或者"2012-08-10" 等
 */
+ (NSString *)getDatetimeFromCurrentTimeToTimestamp:(NSString *)timesp;

/**
 *  获取日期时间字符串 "08-10 晚上08:09:41.0" "昨天 上午10:09"或者"2012-08-10 凌晨07:09" 等
 */
+ (NSString *)getDateTimeFromTimestamp:(NSString *)timesp;


@end
