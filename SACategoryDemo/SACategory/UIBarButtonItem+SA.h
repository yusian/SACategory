//
//  UIBarButtonItem+SA.h
//  OpenMIG
//
//  Created by 余西安 on 14/11/28.
//  Copyright (c) 2014年 Sian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (SA)

// 创建返回按钮
+ (instancetype)backWithTarget:(id)target action:(SEL)action;

// 自定义标题按钮
+ (instancetype)buttonWithTitle:(NSString *)title target:(id)target action:(SEL)action;

// 自定义图标按钮
+ (instancetype)buttonWithImage:(NSString *)imageName target:(id)target action:(SEL)action;

// 自定义返回按钮
+ (instancetype)backButtonWithTarget:(id)target action:(SEL)action;

// 白色返回按钮
+ (instancetype)backIconWithTarget:(id)target action:(SEL)action;

- (void)setFont:(UIFont *)font;

@end
