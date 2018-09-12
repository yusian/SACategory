//
//  NSDictionary+SA.m
//  SACategory
//
//  Created by yusian on 15-1-13.
//  Copyright (c) 2015年 Sian. All rights reserved.
//

#import "NSDictionary+SA.h"
#import "NSMutableDictionary+SA.h"
#import "SAConst.h"

@implementation NSDictionary (SA)

- (id)sa_objectForKey:(id)aKey
{
    if ([self isKindOfClass:self.class] == NO) return self;
    id obj = [self objectForKey:aKey];
    if ([obj isKindOfClass:[NSNull class]]) obj = nil;
    if ([obj isKindOfClass:[NSNumber class]]) obj = [obj stringValue];
//    SALog(@"********%@:%@--%@\n", aKey, obj, [obj class]);
    return obj;
}

+ (instancetype)dictionaryWithCoor:(CLLocationCoordinate2D)coor
{
    NSString *latitude = [NSString stringWithFormat:@"%f", coor.latitude];
    NSString *longitude = [NSString stringWithFormat:@"%f", coor.longitude];
    return @{@"Latitude" : latitude, @"Longitude" : longitude};
}

+ (instancetype)dictionaryWithJSON:(NSString *)string
{
    if (string == nil || string.length == 0) return nil;
    
    NSError *err;
    NSData *jsonData = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    if(err) {
        SALog(@"json解析失败：%@",err);
        return nil;
    }
    return [[self alloc] initWithDictionary:dict];
}

+ (instancetype)dictionaryWithURLParas:(NSString *)URLParas
{
    NSArray *keyValues = [URLParas componentsSeparatedByString:@"&"];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    for (NSString *keyValue in keyValues) {
        NSArray *keyValuePair = [keyValue componentsSeparatedByString:@"="];
        NSString *key = [keyValuePair firstObject];
        NSString *value = [keyValuePair lastObject];
        [dict sa_setObject:value forKey:key];
    }
    return dict;
}

- (CLLocationCoordinate2D)toCoor
{
    CLLocationDegrees latitude = [[self sa_objectForKey:@"latitude"] doubleValue];
    CLLocationDegrees longitude = [[self sa_objectForKey:@"longitude"] doubleValue];
    return CLLocationCoordinate2DMake(latitude, longitude);
}
@end
