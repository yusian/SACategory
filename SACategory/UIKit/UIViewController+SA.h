//
//  UIViewController+SA.h
//  SACategory
//
//  Created by 余西安 on 14/12/15.
//  Copyright (c) 2014年 Sian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (SA)

@property (nonatomic, weak) UIViewController        *superCtrl;

@property (nonatomic, strong) NSURLSessionDataTask  *task;

@property (nonatomic, strong) NSMutableArray        *taskArray;

@property (nonatomic, assign, getter=isNavBarHidden)   BOOL     navBarHidden;

- (void)removeFromNavigation;

- (void)addTask:(NSURLSessionDataTask *)task;

- (void)debounceDelay:(NSTimeInterval)delay block:(dispatch_block_t)block;
/**
 获取某个控制器的实际交互控制器
 
 @param rootViewController 基础控制器
 @return 活动控制器
 */
+ (UIViewController *)topViewControllerWithRootViewController:(UIViewController*)rootViewController;

/**
 获取当前顶部控制器
 
 @return 当前交互控制器
 */
+ (UIViewController *)currentViewController;

/**
 退出当前dismiss控制器，并递归退出presented控制器
 */
- (void)dismissPresentedViewController;

@end
