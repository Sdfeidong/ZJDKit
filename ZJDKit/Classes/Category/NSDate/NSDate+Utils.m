//
//  NSDate+Utils.m
//  V6
//
//  Created by aidong on 15/8/11.
//  Copyright (c) 2015年 aidong. All rights reserved.
//

#import "NSDate+Utils.h"

#define DATE_COMPONENTS     (NSCalendarUnitYear| NSCalendarUnitMonth | NSCalendarUnitDay |  NSCalendarUnitHour |  NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekday | NSCalendarUnitWeekdayOrdinal)
#define CURRENT_CALENDAR    [NSCalendar currentCalendar]

#define D_MINUTE            (60.f)
#define D_HOUR              (60.f    * D_MINUTE)
#define D_DAY               (24.f    * D_HOUR)
#define D_WEEK              (7.f     * D_DAY)
#define D_YEAR              (365.f   * D_DAY)

@implementation NSDate (Utils)

+ (NSDate *)dateWithYear:(NSInteger)year
                   month:(NSInteger)month
                     day:(NSInteger)day
                    hour:(NSInteger)hour
                  minute:(NSInteger)minute
                  second:(NSInteger)second{
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSTimeZone *systemTimeZone = [NSTimeZone systemTimeZone];
    
    NSDateComponents *dateComps = [[NSDateComponents alloc] init];
    [dateComps setCalendar:gregorian];
    [dateComps setYear:year];
    [dateComps setMonth:month];
    [dateComps setDay:day];
    [dateComps setTimeZone:systemTimeZone];
    [dateComps setHour:hour];
    [dateComps setMinute:minute];
    [dateComps setSecond:second];
    
    return [dateComps date];
}

+ (NSInteger)daysOffsetBetweenStartDate:(NSDate *)startDate endDate:(NSDate *)endDate
{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    unsigned int unitFlags = NSCalendarUnitDay;
    NSDateComponents *comps = [gregorian components:unitFlags fromDate:startDate  toDate:endDate  options:0];
    NSInteger days = [comps day];
    return days;
}

+ (NSDate *)dateWithHour:(int)hour
                  minute:(int)minute
{
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:now];
    [components setHour:hour];
    [components setMinute:minute];
    NSDate *newDate = [calendar dateFromComponents:components];
    return newDate;
}

#pragma mark - Data component

- (NSDateComponents *)dateComponents{
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute fromDate:self];
    return dateComponents;
}
- (NSInteger)year
{
    return [[self dateComponents] year];
}

- (NSInteger)month
{
    return [[self dateComponents] month];
}

- (NSInteger)day
{
    return [[self dateComponents] day];
}

- (NSInteger)hour
{
    return [[self dateComponents] hour];
}

- (NSInteger)minute
{
    return [[self dateComponents] minute];
}

- (NSInteger)second
{
    return [[self dateComponents] second];
}

- (NSString *)weekday
{
    //    NSCalendar*calendar = [NSCalendar currentCalendar];
    //    // 当前时间？
    //    NSDateComponents*comps;
    //    NSDate *date = [NSDate date];
    //    comps =[calendar components:(NSWeekCalendarUnit | NSWeekdayCalendarUnit |NSWeekdayOrdinalCalendarUnit)
    //                       fromDate:date];
    
    NSInteger weekday = [[self dateComponents] weekday]; // 星期几（注意，周日是“1”，周一是“2”。。。）
    NSString *week = @"";
    switch (weekday) {
        case 1:
            week = @"星期日";
            break;
        case 2:
            week = @"星期一";
            break;
        case 3:
            week = @"星期二";
            break;
        case 4:
            week = @"星期三";
            break;
        case 5:
            week = @"星期四";
            break;
        case 6:
            week = @"星期五";
            break;
        case 7:
            week = @"星期六";
            break;
            
        default:
            break;
    }
    
    return week;
}


#pragma mark - Time string
- (NSString *)timeHourMinute
{
    
    return [self timeHourMinuteWithPrefix:NO suffix:NO];
}

- (NSString *)timeHourMinuteWithPrefix
{
    return [self timeHourMinuteWithPrefix:YES suffix:NO];
}

- (NSString *)timeHourMinuteWithSuffix
{
    return [self timeHourMinuteWithPrefix:NO suffix:YES];
}

