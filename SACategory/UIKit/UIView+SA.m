//
//  UIView+SA.m
//  SACategory
//
//  Created by 余西安 on 14/12/1.
//  Copyright (c) 2014年 Sian. All rights reserved.
//

#import "UIView+SA.h"
#import <objc/runtime.h>
#import "SAConst.h"

@implementation UIView (SA)

- (void)setBackground:(NSString *)imageName
{
    // 1、通过图片名加载图片对象
    UIImage *image = [UIImage imageNamed:imageName];
    // 2、开启图片上下文
    CGRect viewRect = self.bounds;
    UIGraphicsBeginImageContextWithOptions(viewRect.size, NO, 0.0);
    // 3、根据当前视图大小绘制一张相同大小图片
    [image drawInRect:viewRect];
    // 4、取出该图片
    UIImage *background = UIGraphicsGetImageFromCurrentImageContext();
    // 5、利用背景颜色设置方法将图片平铺上去
    self.backgroundColor = [UIColor colorWithPatternImage:background];
    // 6、关闭图片上下文
    UIGraphicsEndImageContext();
}

/// 遍历子视图
- (void)subviewWithBlock:(void(^)(UIView *view))aBlock
{
    // 如果有子视图则进入循环
    for (UIView *view in self.subviews) {
        // 如果子视图不属于UIView则退出本次循环
        if(![view isKindOfClass:[UIView class]]) continue;
        // Block不为空则执行Block
        if(aBlock) aBlock(view);
        // 通过递归遍历子视图的子视图
        [view subviewWithBlock:aBlock];
    }
}

- (UILabel *)badgeView
{
    UILabel *badgeView = objc_getAssociatedObject(self, @selector(badgeView));
    if (badgeView == nil){
        UILabel *badgeView = [[UILabel alloc] init];
        badgeView.layer.cornerRadius = 4.4f;
        badgeView.layer.masksToBounds = YES;
        badgeView.bounds = CGRectMake(0, 0, 8, 8);
        badgeView.textColor = [UIColor whiteColor];
        badgeView.font = [UIFont systemFontOfSize:10];
        badgeView.backgroundColor = [UIColor redColor];
        badgeView.textAlignment = NSTextAlignmentCenter;
        objc_setAssociatedObject(self, @selector(badgeView), badgeView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        return objc_getAssociatedObject(self, @selector(badgeView));
    }
    return badgeView;
}

- (void)showBadgeView:(BOOL)aBool
{
    [self addSubview:self.badgeView];
    self.badgeView.sa_x = self.sa_width - self.badgeView.sa_width;
    self.badgeView.hidden = !aBool;
}
#pragma mark - 添加顶部|底部线条
- (void)addTopLine
{
    UIView *line = UIView.new;
    line.backgroundColor = SAColor(0xCCCCCC);
    [self addSubview:line];
    [line mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self);
        make.height.equalTo(@0.5f);
    }];
}
- (void)addBottomLine
{
    UIView *line = UIView.new;
    line.backgroundColor = SAColor(0xCCCCCC);
    [self addSubview:line];
    [line mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self);
        make.height.equalTo(@0.5f);
    }];
}

- (CGFloat)sa_x
{
    return self.frame.origin.x;
}
- (void)setSa_x:(CGFloat)x
{
    CGRect rect = self.frame;
    rect.origin.x = x;
    self.frame = rect;
}
- (CGFloat)sa_y
{
    return self.frame.origin.y;
}
- (void)setSa_y:(CGFloat)y
{
    CGRect rect = self.frame;
    rect.origin.y = y;
    self.frame = rect;
}
- (CGFloat)sa_height
{
    return self.frame.size.height;
}
- (void)setSa_height:(CGFloat)height
{
    CGRect rect = self.frame;
    rect.size.height = height;
    self.frame = rect;
}
- (CGFloat)sa_width
{
    return self.frame.size.width;
}
- (void)setSa_width:(CGFloat)width
{
    CGRect rect = self.frame;
    rect.size.width = width;
    self.frame = rect;
}
- (CGPoint)sa_origin
{
    return self.frame.origin;
}
- (void)setSa_origin:(CGPoint)point
{
    CGRect rect = self.frame;
    rect.origin = point;
    self.frame = rect;
}

+ (UIView *)zeroView
{
    return [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0.1)];
}
- (void)showEmpty:(BOOL)aBool text:(NSString *)text
{
    if (text.length == 0) text = @"没有数据";
    self.showEmptyLabel.hidden = !aBool;
    self.showEmptyLabel.text = text;
}
- (UILabel *)showEmptyLabel
{
    if (objc_getAssociatedObject(self, @selector(showEmptyLabel)) == nil){
        UILabel *label = UILabel.new;
        [self addSubview:label];
        label.numberOfLines = 0;
        label.textColor = SAColor(0x999999);
        label.font = [UIFont systemFontOfSize:15];
        label.textAlignment = NSTextAlignmentCenter;
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
            make.width.lessThanOrEqualTo(self).valueOffset(@(-10)).priorityLow();
        }];
        objc_setAssociatedObject(self, @selector(showEmptyLabel), label, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return objc_getAssociatedObject(self, @selector(showEmptyLabel));
}
- (void)setShowEmptyLabel:(UILabel *)showEmptyLabel
{
    objc_setAssociatedObject(self, @selector(showEmptyLabel), showEmptyLabel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
/**
 *  返回当前视图的控制器
 */
- (UIViewController *)viewController
{
    for (UIView *next = self; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:UINavigationController.class]){
            return [(UINavigationController *)nextResponder topViewController];
        }else if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

@end
