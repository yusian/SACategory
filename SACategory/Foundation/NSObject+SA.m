//
//  NSObject+SA.m
//  SACategory
//
//  Created by yusian on 15-3-16.
//  Copyright (c) 2015年 Sian. All rights reserved.
//

#import "NSObject+SA.h"
#import <objc/runtime.h>
#import "SAConst.h"

@implementation NSObject (SA)
- (void)setObject:(NSObject *)object
{
    objc_setAssociatedObject(self, @selector(object), object, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSObject *)object
{
    return objc_getAssociatedObject(self, @selector(object));
}

/// 动态方法调用
- (void)performMethod:(NSString *)methodName withObject:(id)object
{
    if (object != nil) methodName = [methodName stringByAppendingString:@":"];
    SEL methodSEL = NSSelectorFromString(methodName);
    if ([self respondsToSelector:methodSEL]){
        IMP imp = [self methodForSelector:methodSEL];
        void(*func)(id, SEL, NSString *) = (void *)imp;
        func(self, methodSEL, object);
    }else{
        SALog(@"%@没有实现方法%@", self, methodName);
    }
}

@end
