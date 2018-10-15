//
//  BKCalendar.m
//  MySelfFrame
//
//  Created by BIKE on 17/2/16.
//  Copyright © 2017年 BIKE. All rights reserved.
//

#import "BKCalendar.h"

@interface BKCalendar()

@property (nonatomic,strong) NSCalendar * calendar;
@property (nonatomic,strong) NSCalendar * chineseCalendar;

@end

@implementation BKCalendar

-(NSCalendar*)calendar
{
    if (!_calendar) {
        _calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    }
    return _calendar;
}

-(NSCalendar*)chineseCalendar
{
    if (!_chineseCalendar) {
        _chineseCalendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierChinese];
    }
    return _chineseCalendar;
}

static BKCalendar * calendar = nil;
+(instancetype)shareManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        calendar = [[self alloc] init];
    });
    
    return calendar;
}

/**
 获取当月日期
 
 @param index 2为下下个月 1为下个月 0为当月 -1为上个月 -2为上上个月 以此类推
 
 @return 当月日期
 */
-(NSDate *)getMonthDateWithindex:(NSInteger)index
{
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.month = index;
    NSDate *nextMonthDate = [[self calendar] dateByAddingComponents:components toDate:[NSDate date] options:NSCalendarMatchStrictly];
    return [self transformDate:nextMonthDate];
}

/**
 获取月日期

 @param currentDate 目前时间
 @param index 2为下下个月 1为下个月 0为当月 -1为上个月 -2为上上个月 以此类推
 @return 月日期
 */
-(NSDate*)currentDate:(NSDate*)currentDate getOtherMonthOfIndex:(NSInteger)index
{
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.month = index;
    NSDate *nextMonthDate = [[self calendar] dateByAddingComponents:components toDate:currentDate options:NSCalendarMatchStrictly];
    return [self transformDate:nextMonthDate];
}

/**
 根据当月日期获取当月天数
 
 @param date 当月日期
 
 @return 当月天数
 */
-(NSInteger)getNumberOfDaysInMonthDate:(NSDate*)date
{
    NSRange range = [[self calendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    return range.length;
}

/**
 根据当日日期获取该日期在当月是几号

 @param date 日期
 @return 几号
 */
-(NSInteger)getDayNumberOfMonthDate:(NSDate*)date
{
    NSDateComponents * components = [[self calendar] components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:date];
    return components.day;
}

/**
 根据当月日期获取当月第几天日期
 
 @param date 当月日期
 @param index 1为第一天 2为第二天 以此类推
 
 @return 当月第几天日期
 */
-(NSDate*)getDayDateInMonthDate:(NSDate*)date andIndex:(NSInteger)index
{
    NSDateComponents *components = [[self calendar] components:NSCalendarUnitYear | NSCalendarUnitMonth fromDate:date];
    components.day = index;
    NSDate *firstDay = [[self calendar] dateFromComponents:components];
    
    return [self transformDate:firstDay];
}

/**
 根据当日日期获取当日为星期几

 @param date 当日日期

 @return 0是星期天 1是星期一 2是星期二 3是星期三 4是星期四 5是星期五 6是星期六
 */
-(NSInteger)getNumberInWeekDate:(NSDate*)date
{
    NSArray * weeks = @[[NSNull null],@"7",@"1",@"2",@"3",@"4",@"5",@"6"];
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    NSDateComponents * components = [[self calendar] components:calendarUnit fromDate:date];
    NSInteger index = [[weeks objectAtIndex:components.weekday] integerValue];
    if (index == 7) {
        return 0;
    }
    return index;
}

/**
 根据当日日期获取当日在中国日历的日期
 
 @param date 当日日期
 
 @return 当日在中国日历的日期
 */
-(NSString*)getChineseNumberInMonthDate:(NSDate*)date
{
    NSArray * chineseDays = [NSArray arrayWithObjects:
                          @"初一",@"初二",@"初三",@"初四",@"初五",@"初六",@"初七",@"初八",@"初九",@"初十",@"十一",@"十二",@"十三",@"十四",@"十五",@"十六",@"十七",@"十八",@"十九",@"二十",@"廿一",@"廿二",@"廿三",@"廿四",@"廿五",@"廿六",@"廿七",@"廿八",@"廿九",@"三十",nil];
    
    NSArray * chineseMonths = [NSArray arrayWithObjects:
                            @"正月",@"二月",@"三月",@"四月",@"五月",@"六月",@"七月",@"八月",@"九月",@"十月",@"冬月",@"腊月",nil];

    NSDateComponents * components = [[self chineseCalendar] components: NSCalendarUnitMonth | NSCalendarUnitDay fromDate:date];
    NSString * day = [chineseDays objectAtIndex:components.day - 1];
    
    if ([day isEqualToString:@"初一"]) {
        return [chineseMonths objectAtIndex:components.month - 1];
    }
    
    return day;
}

/**
 根据当月日期获取当月月份
 
 @param date 当月日期
 
 @return 当月月份 1是一月 2是二月
 */
-(NSInteger)getMonthNumberInYearDate:(NSDate*)date
{
    NSDateComponents * components = [[self calendar] components:NSCalendarUnitMonth fromDate:date];
    return components.month;
}

/**
 根据日期获取当年年份
 
 @param date 日期
 
 @return 当年年份
 */
-(NSInteger)getYearNumberWithDate:(NSDate*)date
{
    NSDateComponents * components = [[self calendar] components:NSCalendarUnitYear fromDate:date];
    return components.year;
}

/**
 根据日期获取中国当年年份
 
 @param date 日期
 
 @return 中国当年年份
 */
-(NSString*)getChineseYearNumberWithDate:(NSDate*)date
{
    NSArray * chineseYears = [NSArray arrayWithObjects:
                             @"甲子",@"乙丑",@"丙寅",@"丁卯",@"戊辰",@"己巳",@"庚午",@"辛未",@"壬申",@"癸酉",
                             @"甲戌",@"乙亥",@"丙子",@"丁丑",@"戊寅",@"己卯",@"庚辰",@"辛己",@"壬午",@"癸未",
                             @"甲申",@"乙酉",@"丙戌",@"丁亥",@"戊子",@"己丑",@"庚寅",@"辛卯",@"壬辰",@"癸巳",
                             @"甲午",@"乙未",@"丙申",@"丁酉",@"戊戌",@"己亥",@"庚子",@"辛丑",@"壬寅",@"癸丑",
                             @"甲辰",@"乙巳",@"丙午",@"丁未",@"戊申",@"己酉",@"庚戌",@"辛亥",@"壬子",@"癸丑",
                             @"甲寅",@"乙卯",@"丙辰",@"丁巳",@"戊午",@"己未",@"庚申",@"辛酉",@"壬戌",@"癸亥", nil];

    NSDateComponents * components = [[self chineseCalendar] components:NSCalendarUnitYear fromDate:date];
    NSString * year = [chineseYears objectAtIndex:components.year - 1];
    
    return year;
}

/**
 转化时间

 @param date date

 @return 转化时区后date
 */
-(NSDate*)transformDate:(NSDate*)date
{
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:date];
    NSDate *localeDate = [date dateByAddingTimeInterval:interval];
    return localeDate;
}

@end
