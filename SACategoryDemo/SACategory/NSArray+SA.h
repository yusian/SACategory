//
//  NSArray+SA.h
//  OpenMIG_RE
//
//  Created by 余西安 on 15/5/13.
//  Copyright (c) 2015年 Sian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (SA)

/**
 objectAtIndex:的优化方法，防止数组越界

 @param index 对象序号
 @return 返回取出的对象，如果越界返回为nil
 */
- (id)sa_objectAtIndex:(NSInteger)index;

@end
