//
//  NSDate+SA.h
//  SACategory
//
//  Created by yusian on 15-3-19.
//  Copyright (c) 2015年 Sian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (SA)

// 根据日期获取星期，返回数字（1~7）
+ (NSInteger)weekDayWithDate:(NSDate *)date;

// 当前日期是否处于本周
- (BOOL)hasBelongThisWeek;

// 日期转换成字符串，格式如：2015-03-19
+ (NSString *)formateDate:(NSDate *)date;

// 日期转换成字符串，自定义格式
+ (NSString *)formateDate:(NSDate *)date formate:(NSString *)format;

// 字符串转成日期，格式如：2015-03-19
+ (NSDate *)dateFromeString:(NSString *)string;

// 字符串转成日期，自定义格式
+ (NSDate *)dateFromeString:(NSString *)string formate:(NSString *)format;

// 本周日期字符串数组
+ (NSArray *)currentWeekDays;

// 时间戵
+ (NSTimeInterval)dateWithTimestamp;

// 转成yyyy-MM-dd HH:mm格式
- (NSString *)toString;

// 自定义转换格式
- (NSString *)toStringFormat:(NSString *)formatString;
@end
