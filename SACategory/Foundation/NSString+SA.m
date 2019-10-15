//
//  NSString+SA.m
//  SACategory
//
//  Created by 余西安 on 14/12/10.
//  Copyright (c) 2014年 Sian. All rights reserved.
//

#import "NSString+SA.h"
#import "sys/utsname.h"
#import <CommonCrypto/CommonDigest.h>
#import "NSDate+SA.h"
#import "SAConst.h"

@implementation NSString (SA)

- (BOOL)hasContain:(NSString *)string
{
    NSRange range = [self rangeOfString:string];
    return range.length;
}

- (NSString *)encodingString
{
    return [self stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

+ (NSString *)dateString
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMdd";
    return [formatter stringFromDate:[NSDate date]];
}

+ (NSString *)dateTimeString
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMddHHmmss";
    return [formatter stringFromDate:[NSDate date]];
}

- (NSString *)appendStr:(NSString *)string
{
    if (string == nil) return self;
    return [self stringByAppendingString:string];
}

- (NSString *)deleteLastChar
{
    if (self.length == 0) return @"";
    return [self substringToIndex:(self.length - 1)];
}

+ (instancetype)stringWithDictionay:(NSDictionary *)dict
{
    if (nil == dict) return @"";
    NSError *error = nil;
    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    if (error) SALog(@"JSONData转换失败：%@", error);
    NSString *jsonStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    jsonStr = [jsonStr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    jsonStr = [jsonStr stringByReplacingOccurrencesOfString:@"\\" withString:@""];
    return jsonStr;
}

+ (NSString *)pingyinFromChineseString:(NSString *)string
{
    NSMutableString *simpin = [NSMutableString string];
    for (int i = 0; i < string.length; i++){
        NSMutableString *word = [[string substringWithRange:NSMakeRange(i, 1)] mutableCopy];
        CFStringTransform((__bridge CFMutableStringRef)word, NULL, kCFStringTransformMandarinLatin, NO);
        CFStringTransform((__bridge CFMutableStringRef)word, NULL, kCFStringTransformStripDiacritics, NO);
        NSString *letter = (word.length >= 1) ? [word substringToIndex:1] : @"";
        [simpin appendString:letter];
    }
    return simpin;
}

- (NSString *)encodingBase64
{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    return [data base64EncodedStringWithOptions:0];
}

+ (NSString *)stringWithBase64String:(NSString *)string
{
    while (string.length % 4 > 0) {
        string = [string appendStr:@"="];
    }
    NSData *data = [[NSData alloc] initWithBase64EncodedString:string options:0];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}
+ (NSString *)keyValueWithDict:(NSDictionary *)dict
{
    __block NSString *string = @"";
    [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        string = [string stringByAppendingFormat:@"%@=%@&", key, obj];
    }];
    return [string deleteLastChar];
}

+ (NSString *)JSONStringWithObject:(NSDictionary <NSString *, NSString *>*)object
{
    NSString *string = [self originalJSONStringWithObject:object];
    string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"\\" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"<br/>" withString:@""];
    return string;
}

+ (NSString *)originalJSONStringWithObject:(NSDictionary <NSString *, NSString *>*)object
{
    if (object == nil) return nil;
    NSData *data = [NSJSONSerialization dataWithJSONObject:object options:NSJSONWritingPrettyPrinted error:NULL];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}
/// 字符串替换
- (NSString *)replace:(NSString *)string1 with:(NSString *)string2
{
    if (string2 == nil) string2 = @"";
    if ([self rangeOfString:string1].length == 0) return self;
    return [self stringByReplacingOccurrencesOfString:string1 withString:string2];
}

