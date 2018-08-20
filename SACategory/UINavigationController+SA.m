//
//  UINavigationController+SA.m
//  OpenMIG
//
//  Created by 余西安 on 2017/5/3.
//  Copyright © 2017年 zhijunduan. All rights reserved.
//

#import "UINavigationController+SA.h"

@implementation UINavigationController (SA)

- (void)removeKindOfCtrl:(NSString *)classString
{
    NSMutableArray *array = [NSMutableArray arrayWithArray:self.viewControllers];
    [self.viewControllers enumerateObjectsUsingBlock:^(UIViewController *ctrl, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([ctrl isKindOfClass:NSClassFromString(classString)]) [array removeObject:ctrl];
    }];
    self.viewControllers = array;
}

- (void)removeCtrls:(NSArray<__kindof NSString *> *)ctrlArray
{
    NSMutableArray *array = [NSMutableArray arrayWithArray:self.viewControllers];
    [self.viewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        for (NSString *classString in ctrlArray) {
           if ([obj isKindOfClass:NSClassFromString(classString)]) [array removeObject:obj];
        }
    }];
    self.viewControllers = array;
}
@end
