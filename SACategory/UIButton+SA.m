//
//  UIButton+SA.m
//  OpenMIG
//
//  Created by 余西安 on 14/12/1.
//  Copyright (c) 2014年 Sian. All rights reserved.
//

#import "UIButton+SA.h"
#import "UIImage+SA.h"
#import "UIImageView+SAUpload.h"
#import "UIButton+WebCache.h"

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

- (void)setImageUrl:(NSString *)urlStr placeholder:(NSString *)placeholder
{
    if (0 == urlStr.length){
        [self setImage:[UIImage imageNamed:placeholder] forState:UIControlStateNormal];return;
    }
    self.imageView.uploadState = SAImageUploadStateUploading;
    [self sd_setImageWithURL:[NSURL URLWithString:urlStr] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:placeholder] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.imageView.uploadState = SAImageUploadStateNormal;
        if (error) [self setImage:[UIImage imageNamed:@"image_loading_failure.png"] forState:UIControlStateNormal];
    }];
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
