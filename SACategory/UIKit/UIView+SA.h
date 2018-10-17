//
//  UIView+SA.h
//  SACategory
//
//  Created by 余西安 on 14/12/1.
//  Copyright (c) 2014年 Sian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (SA)
// 设置背景图片
- (void)setBackground:(NSString *)imageName;
- (void)subviewWithBlock:(void(^)(UIView *view))aBlock;

- (UILabel *)badgeView;
- (void)showBadgeView:(BOOL)aBool;
- (void)addTopLine;
- (void)addBottomLine;

@property (nonatomic, assign)   CGFloat sa_x;
@property (nonatomic, assign)   CGFloat sa_y;
@property (nonatomic, assign)   CGPoint sa_origin;
@property (nonatomic, assign)   CGFloat sa_width;
@property (nonatomic, assign)   CGFloat sa_height;

+ (UIView *)zeroView;

@property (nonatomic, strong)   UILabel     *showEmptyLabel;
- (void)showEmpty:(BOOL)aBool text:(NSString *)text;
@end
