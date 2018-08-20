//
//  NSDate+SA.m
//  OpenMIG
//
//  Created by yusian on 15-3-19.
//  Copyright (c) 2015年 Sian. All rights reserved.
//

#import "NSDate+SA.h"

@implementation NSDate (SA)

// 本周日期字符串数组
+ (NSArray *)currentWeekDays;
{
    NSMutableArray *array = [NSMutableArray array];
    // 获取今天星期几（数字）
    NSInteger today = [self weekDayWithDate:[self date]];
    for (int i = 0; i < 7; i++) {
        // 周一到周日七天距离今天的时间差（以秒为单位）
        double timeInterval = (i + 1 - today) * 24 * 60 * 60;
        // 周一到周日的DATE对象
        NSDate *date = [self dateWithTimeIntervalSinceNow:timeInterval];
        // 周一到周日的字符串对象
        NSString *dateStr = [self formateDate:date];
        // 添加到数组
        [array addObject:dateStr];
    }
    return array;
}

/// 当前日期是否处于本周
- (BOOL)hasBelongThisWeek
{
    NSString *string = [NSDate formateDate:self formate:@"yyyy-MM-dd"];
    for (NSString * s in [NSDate currentWeekDays]) {
        if ([s isEqualToString:string]) return YES;
    }
    return NO;
}

// 日期转换成字符串，格式如：2015-03-19
+ (NSString *)formateDate:(NSDate *)date
{
    return [self formateDate:date formate:@"yyyy-MM-dd"];
}

/// 日期转换成字符串，自定义格式
+ (NSString *)formateDate:(NSDate *)date formate:(NSString *)format
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = format;
    return [formatter stringFromDate:date];
}

// 字符串转成日期，格式如：2015-03-19
+ (NSDate *)dateFromeString:(NSString *)string
{
    return [self dateFromeString:string formate:@"yyyy-MM-dd"];
}

// 字符串转成日期，自定义格式
+ (NSDate *)dateFromeString:(NSString *)string formate:(NSString *)format
{
    if (string.length == 0) return nil;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = format;
    return [formatter dateFromString:string];
    
}

// 根据日期获取星期，返回数字（1~7）
+ (NSInteger)weekDayWithDate:(NSDate *)date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.locale = [NSLocale localeWithLocaleIdentifier:@"zh-Hans"];
    formatter.dateFormat = @"EEEE";
    // 得到日期那天星期几
    NSString *weekday = [formatter stringFromDate:date];
    // 将星期转换成对应数字
    return [self weekNumberWithWeekDayString:weekday];
}

// 将星期转换成数字（星期一：1， 星期二：2， 星期三：3 ...）
+ (NSInteger)weekNumberWithWeekDayString:(NSString *)weekDay
{
    if ([weekDay isEqualToString:@"星期一"]) return 1;
    if ([weekDay isEqualToString:@"星期二"]) return 2;
    if ([weekDay isEqualToString:@"星期三"]) return 3;
    if ([weekDay isEqualToString:@"星期四"]) return 4;
    if ([weekDay isEqualToString:@"星期五"]) return 5;
    if ([weekDay isEqualToString:@"星期六"]) return 6;
    if ([weekDay isEqualToString:@"星期日"]) return 7;
    return 0;
}

// 时间戵
+ (NSTimeInterval)dateWithTimestamp
{
    return [[NSDate date] timeIntervalSince1970];
}

- (NSString *)toString
{
    return [NSDate formateDate:self formate:@"yyyy-MM-dd HH:mm"];
}

- (NSString *)toStringFormat:(NSString *)formatString
{
    return [NSDate formateDate:self formate:formatString];
}
@end
