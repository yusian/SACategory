//
//  NSObject+SA.h
//  SACategory
//
//  Created by yusian on 15-3-16.
//  Copyright (c) 2015年 Sian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (SA)

@property (nonatomic, strong)   NSObject    *object;

- (void)performMethod:(NSString *)methodName withObject:(id)object;

@end
