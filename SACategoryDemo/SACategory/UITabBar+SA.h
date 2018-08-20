//
//  UITabBar+SA.h
//  OpenMIG
//
//  Created by 余西安 on 16/3/28.
//  Copyright © 2016年 Sian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBar (SA)

- (UIView *)barButtonWithIndex:(NSInteger)index;

- (void)setBadge:(BOOL)aBool index:(NSInteger)index;

@end
