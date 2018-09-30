//
//  UIBarButtonItem+SA.m
//  SACategory
//
//  Created by 余西安 on 14/11/28.
//  Copyright (c) 2014年 Sian. All rights reserved.
//

#import "UIBarButtonItem+SA.h"

@implementation UIBarButtonItem (SA)

+ (instancetype)backWithTarget:(id)target action:(SEL)action
{
    return [self buttonWithTitle:@"返回" target:target action:action];
}

+ (instancetype)buttonWithTitle:(NSString *)title target:(id)target action:(SEL)action
{
    return [[self alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:target action:action];
}
+ (instancetype)buttonWithImage:(NSString *)imageName target:(id)target action:(SEL)action
{
    return [[self alloc] initWithImage:[UIImage imageNamed:imageName] style:UIBarButtonItemStylePlain target:target action:action];
}

+ (instancetype)backButtonWithTarget:(id)target action:(SEL)action
{
    UIImage *backImage = [UIImage imageNamed:@"sacategory.bundle/icon_navigation_back.png"];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"返回" forState:UIControlStateNormal];
    [button setImage:backImage forState:UIControlStateNormal];
    [button setBounds:CGRectMake(0, 0, 46, 44)];
    [button.titleLabel setAdjustsFontSizeToFitWidth:YES];
    [button.titleLabel setFont:[UIFont systemFontOfSize:17]];
    [button setTitleEdgeInsets:UIEdgeInsetsMake(0, -8, 0, 0)];
    [button setImageEdgeInsets:UIEdgeInsetsMake(0, -8, 0, 0)];
    [button setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

+ (instancetype)backIconWithTarget:(id)target action:(SEL)action
{
    UIImage *backImage = [UIImage imageNamed:@"sacategory.bundle/icon_navigation_back.png"];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"返回" forState:UIControlStateNormal];
    button.tintColor = [UIColor whiteColor];
    [button setImage:backImage forState:UIControlStateNormal];
    [button setBounds:CGRectMake(0, 0, 42, 28)];
    [button setTitleEdgeInsets:UIEdgeInsetsMake(0, -2, 0, 0)];
    [button setImageEdgeInsets:UIEdgeInsetsMake(0, -9, 0, 0)];
    [button setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

- (void)setFont:(UIFont *)font
{
    if (font == nil) return;
    [self setTitleTextAttributes:@{NSFontAttributeName:font} forState:UIControlStateNormal];
}
@end
