//
//  UIImage+SA.m
//  SACategory
//
//  Created by 余西安 on 14/12/1.
//  Copyright (c) 2014年 Sian. All rights reserved.
//

#import "UIImage+SA.h"
#import "SDWebImageDownloader.h"

#define kSAImageSize                    640
#define kSAImageQuality                 0.5

@implementation UIImage (SA)

+ (instancetype)imageAutoName:(NSString *)imageName
{
    CGFloat width = [[UIScreen mainScreen] bounds].size.width;
    // iphone6、iphone6s屏幕尺寸
    if (width == 375){
        NSString *extension = [imageName pathExtension];
        imageName = [imageName stringByDeletingPathExtension];
        imageName = [imageName stringByAppendingString:@"_750"];
        imageName = [imageName stringByAppendingPathExtension:extension];
    }
    return [self imageNamed:imageName];
}

+ (instancetype)resizedImageName:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    CGFloat v = image.size.height * 0.5;
    CGFloat h = image.size.width  * 0.5;
    UIEdgeInsets insets = UIEdgeInsetsMake(v, h, v, h);
    return [[UIImage imageNamed:imageName] resizableImageWithCapInsets:insets];
}

+ (instancetype)roundCutImage:(UIImage *)image edgeWidth:(float)width
{
    // 0、新图片的大小为原有图片基本上加外边框宽度
    CGSize newSize = CGSizeMake(image.size.width + width * 2, image.size.height + width * 2);
    
    // 1、开启位图上下文
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    
    // 2、获取位图上下文
    CGContextRef c = UIGraphicsGetCurrentContext();
    
    // 3、以新图片大小画底色为白色的圆
    CGContextAddEllipseInRect(c, (CGRect){CGPointZero, newSize});
    CGContextSetFillColorWithColor(c, [UIColor whiteColor].CGColor);
    CGContextFillPath(c);
    
    // 4、在图像上下文中描述一个原图大小的圆
    CGRect imageRect = (CGRect){width, width, image.size};
    CGContextAddEllipseInRect(c, imageRect);
    
    // 5、对描述进行裁剪，即其他区域不可渲染
    CGContextClip(c);
    
    // 6、将原图片渲染到上下文（被裁剪区域不可见）
    [image drawInRect:imageRect];
    
    // 7、获取上下文渲染出来的图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 8、关闭上下文描述
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (instancetype)original
{
    return [self imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

- (UIImage *)transformToSmall
{
    CGSize bigSize = self.size;
    CGSize subSize = CGSizeZero;
    
    if (bigSize.width > bigSize.height){
        subSize.width = kSAImageSize / [UIScreen mainScreen].scale;
        subSize.height = bigSize.height * subSize.width / bigSize.width;
    }else{
        subSize.height = kSAImageSize / [UIScreen mainScreen].scale;
        subSize.width = bigSize.width * subSize.height / bigSize.height;
    }
    
    CGRect subRect = (CGRect){CGPointZero, subSize};
    
    // 1、开启位图上下文
    UIGraphicsBeginImageContextWithOptions(subSize, NO, 0.0);
    
    // 1.5、渲染背景色
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [[UIColor redColor] CGColor]);
    CGContextFillRect(context, subRect);
    
    // 2、将原图片渲染到上下文
    [self drawInRect:subRect];
    
    // 3、获取上下文渲染出来的图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    // 4、关闭上下文描述
    UIGraphicsEndImageContext();
    
    return image;
}

+ (instancetype)clearImage
{
    return [self imageWithColor:[UIColor clearColor]];
}

+ (instancetype)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

/// 生成二维码
+ (instancetype)QRImageWithString:(NSString *)string size:(CGSize)size
{
    NSData *stringData = [string dataUsingEncoding:NSUTF8StringEncoding];
    CIFilter *qrFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [qrFilter setValue:stringData forKey:@"inputMessage"];
    [qrFilter setValue:@"M" forKey:@"inputCorrectionLevel"];
    CIImage *outputImage = qrFilter.outputImage;
    CGFloat scale = [[UIScreen mainScreen] scale];
    UIImage *image = [UIImage imageWithCIImage:outputImage scale:scale orientation:UIImageOrientationUp];
    return [image scaleToSize:size interpolation:kCGInterpolationNone];
}

/// 图片放大
- (instancetype)scaleToSize:(CGSize)size
{
    return [self scaleToSize:size interpolation:kCGInterpolationHigh];
}

- (instancetype)scaleToSize:(CGSize)size interpolation:(CGInterpolationQuality)quality
{
    // 开启指定大小的上下文
    UIGraphicsBeginImageContextWithOptions(size, NO, self.scale);
    // 获取当前上下文,设置插值质量
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetInterpolationQuality(context, quality);
    // 将当前图片渲染到当前上下文
    [self drawInRect:(CGRect){CGPointZero, size}];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

/// 增加中心头像
- (instancetype)addImage:(UIImage *)image rect:(CGRect)rect
{
    CGFloat s = self.scale;
    CGFloat r = 5.0f * s;
    CGFloat x = rect.origin.x * s;
    CGFloat y = rect.origin.y * s;
    CGFloat w = rect.size.width * s;
    CGFloat h = rect.size.height * s;
    // 1、开启位图上下文
    CGSize size = CGSizeMake(self.size.width * s, self.size.height * s);
    UIGraphicsBeginImageContextWithOptions(size, NO, s);
    
    // 2、将原图片渲染到上下文
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    [image drawInRect:CGRectMake(x, y, w, h)];
    
    // 3、画内图白色边框
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, [[UIColor whiteColor] CGColor]);
    CGContextSetLineWidth(context, 3.0f * s);
    CGContextMoveToPoint(context, x, y + r);
    CGContextAddArcToPoint(context, x, y, x + r, y, r);
    CGContextAddArcToPoint(context, x + w, y, x + w, y + r, r);
    CGContextAddArcToPoint(context, x + w, y + h, x + w - r, y + h, r);
    CGContextAddArcToPoint(context, x, y + h, x, y + h - r, r);
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathStroke); //根据坐标绘制路径
    UIImage *rimage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return rimage;
}

- (NSString *)base64Encoding
{
    NSData *data = UIImageJPEGRepresentation(self, 0.5);
    return [data base64EncodedStringWithOptions:0];
}

+ (instancetype)imageWithCity:(NSString *)cityName font:(UIFont *)font
{
    NSDictionary *attributes = @{NSFontAttributeName:font, NSForegroundColorAttributeName:[UIColor whiteColor]};
    CGSize fontSize = [cityName sizeWithAttributes:attributes];
    CGFloat sideWidth = fontSize.height / 3;
    CGSize contentSize = CGSizeMake(fontSize.width + sideWidth * 2 + 2, fontSize.height);
    
    // 开启指定大小的上下文
    UIGraphicsBeginImageContextWithOptions(contentSize, NO, [[UIScreen mainScreen] scale]);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 画文字
    [cityName drawInRect:(CGRect){CGPointZero, fontSize} withAttributes:attributes];    // 文字渲染
    
    // 画箭头
    CGContextSetLineWidth(context, 1.0);
    CGContextSetFillColorWithColor(context, [[UIColor whiteColor] CGColor]);
    CGPoint pArray[3];
    CGFloat startX = fontSize.width + 1;    // 起始x位置
    pArray[0] = CGPointMake(startX, sideWidth);
    pArray[1] = CGPointMake(startX + sideWidth, sideWidth * 2);
    pArray[2] = CGPointMake(startX + sideWidth * 2, sideWidth);
    CGContextAddLines(context, pArray, 3);
    CGContextDrawPath(context, kCGPathStroke);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    return image;
}

@end
