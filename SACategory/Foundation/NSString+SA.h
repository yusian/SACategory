//
//  NSString+SA.h
//  SACategory
//
//  Created by 余西安 on 14/12/10.
//  Copyright (c) 2014年 Sian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>

@interface NSString (SA)

- (BOOL)hasContain:(NSString *)string;

- (NSString *)deleteLastChar;

- (NSString *)encodingString;

+ (NSString *)dateString;

+ (NSString *)dateTimeString;

- (NSString *)appendStr:(NSString *)string;

+ (instancetype)stringWithDictionay:(NSDictionary *)dict;

+ (NSString *)pingyinFromChineseString:(NSString *)string;

- (NSString *)encodingBase64;

+ (NSString *)stringWithBase64String:(NSString *)string;

// 字典转JSON
+ (NSString *)JSONStringWithObject:(NSDictionary <NSString *, NSString *>*)object;
+ (NSString *)originalJSONStringWithObject:(NSDictionary <NSString *, NSString *>*)object;

+ (NSString *)keyValueWithDict:(NSDictionary *)dict;

- (NSString *)replace:(NSString *)string1 with:(NSString *)string2;

+ (NSString *)stringWithTimeInterval:(NSTimeInterval)time;

+ (NSString *)format:(NSString *)string, ...;

- (NSString *)zipedToLength:(NSInteger)length;

- (NSString *)clipToLength:(NSInteger)length;

- (CLLocationCoordinate2D)toCoor;

- (NSString *)MD5;

+ (NSString*)timerFireMethod:(NSString *) timeString;
// 字体高度
+ (CGFloat)heightWithFont:(UIFont *)font;
// 图片fileID

- (NSString *)toFontCode;

@end
