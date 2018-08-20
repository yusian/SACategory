//
//  NSMutableDictionary+SA.m
//  OpenMIG
//
//  Created by yusian on 15-1-13.
//  Copyright (c) 2015年 Sian. All rights reserved.
//

#import "NSMutableDictionary+SA.h"

@implementation NSMutableDictionary (SA)

- (void)sa_setObject:(id)anObject forKey:(id<NSCopying>)aKey
{
    if (anObject == nil) anObject = @"";
    [self setObject:anObject forKey:aKey];
}
@end
