//
//  UIImageView+SAUpload.m
//  OpenMIG
//
//  Created by 余西安 on 2017/1/6.
//  Copyright © 2017年 Sian. All rights reserved.
//

#import "UIImageView+SAUpload.h"
#import <objc/runtime.h>
#import "UIView+SA.h"
#import "SAConst.h"

@implementation UIImageView (SAUpload)

- (void)setUploadState:(SAImageUploadState)uploadState
{
    objc_setAssociatedObject(self, @selector(uploadState), @(uploadState), OBJC_ASSOCIATION_ASSIGN);
    switch (uploadState) {
        case SAImageUploadStateNormal:{
            self.stateView.hidden = YES;
            self.stateView.backgroundColor = [UIColor clearColor];
            [self.loading stopAnimating];
            self.stateIcon.hidden = YES;
        }break;
        case SAImageUploadStateUploading:{
            self.stateView.hidden = NO;
            self.stateView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
            [self.loading startAnimating];
            self.stateIcon.hidden = YES;
        }break;
        case SAImageUploadStateUploadFaile:{
            self.stateView.hidden = NO;
            self.stateView.backgroundColor = [UIColor clearColor];
            [self.loading stopAnimating];
            self.stateIcon.hidden = NO;
            self.stateIcon.image = [UIImage imageNamed:@"icon_public_state_fail.png"];
        }break;
        case SAImageUploadStateUploadSuccess:{
            self.stateView.hidden = NO;
            self.stateView.backgroundColor = [UIColor clearColor];
            [self.loading stopAnimating];
            self.stateIcon.hidden = NO;
            self.stateIcon.image = [UIImage imageNamed:@"icon_public_state_success.png"];
        }break;
        default:break;
    }
}


#pragma mark - Get方法
- (NSURLSessionDataTask *)networkTask
{
    return objc_getAssociatedObject(self, @selector(networkTask));
}
- (SAImageUploadState)uploadState
{
    return [objc_getAssociatedObject(self, @selector(uploadState)) integerValue];
}
- (UIImageView *)stateIcon
{
    UIImageView *imageView = objc_getAssociatedObject(self, @selector(stateIcon));
    if (imageView == nil){
        CGFloat w = 20.0f;
        CGFloat h = 20.0f;
        imageView = [[UIImageView alloc] init];
        imageView.bounds = CGRectMake(0, 0, w, h);
        // 居右下角对齐
        imageView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin;
        imageView.hidden = YES;
        [self.stateView addSubview:imageView];
        objc_setAssociatedObject(self, @selector(stateIcon), imageView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    imageView.sa_x = self.stateView.sa_width - imageView.sa_width;
    imageView.sa_y = self.stateView.sa_height - imageView.sa_height;
    return imageView;
}
- (UIActivityIndicatorView *)loading
{
    UIActivityIndicatorView *activityIndicatory = objc_getAssociatedObject(self, @selector(loading));
    if (activityIndicatory == nil){
        activityIndicatory = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        activityIndicatory.autoresizingMask = kSAAutoresizingMaskScale;
        [self.stateView addSubview:activityIndicatory];
        objc_setAssociatedObject(self, @selector(loading), activityIndicatory, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    activityIndicatory.frame = self.stateView.bounds;
    return activityIndicatory;
}
- (UIView *)stateView
{
    UIView *view = objc_getAssociatedObject(self, @selector(stateView));
    if (view == nil){
        view = [[UIView alloc] init];
        view.autoresizingMask = kSAAutoresizingMaskScale;
        [self addSubview:view];
        objc_setAssociatedObject(self, @selector(stateView), view, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    view.frame = self.bounds;
    return view;
}
#warning 图片上传
/// 上传照片
//- (void)uploadWithSuccess:(SARequestSuccess)success
//{
//    NSDictionary *para = [SANetwork paraWithReqData:nil];
//    NSData *data = UIImageJPEGRepresentation(self.image, kSAImageQuality);
//    SABlockSelf blockself = self;
//    self.uploadState = SAImageUploadStateUploading;
//    self.networkTask = [SANetwork POST:kSAUploadJsonGetId para:para file:data success:^(id responseObject) {
//        blockself.uploadState = SAImageUploadStateUploadSuccess;
//        if (success) success(responseObject);
//    }];
//}

//- (void)setNetworkTask:(NSURLSessionDataTask *)networkTask
//{
//    if (self.networkTask == nil){
//        [SANotice addObserver:self selector:@selector(networkResponseError:) name:kSANoticeNetworkResponseError object:nil];
//    }
//    objc_setAssociatedObject(self, @selector(networkTask), networkTask, OBJC_ASSOCIATION_COPY_NONATOMIC);
//}

//- (void)networkResponseError:(NSNotification *)notification
//{
//    NSURLSessionDataTask *task = [(SANetworkNoticeObject *)notification.object task];
//    if (self.networkTask != task) return;
//    self.uploadState = SAImageUploadStateUploadFaile;
//}

//- (void)dealloc
//{
//    [NSNotificationCenter.defaultCenter removeObserver:self];
//}
@end
