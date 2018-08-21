//
//  NSMutableDictionary+SA.h
//  SACategory
//
//  Created by yusian on 15-1-13.
//  Copyright (c) 2015年 Sian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary (SA)

- (void)sa_setObject:(id)anObject forKey:(id<NSCopying>)aKey;

@end
