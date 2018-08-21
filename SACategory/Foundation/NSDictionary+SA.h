//
//  NSDictionary+SA.h
//  SACategory
//
//  Created by yusian on 15-1-13.
//  Copyright (c) 2015年 Sian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface NSDictionary (SA)

- (id)sa_objectForKey:(id)aKey;

+ (instancetype)dictionaryWithCoor:(CLLocationCoordinate2D)coor;

+ (instancetype)dictionaryWithJSON:(NSString *)string;

+ (instancetype)dictionaryWithURLParas:(NSString *)URLParas;

- (CLLocationCoordinate2D)toCoor;
@end