- (NSString *)timeHourMinuteWithPrefix:(BOOL)enablePrefix suffix:(BOOL)enableSuffix
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"HH:mm"];
    NSString *timeStr = [formatter stringFromDate:self];
    if (enablePrefix) {
        timeStr = [NSString stringWithFormat:@"%@%@",([self hour] > 12 ? @"下午" : @"上午"),timeStr];
    }
    if (enableSuffix) {
        timeStr = [NSString stringWithFormat:@"%@%@",([self hour] > 12 ? @"pm" : @"am"),timeStr];
    }
    return timeStr;
}


#pragma mark - Date String
- (NSString *)stringTime
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"HH:mm"];
    NSString *str = [formatter stringFromDate:self];
    return str;
}

- (NSString *)stringMonthDay
{
    return [NSDate dateMonthDayWithDate:self];
}

- (NSString *)stringYearMonthDay
{
    return [NSDate stringYearMonthDayWithDate:self];
}

- (NSString *)stringYearMonthDayHourMinuteSecond
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *str = [formatter stringFromDate:self];
    return str;
    
}

- (NSString *)stringYearMonthDayCompareToday
{
    NSString *str;
    NSInteger chaDay = [self daysBetweenCurrentDateAndDate];
    if (chaDay == 0) {
        str = @"今天";            // Today
    }
    else if (chaDay == 1){
        str = @"明天";            // Tomorrow
    }else if (chaDay == -1){
        str = @"昨天";            // Yesterday
    }
    else{
        str = [self stringYearMonthDay];
    }
    
    return str;
}

+ (NSString *)stringLoacalDate
{
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    [format  setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: date];
    NSDate *localeDate = [date  dateByAddingTimeInterval: interval];
    NSString *dateStr = [format stringFromDate:localeDate];
    
    return dateStr;
}

+ (NSString *)stringYearMonthDayWithDate:(NSDate *)date
{
    if (date == nil) {
        date = [NSDate date];
    }
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *str = [formatter stringFromDate:date];
    return str;
}

+ (NSString *)dateMonthDayWithDate:(NSDate *)date
{
    if (date == nil) {
        date = [NSDate date];
    }
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"MM.dd"];
    NSString *str = [formatter stringFromDate:date];
    return str;
}


#pragma mark - Date formate

+ (NSString *)dateFormatString {
    return @"yyyy-MM-dd";
}

+ (NSString *)timeFormatString {
    return @"HH:mm:ss";
}

+ (NSString *)timestampFormatString {
    return @"yyyy-MM-dd HH:mm:ss";
}

+ (NSString *)timestampFormatStringSubSeconds
{
    return @"yyyy-MM-dd HH:mm";
}

#pragma mark - Date adjust
- (NSDate *) dateByAddingDays: (NSInteger) dDays
{
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + D_DAY * dDays;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

- (NSDate *) dateBySubtractingDays: (NSInteger) dDays
{
    return [self dateByAddingDays: (dDays * -1)];
}

#pragma mark - Relative Dates
+ (NSDate *) dateWithDaysFromNow: (NSInteger) days
{
    // Thanks, Jim Morrison
    return [[NSDate date] dateByAddingDays:days];
}

+ (NSDate *) dateWithDaysBeforeNow: (NSInteger) days
{
    // Thanks, Jim Morrison
    return [[NSDate date] dateBySubtractingDays:days];
}

+ (NSDate *) dateTomorrow
{
    return [NSDate dateWithDaysFromNow:1];
}

+ (NSDate *) dateYesterday
{
    return [NSDate dateWithDaysBeforeNow:1];
}

+ (NSDate *) dateWithHoursFromNow: (NSInteger) dHours
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + D_HOUR * dHours;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

+ (NSDate *) dateWithHoursBeforeNow: (NSInteger) dHours
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - D_HOUR * dHours;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

+ (NSDate *) dateWithMinutesFromNow: (NSInteger) dMinutes
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + D_MINUTE * dMinutes;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

+ (NSDate *) dateWithMinutesBeforeNow: (NSInteger) dMinutes
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - D_MINUTE * dMinutes;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}


- (BOOL) isEqualToDateIgnoringTime: (NSDate *) aDate
{
    NSDateComponents *components1 = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
    NSDateComponents *components2 = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:aDate];
    return ((components1.year == components2.year) &&
            (components1.month == components2.month) &&
            (components1.day == components2.day));
}


