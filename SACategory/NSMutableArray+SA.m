//
//  NSMutableArray+SA.m
//  OpenMIG
//
//  Created by duanzhijun on 2017/1/11.
//  Copyright © 2017年 Sian. All rights reserved.
//

#import "NSMutableArray+SA.h"

@implementation NSMutableArray (SA)

- (void)sa_addObject:(id)obj
{
    if (obj == nil) return;
    [self addObject:obj];
}

@end
