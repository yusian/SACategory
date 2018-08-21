//
//  UIImage+SA.h
//  OpenMIG
//
//  Created by 余西安 on 14/12/1.
//  Copyright (c) 2014年 Sian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (SA)

// 自适应屏幕尺寸
+ (instancetype)imageAutoName:(NSString *)imageName;

// 自动拉伸图片中点
+ (instancetype)resizedImageName:(NSString *)imageName;

// 裁剪成圆形图片
+ (instancetype)roundCutImage:(UIImage *)image edgeWidth:(float)width;

// 强制原图
- (instancetype)original;

- (UIImage *)transformToSmall;

+ (instancetype)clearImage;

+ (instancetype)imageWithColor:(UIColor *)color;

+ (instancetype)QRImageWithString:(NSString *)string size:(CGSize)size;

- (instancetype)addImage:(UIImage *)image rect:(CGRect)rect;

- (instancetype)scaleToSize:(CGSize)size;

- (NSString *)base64Encoding;

+ (instancetype)imageWithCity:(NSString *)cityName font:(UIFont *)font;
@end