+ (NSDate *) dateStandardFormatTimeZeroWithDate: (NSDate *) aDate{
    NSString *str = [[NSDate stringYearMonthDayWithDate:aDate]stringByAppendingString:@" 00:00:00"];
    NSDate *date = [NSDate dateFromString:str];
    return date;
}

- (NSInteger) daysBetweenCurrentDateAndDate
{
    //只取年月日比较
    NSDate *dateSelf = [NSDate dateStandardFormatTimeZeroWithDate:self];
    NSTimeInterval timeInterval = [dateSelf timeIntervalSince1970];
    NSDate *dateNow = [NSDate dateStandardFormatTimeZeroWithDate:nil];
    NSTimeInterval timeIntervalNow = [dateNow timeIntervalSince1970];
    
    NSTimeInterval cha = timeInterval - timeIntervalNow;
    CGFloat chaDay = cha / 86400.0;
    NSInteger day = chaDay * 1;
    return day;
}

#pragma mark - Date and string convert
+ (NSDate *)dateFromString:(NSString *)string {
    return [NSDate dateFromString:string withFormat:[NSDate dbFormatString]];
}

+ (NSDate *)dateFromString:(NSString *)string withFormat:(NSString *)format {
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setDateFormat:format];
    NSDate *date = [inputFormatter dateFromString:string];
    return date;
}

- (NSString *)string {
    return [self stringWithFormat:[NSDate dbFormatString]];
}

- (NSString *)stringCutSeconds
{
    return [self stringWithFormat:[NSDate timestampFormatStringSubSeconds]];
}

- (NSString *)stringWithFormat:(NSString *)format {
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:format];
    NSString *timestamp_str = [outputFormatter stringFromDate:self];
    return timestamp_str;
}

+ (NSString *)dbFormatString {
    return [NSDate timestampFormatString];
}

#pragma mark - Date and Timestamp

/** 获取当前时间,返回时间 */
+ (NSDate *)getCurrentDate{
    
    // 时区是默认当地时区
    NSDate *localeDate = [NSDate date];
    return localeDate;
}

/** 获取当前时间的时间戳,返回字符串 */
+ (NSString *)getCurrentDateTimestamp{
    return [self getTimestampFromDate:[self getCurrentDate]];
}

/**
 *  格式时间 转 NSDate
 */
+ (NSDate *)getDateWithDateString:(NSString *)dateString formatter:(NSString *)formatter{
    // "1900-01-01";
    // yyyy-MM-dd
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
    // 校正时区
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    [dateFormatter setDateFormat:formatter];
    NSDate *date=[dateFormatter dateFromString:dateString];
    return date;
}

/**
 *  格式时间 转 时间戳 （如：时间2015-10-15 --> 1478900000)
 
 */
+ (NSString *)getTimestampWithDateString:(NSString *)dateString formatter:(NSString *)formatter {
    
    // 原格式时间转 NSDate
    NSDate *originDate = [NSDate getDateWithDateString:dateString formatter:formatter];
    // NSDate 转 时间戳
    return [NSDate getTimestampFromDate:originDate];
}

/**
 *  格式时间 转 其它格式时间 （如：2015-10-15 转 2015年10月15日)
 */
+ (NSString *)getDateStringWithFormatString:(NSString *)formatter
                           originDateString:(NSString *)originDateString
                         originFormatString:(NSString *)originFormatString {
    
    /** formatter
     *
     yyyy-MM-dd
     yyyyMMdd
     yyyyMMddHHmmss
     yyyy-MM-dd HH:mm
     yyyy-MM-dd HH:mm:ss
     yyyy年MM月dd日
     */
    
    // 格式时间 转 时间戳
    NSString *originTimesp = [NSDate getTimestampWithDateString:originDateString formatter:originFormatString];
    // 时间戳 转 格式时间
    NSString *dateString = [NSDate setDateWithFormatString:formatter Timestamp:originTimesp];
    return dateString;
}
/**
 *  通过 NSDate 获取时间戳
 */
+ (NSString *)getTimestampFromDate:(NSDate *)date{
    
    NSTimeInterval timeInterval = [date timeIntervalSince1970];
    NSString *timestamp = [NSString stringWithFormat:@"%.f", timeInterval];
    return timestamp;
}
/**
 *  Formatter 格式 yyyyMMddHHmmss
 *  Timestamp 10位时间戳
 */
