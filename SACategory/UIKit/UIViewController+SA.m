//
//  UIViewController+SA.m
//  SACategory
//
//  Created by 余西安 on 14/12/15.
//  Copyright (c) 2014年 Sian. All rights reserved.
//

#import "UIViewController+SA.h"
#import <objc/runtime.h>
#import "NSObject+SA.h"

@implementation UIViewController (SA)
#pragma mark - 属性
/****************属性****************/
// 父控制器
- (UIViewController *)superCtrl
{
    return objc_getAssociatedObject(self, @selector(superCtrl));
}
- (void)setSuperCtrl:(UIViewController *)superCtrl
{
    objc_setAssociatedObject(self, @selector(superCtrl), superCtrl, OBJC_ASSOCIATION_ASSIGN);
}
// 网络请求队列
- (NSMutableArray *)taskArray
{
    NSMutableArray *array = objc_getAssociatedObject(self, @selector(taskArray));
    if (array != nil) return array;
    [self setTaskArray:[NSMutableArray array]];
    return objc_getAssociatedObject(self, @selector(taskArray));
}
- (void)setTaskArray:(NSMutableArray *)taskArray
{
    objc_setAssociatedObject(self, @selector(taskArray), taskArray, OBJC_ASSOCIATION_RETAIN);
}
// 当前网络请求
- (NSURLSessionDataTask *)task
{
    return objc_getAssociatedObject(self, @selector(task));
}
- (void)setTask:(NSURLSessionDataTask *)task
{
    objc_setAssociatedObject(self, @selector(task), task, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - 方法
/****************方法****************/
/// 将当前控制器从导航中移除
- (void)removeFromNavigation
{
    NSMutableArray *array =  [self.navigationController.viewControllers mutableCopy];
    if ([array containsObject:self]) [array removeObject:self];
    self.navigationController.viewControllers = array;
}
/// 添加当前网络请求到请求队列
- (void)addTask:(NSURLSessionDataTask *)task
{
    NSMutableArray *taskArray = self.taskArray;
    if (task == nil || [taskArray containsObject:task]) return;
    for (NSURLSessionDataTask *t in taskArray) {
        if (t.state == NSURLSessionTaskStateCanceling){
            [taskArray removeObject:t];
        }
    }
    [taskArray addObject:task];
}
/// 函数去抖
- (void)debounceDelay:(NSTimeInterval)delay block:(dispatch_block_t)block
{
    if (self.sa_block) dispatch_block_cancel(self.sa_block);
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC*delay);
    dispatch_after(time, dispatch_get_main_queue(), block);
    self.sa_block = block;
}
@end
