//
//  UITabBar+SA.m
//  OpenMIG
//
//  Created by 余西安 on 16/3/28.
//  Copyright © 2016年 Sian. All rights reserved.
//

#import "UITabBar+SA.h"
#import "UIView+SA.h"

@implementation UITabBar (SA)

- (UIView *)barButtonWithIndex:(NSInteger)index
{
    __block UIView *button = nil;
    __block NSInteger i = 0;
    [self subviewWithBlock:^(UIView *view) {
        Class barButton = NSClassFromString(@"UITabBarButton");
        if ([view isKindOfClass:barButton]){
            if (i == index) button = view;
            i++;
        }
    }];
    return button;
}

- (void)setBadge:(BOOL)aBool index:(NSInteger)index
{
    UIView *barButton = [self barButtonWithIndex:index];
    UIView *badgeView = barButton.badgeView;
    CGFloat width = barButton.bounds.size.width;
    badgeView.sa_origin = CGPointMake(width * 0.6, 5);
    [badgeView removeFromSuperview];
    if (aBool) [barButton addSubview:badgeView];
}

@end