+ (NSString *)setDateWithFormatString:(NSString *)formatter Timestamp:(NSString *)timesp{
    
    if (![timesp isKindOfClass:[NSString class]]) {
        timesp = [NSString stringWithFormat:@"%@",timesp];
    }
    
    // 13位时间戳需要做截取 前10位
    if (timesp.length == 10 || timesp.length == 13) {
        
        timesp = (timesp.length == 13) ? [timesp substringToIndex:10] : timesp;
        
    } else {
        NSLog(@"时间戳格式不正确! %lu位 : %@",(unsigned long)timesp.length,timesp);
        return nil;
    }
    
    // 设置时间格式
    NSDateFormatter *dateFormatter = [NSDate setDateFormatterWithFormatterString:formatter];
    // 返回时间字符串
    return [NSDate setDateStringWithTimesTamp:timesp dateFomatter:dateFormatter];
}
/**
 设置dateFormatter 默认 @“yyyy-MM-dd”
 */
+ (NSDateFormatter *)setDateFormatterWithFormatterString:(NSString *)formatterString {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    // 校正时区
    // GMT时间，这个时间和北京时间相差8小时
    // [NSTimeZone timeZoneWithName:@"GMT"]
    
    // 默认系统时区
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    [dateFormatter setTimeZone:zone];
    
    if (formatterString) {
        [dateFormatter setDateFormat:formatterString];
    } else {
        // 默认
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    }
    return dateFormatter;
}
/**
 根据 时间戳 和 时间格式（NSDateFormatter）设置时间显示样式 如：2016-09-16
 */
+ (NSString *)setDateStringWithTimesTamp:(NSString *)timesp dateFomatter:(NSDateFormatter *)dateFormatter {
    
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[timesp doubleValue]];
    return [dateFormatter stringFromDate:confromTimesp];
}

/**
 *  获取默认日期字符串 2015-11-25
 */
+ (NSString *)getDefaultDateFromTimestamp:(NSString *)timesp{
    
    return [NSDate setDateWithFormatString:nil Timestamp:timesp];
}

/**
 *  获取默认日期字符串 20151125
 */

+ (NSString *)get_yyyyMMdd_DateFromTimestamp:(NSString *)timesp{
    
    return [NSDate setDateWithFormatString:@"yyyyMMdd" Timestamp:timesp];
}

/**
 *  获取默认日期字符串 20151125120101
 */
+ (NSString *)get_yyyyMMddHHmmss_DateFromTimestamp:(NSString *)timesp{
    
    return [NSDate setDateWithFormatString:@"yyyyMMddHHmmss" Timestamp:timesp];
}


/**
 *  获取日期字符串 2015-11-25 12:00
 */
+ (NSString *)get_yyyy_MM_dd_HH_mm_DateFromTimestamp:(NSString *)timesp{
    
    return [NSDate setDateWithFormatString:@"yyyy-MM-dd HH:mm" Timestamp:timesp];
}

/**
 *  获取日期字符串 2015/11/25 12:00
 */
+ (NSString *)get_yyyyMMdd_HH_mm_DateFromTimestamp:(NSString *)timesp{
    
    return [NSDate setDateWithFormatString:@"yyyy/MM/dd HH:mm" Timestamp:timesp];
}

/**
 *  获取日期字符串 2015-11-25 12:00:00
 */
+ (NSString *)get_yyyy_MM_dd_HH_mm_ss_DateFromTimestamp:(NSString *)timesp{
    
    return [NSDate setDateWithFormatString:@"yyyy-MM-dd HH:mm:ss" Timestamp:timesp];
}

/**
 *  获取日期字符串 2015年11月25日
 */
+ (NSString *)get_Nian_Yue_Ri_DateFromTimestamp:(NSString *)timesp{
    
    return [NSDate setDateWithFormatString:@"yyyy年MM月dd日" Timestamp:timesp];
}

// double 类型
+ (NSString *)convertStringFromInterval:(NSTimeInterval)timeInterval {
    int hour = timeInterval/3600;
    int min = (int)timeInterval%3600/60;
    int second = (int)timeInterval%3600%60;
    if (hour == 0) {
        
    }
    return [NSString stringWithFormat:@"%02d:%02d:%02d", hour, min, second];
}

