//
//  UIWebView+SA.m
//  SACategory
//
//  Created by 余西安 on 2017/9/25.
//  Copyright © 2017年 Sian. All rights reserved.
//

#import "UIWebView+SA.h"

@implementation UIWebView (SA)

- (void)layoutSubviews
{
    [super layoutSubviews];
    if (@available(iOS 11.0, *)) {
        self.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
    }
}

@end
