//
//  UIImageView+SAUpload.h
//  OpenMIG
//
//  Created by 余西安 on 2017/1/6.
//  Copyright © 2017年 Sian. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, SAImageUploadState){
    SAImageUploadStateNormal,
    SAImageUploadStateUploading,
    SAImageUploadStateUploadFaile,
    SAImageUploadStateUploadSuccess
};

@interface UIImageView (SAUpload)

@property (nonatomic, assign) SAImageUploadState uploadState;

@property (nonatomic, strong, readonly) UIView *stateView;

@property (nonatomic, strong, readonly) UIActivityIndicatorView *loading;

@property (nonatomic, strong, readonly) UIImageView *stateIcon;

@end
