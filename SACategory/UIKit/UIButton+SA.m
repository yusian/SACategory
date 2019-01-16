//
//  UIButton+SA.m
//  SACategory
//
//  Created by 余西安 on 14/12/1.
//  Copyright (c) 2014年 Sian. All rights reserved.
//

#import "UIButton+SA.h"
#import "UIImage+SA.h"
#import "UIImageView+SAUpload.h"
#import "UIButton+WebCache.h"
#import <objc/runtime.h>

@implementation UIButton (SA)

- (void)setBGImage:(NSString *)imageName
{
    [self setBackgroundImage:[UIImage resizedImageName:imageName] forState:UIControlStateNormal];
}

- (void)highLightBackground:(NSString *)imageName
{
    [self setBackgroundImage:[UIImage resizedImageName:imageName] forState:UIControlStateHighlighted];
}

- (void)normalBackground:(NSString *)imageName
{
    [self setBackgroundImage:[UIImage resizedImageName:imageName] forState:UIControlStateNormal];
}

- (void)addTarget:(id)target action:(SEL)action
{
    [self addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
}
#pragma mark - actionWithBlock
- (void)actionWithBlock:(SAButtonActionBlock)block forControlEvents:(UIControlEvents)controlEvents
{
    self.sa_actionBlock = block;
    [self addTarget:self action:@selector(sa_categoryButtonEvent:) forControlEvents:controlEvents];
}
- (void)setSa_actionBlock:(SAButtonActionBlock)sa_actionBlock
{
    objc_setAssociatedObject(self, @selector(sa_actionBlock), sa_actionBlock, OBJC_ASSOCIATION_COPY);
}
- (SAButtonActionBlock)sa_actionBlock
{
    return objc_getAssociatedObject(self, @selector(sa_actionBlock));
}
- (void)sa_categoryButtonEvent:(UIButton *)button
{
    if (self.sa_actionBlock) self.sa_actionBlock(button);
}

- (void)setImageUrl:(NSString *)urlStr placeholder:(NSString *)placeholder
{
    UIImage *placeholderImage = (placeholder.length > 0) ? [UIImage imageNamed:placeholder] : UIImage.new;
    if (0 == urlStr.length){
        [self setImage:placeholderImage forState:UIControlStateNormal];
    }else{
        self.imageView.uploadState = SAImageUploadStateUploading;
        [self sd_setImageWithURL:[NSURL URLWithString:urlStr] forState:UIControlStateNormal placeholderImage:placeholderImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            self.imageView.uploadState = SAImageUploadStateNormal;
            if (error) [self setImage:[UIImage imageNamed:@"sacategory.bundle/image_loading_failure.png"] forState:UIControlStateNormal];
        }];
    }
}

+ (id)buttonWithImage:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    CGSize size = image.size;
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.bounds = CGRectMake(0, 0, size.width, size.height);
    [btn setBackgroundImage:image forState:UIControlStateNormal];
    return btn;
}
@end
