//
//  NSObject+webView.m
//  SACategory
//
//  Created by 余西安 on 2018/8/20.
//  Copyright © 2018年 yusian. All rights reserved.
//

#import "NSObject+webView.h"

@implementation NSObject (webView)

- (void)webView:(id)webView didCreateJavaScriptContext:(id)ctx forFrame:(id)frame
{
    [NSNotificationCenter.defaultCenter postNotificationName:@"SAWebViewDidCreateJavaScriptContext" object:ctx];
}

@end
