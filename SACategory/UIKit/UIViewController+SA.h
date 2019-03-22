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
@end