/// 时间换成字符串(传入时间戵)
+ (NSString *)stringWithTimeInterval:(NSTimeInterval)time
{
    if (time > 9999999999) time = time / 10000000000; // 取10位时间戳到秒
    NSTimeInterval t = [NSDate dateWithTimestamp] - time;
    if (t <= -60*60*24*365) return [NSString stringWithFormat:@"%.0f年内",-t/(60*60*24*365)];
    if (t <= -60*60*24*30 && t > -60*60*24*365) return [NSString stringWithFormat:@"%.0f个月内",-t/(60*60*24*30)];
    if (t <= -60*60*24 && t > -60*60*24*30) return [NSString stringWithFormat:@"%.0f天内",-t/(60*60*24)];
    if (t <= -60*60 && t > -60*60*24) return [NSString stringWithFormat:@"%.0f小时内",-t/(60*60)];
    if (t <= -60 && t > -60*60) return [NSString stringWithFormat:@"%.0f分钟内",-t/60];
    if (t < 60 && t > -60) return @"刚刚";
    if (t >= 60 && t < 60*60) return [NSString stringWithFormat:@"%.0f分钟前",t/60];
    if (t >= 60*60 && t < 60*60*24) return [NSString stringWithFormat:@"%.0f小时前",t/(60*60)];
    if (t >= 60*60*24 && t < 60*60*24*30) return [NSString stringWithFormat:@"%.0f天前",t/(60*60*24)];
    if (t >= 60*60*24*30 && t < 60*60*24*365) return [NSString stringWithFormat:@"%.0f个月前",t/(60*60*24*30)];
    if (t >= 60*60*24*365) return [NSString stringWithFormat:@"%.0f年前",t/(60*60*24*365)];
    return nil;
}

+ (NSString *)format:(NSString *)string, ...
{
    if (string.length == 0) return @"";
    va_list args;
    va_start(args, string);
    NSString *s = [[NSString alloc] initWithFormat:string arguments:args];
    va_end(args);
    if (s == nil) s = @"";
    return [s replace:@"(null)" with:@""];
}

- (NSString *)zipedToLength:(NSInteger)length
{
    if (length == 0 || self.length == 0) return nil;
    if (self.length < length) return self;
    if (length == 1) return [self substringToIndex:1];
    NSString *header = [self substringToIndex:length - 1];
    NSString *footer = [self substringFromIndex:self.length - 1];
    return  [header stringByAppendingString:footer];
}

- (NSString *)clipToLength:(NSInteger)length
{
    if (length == 0 || self.length == 0) return nil;
    if (self.length <= (length + 1)) return self;
    NSString *subStr = [self substringToIndex:length];
    return [subStr stringByAppendingString:@"..."];
}

- (CLLocationCoordinate2D)toCoor
{
    CLLocationCoordinate2D coor = CLLocationCoordinate2DMake(0, 0);
    if (self.length == 0) return coor;
    CGPoint point = CGPointFromString(self);
    coor.latitude = point.x;
    coor.longitude = point.y;
    return coor;
}

- (NSString *)MD5
{
    const char *cStr = [self UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), digest );
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    return output;
}


+ (NSString*)timerFireMethod:(NSString *) timeString
{
    NSTimeInterval time = timeString.longLongValue;
    if (time > 1000000000) time = time / 1000;
    NSTimeInterval now = [[NSDate date] timeIntervalSince1970];
    long long second = (time - now);
    second = time;  // 参数有变
    if (second < 0) second = 0;
    // 时间差包含多少天(比如1天零300秒)
    long long diffDay = second / (60.0 * 60 * 24);
    // 去除整天后还余多少秒
    long long secInDay = second % (60 * 60 * 24);
    // 一天内的秒换成小时
    long long diffHour = secInDay / (60 * 60);
    // 去除小时剩下的秒换成分钟
    long long diffMin = secInDay % (60 * 60) / 60;
    NSString *countdown = [NSString stringWithFormat:@"%lld,%lld,%lld", diffDay,diffHour, diffMin];
    return countdown;
}

+ (CGFloat)heightWithFont:(UIFont *)font
{
    return [@"" sizeWithAttributes:@{NSFontAttributeName:font}].height;
}
- (NSString *)imageFileID
{
    NSString *fileId =  [[self componentsSeparatedByString:@"fileId="] lastObject];
    fileId = [[fileId componentsSeparatedByString:@"_"] firstObject];
    return fileId;
}

- (NSString *)toFontCode
{
    NSString *code = [self replace:@"&#x" with:@"\\U"];
    code = [NSString stringWithFormat:@"\"%@\"", code];
    NSData *data = [code dataUsingEncoding:NSUTF8StringEncoding];
    return [NSPropertyListSerialization propertyListWithData:data options:NSPropertyListImmutable format:NULL error:NULL];
}

@end
