//
//  UIButton+SA.h
//  OpenMIG
//
//  Created by 余西安 on 14/12/1.
//  Copyright (c) 2014年 Sian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (SA)

// 设置常规状态下图片
- (void)setBGImage:(NSString *)imageName;

// 常态背景图片
- (void)normalBackground:(NSString *)imageName;

// 高亮背景图片
- (void)highLightBackground:(NSString *)imageName;

// 按钮事件
- (void)addTarget:(id)target action:(SEL)action;

- (void)setImageUrl:(NSString *)urlStr placeholder:(NSString *)placeholder;

+ (id)buttonWithImage:(NSString *)imageName;

@end
