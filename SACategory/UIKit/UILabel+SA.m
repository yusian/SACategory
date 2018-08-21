//
//  UILabel+SA.m
//  SACategory
//
//  Created by 余西安 on 2016/12/12.
//  Copyright © 2016年 Sian. All rights reserved.
//

#import "UILabel+SA.h"
#import "NSString+SA.h"
#import <objc/runtime.h>

@implementation UILabel (SA)

+ (void)initialize
{
    // 获取到UILabel中setText对应的method
    Method setTextMethod = class_getInstanceMethod([UILabel class], @selector(setText:));
    Method setStringMethod = class_getInstanceMethod([self class], @selector(setString:));
    
    IMP setTextIMP = method_getImplementation(setTextMethod);
    IMP setStringIMP = method_getImplementation(setStringMethod);
    
    const char *MethodType = method_getTypeEncoding(setTextMethod);
    // 将方法名 setTextCategory: 绑定到 setText的实现上
    SEL selector = NSSelectorFromString(@"setTextCategory:");
    class_addMethod([UILabel class], selector, setTextIMP, MethodType);
    // 然后用我们自己的函数的实现，替换目标函数对应的实现
    class_replaceMethod([UILabel class], @selector(setText:), setStringIMP, MethodType);
}

// setText:的替代方法
- (void)setString:(NSString *)string
{
    if (string == nil) string = @"";
    
    SEL selector = NSSelectorFromString(@"setTextCategory:");
    IMP imp = [self methodForSelector:selector];
    void (*func)(id, SEL, NSString *) = (void *)imp;
    func(self, selector, string);
}

- (CGSize)textSize
{
    self.adjustsFontSizeToFitWidth = YES;
    return [self.text sizeWithAttributes:@{NSFontAttributeName:self.font}];
}
@end
