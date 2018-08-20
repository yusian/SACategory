//
//  NSArray+SA.m
//  OpenMIG_RE
//
//  Created by 余西安 on 15/5/13.
//  Copyright (c) 2015年 Sian. All rights reserved.
//

#import "NSArray+SA.h"

@implementation NSArray (SA)

- (id)sa_objectAtIndex:(NSInteger)index
{
    if (index >= self.count || index < 0) return nil;
    return [self objectAtIndex:index];
}

@end
