//
//  UINavigationController+SA.h
//  OpenMIG
//
//  Created by 余西安 on 2017/5/3.
//  Copyright © 2017年 zhijunduan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (SA)

- (void)removeKindOfCtrl:(NSString *)classString;

- (void)removeCtrls:(NSArray<__kindof NSString *> *)ctrlArray;

@end
