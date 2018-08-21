//
//  UIImageView+SA.m
//  OpenMIG
//
//  Created by yusian on 15-1-30.
//  Copyright (c) 2015年 Sian. All rights reserved.
//

#import "UIImageView+SA.h"
#import "UIImageView+SAUpload.h"
#import "UIImageView+WebCache.h"
#import "UIView+WebCache.h"

@implementation UIImageView (SA)

- (void)setImageUrl:(NSString *)urlStr placeholder:(NSString *)placeholder
{
    UIImage *placeImage = placeholder.length ? [UIImage imageNamed:placeholder] : UIImage.new;
    if (urlStr.length == 0){
        [self sd_cancelCurrentImageLoad];
        self.image = placeImage;
        self.uploadState = SAImageUploadStateNormal;
    }else{
        self.uploadState = SAImageUploadStateUploading;
        [self sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:placeImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            self.uploadState = SAImageUploadStateNormal;
            if (error) self.image = [UIImage imageNamed:@"image_loading_failure.png"];
        }];
    }
}
@end
