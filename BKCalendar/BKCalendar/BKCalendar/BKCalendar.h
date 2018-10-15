//
//  BKCalendar.h
//  MySelfFrame
//
//  Created by BIKE on 17/2/16.
//  Copyright © 2017年 BIKE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BKCalendarViewController.h"

#define BKCalendarRedColor [UIColor colorWithRed:252/255.0f green:61/255.0f blue:57/255.0f alpha:1]

@interface BKCalendar : NSObject


+(instancetype)shareManager;

/**
 获取当月日期

 @param index 2为下下个月 1为下个月 0为当月 -1为上个月 -2为上上个月 以此类推

 @return 当月日期
 */
-(NSDate *)getMonthDateWithindex:(NSInteger)index;

/**
 获取月日期
 
 @param currentDate 目前时间
 @param index 2为下下个月 1为下个月 0为当月 -1为上个月 -2为上上个月 以此类推
 @return 月日期
 */
-(NSDate*)currentDate:(NSDate*)currentDate getOtherMonthOfIndex:(NSInteger)index;

/**
 根据当日日期获取该日期在当月是几号
 
 @param date 日期
 @return 几号
 */
-(NSInteger)getDayNumberOfMonthDate:(NSDate*)date;

/**
 根据当月日期获取当月天数

 @param date 当月日期

 @return 当月天数
 */
-(NSInteger)getNumberOfDaysInMonthDate:(NSDate*)date;

/**
 根据当月日期获取当月第几天日期
 
 @param date 当月日期
 @param index 1为第一天 2为第二天 以此类推
 
 @return 当月第几天日期
 */
-(NSDate*)getDayDateInMonthDate:(NSDate*)date andIndex:(NSInteger)index;

/**
 根据当日日期获取当日为星期几
 
 @param date 当日日期
 
 @return 0是星期天 1是星期一 2是星期二 3是星期三 4是星期四 5是星期五 6是星期六
 */
-(NSInteger)getNumberInWeekDate:(NSDate*)date;

/**
 根据当日日期获取当日在中国日历的日期
 
 @param date 当日日期
 
 @return 当日在中国日历的日期
 */
-(NSString*)getChineseNumberInMonthDate:(NSDate*)date;

/**
 根据当月日期获取当月月份
 
 @param date 当月日期
 
 @return 当月月份 1是一月 2是二月
 */
-(NSInteger)getMonthNumberInYearDate:(NSDate*)date;

/**
 根据日期获取当年年份
 
 @param date 日期
 
 @return 当年年份
 */
-(NSInteger)getYearNumberWithDate:(NSDate*)date;

/**
 根据日期获取中国当年年份
 
 @param date 日期
 
 @return 中国当年年份
 */
-(NSString*)getChineseYearNumberWithDate:(NSDate*)date;

/**
 转化时间
 
 @param date date
 
 @return 转化时区后date
 */
-(NSDate*)transformDate:(NSDate*)date;

@end