+ (NSTimeInterval)intervalFromConvertString:(NSString *)timestring {
    
    NSArray *aa = [timestring componentsSeparatedByString:@":"];
    
    if ([aa count]<3) {
        return 0;
    }
    
    return [[aa objectAtIndex:2] integerValue]+[[aa objectAtIndex:1] integerValue]*60+[[aa objectAtIndex:0] integerValue]*3600;
}

/**
 *  某个时间据当前时间多少天之内
 */
+ (BOOL)isFromCurrentTimeToTimestamp:(NSString *)timesp TheDays:(double)days{
    
    NSDate * now = [NSDate date];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[timesp doubleValue]];
    NSTimeInterval interval = [now timeIntervalSinceDate:confromTimesp];
    
    if (interval < 86400 * days) {
        return YES;
    }
    return NO;
}

/**
 *  某两个时间之间有多少秒
 */
+ (NSTimeInterval)intervalFromTimesp:(NSString *)timesp latterTimesp:(NSString *)latterTimesp {
    
    // 13位时间戳需要做截取 前10位
    if (timesp.length == 10 || timesp.length == 13) {
        timesp = (timesp.length == 13) ? [timesp substringToIndex:10] : timesp;
    }
    
    // 13位时间戳需要做截取 前10位
    if (latterTimesp.length == 10 || latterTimesp.length == 13) {
        latterTimesp = (latterTimesp.length == 13) ? [latterTimesp substringToIndex:10] : latterTimesp;
    }
    
    double Interval = [latterTimesp doubleValue] - [timesp doubleValue];
    return Interval;
}

/**
 *  获取据当前时间字符串 "刚刚" "15分钟前"或者"2012-08-10" 等
 */
+ (NSString *)getDatetimeFromCurrentTimeToTimestamp:(NSString *)timesp{
    
    NSDate * now = [NSDate date];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[timesp doubleValue]];
    NSTimeInterval interval = [now timeIntervalSinceDate:confromTimesp];
    
    if(interval<60){
        return @"刚刚";
    }
    if (interval<3600) {
        int ii=interval/60;
        
        return [NSString stringWithFormat:@"%d分钟前",ii];
    }
    if (interval<86400) {
        int ii=interval/60/60;
        
        return [NSString stringWithFormat:@"%d小时前",ii];
    }
    else{
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        return [dateFormatter stringFromDate:confromTimesp];
    }
}

/**
 *  获取日期时间字符串 "08-10 晚上08:09:41.0" "昨天 上午10:09"或者"2012-08-10 凌晨07:09" 等
 */
+ (NSString *)getDateTimeFromTimestamp:(NSString *)timesp
{
    
    NSString *formatStr = @"yyyy-MM-dd HH:mm:ss";
    NSString *midStr = [NSDate setDateWithFormatString:formatStr Timestamp:timesp];
    
    NSDate *lastDate = [NSDate dateFromString:midStr withFormat:formatStr];
    
    NSString *dateStr;  //年月日
    NSString *period;   //时间段
    NSString *hour;     //时
    
    if ([lastDate year]==[[NSDate date] year]) {
        NSInteger days = [NSDate daysOffsetBetweenStartDate:lastDate endDate:[NSDate date]];
        if (days <= 2) {
            dateStr = [lastDate stringYearMonthDayCompareToday];
        }else{
            dateStr = [lastDate stringMonthDay];
        }
    }else{
        dateStr = [lastDate stringYearMonthDay];
    }
    
    
    if ([lastDate hour]>=5 && [lastDate hour]<12) {
        period = @"上午"; // @"AM"
        hour = [NSString stringWithFormat:@"%02d",(int)[lastDate hour]];
    }else if ([lastDate hour]>=12 && [lastDate hour]<=18){
        period = @"下午"; // @"PM"
        hour = [NSString stringWithFormat:@"%02d",(int)[lastDate hour]-12];
    }else if ([lastDate hour]>18 && [lastDate hour]<=23){
        period = @"晚上"; // @"Night"
        hour = [NSString stringWithFormat:@"%02d",(int)[lastDate hour]-12];
    }else{
        period = @"凌晨"; // @"Dawn"
        hour = [NSString stringWithFormat:@"%02d",(int)[lastDate hour]];
    }
    
    return [NSString stringWithFormat:@"%@ %@ %@:%02d",dateStr,period,hour,(int)[lastDate minute]];
}

@end
