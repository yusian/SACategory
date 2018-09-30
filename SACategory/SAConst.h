
//
//  SAConst.h
//  SACategory
//
//  Created by 余西安 on 2018/8/20.
//  Copyright © 2018年 yusian. All rights reserved.
//

#ifndef SAConst_h
#define SAConst_h

// 颜色RBG值
#define SAColor(rgb)    [UIColor colorWithRed:((rgb&0xFF0000)>>16)/255.0 \
                                        green:((rgb&0x00FF00)>>8)/255.0 \
                                         blue:((rgb&0x0000FF)>>0)/255.0 \
                                        alpha:1.0]
// 自定义输出 SALog(...)
#ifdef DEBUG
//#define SALog(FORMAT, ...) fprintf(stderr, "%s-%d行\t%s\n", __PRETTY_FUNCTION__, __LINE__, [[NSString stringWithFormat: FORMAT, ## __VA_ARGS__] UTF8String])
#define SALog(...) NSLog(@"%s-%d行:%@", __PRETTY_FUNCTION__, __LINE__, [NSString stringWithFormat:__VA_ARGS__])
#else
#define SALog(...)
#endif
// UIViewAutoresizingFlexible
#define kSAAutoresizingMaskScale    UIViewAutoresizingFlexibleWidth      | UIViewAutoresizingFlexibleHeight
#define kSAAutoresizingMaskFloatX   UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin
#define kSAAutoresizingMaskFloatY   UIViewAutoresizingFlexibleTopMargin  | UIViewAutoresizingFlexibleBottomMargin
#define kSAAutoresizingMaskFloat    kSAAutoresizingMaskFloatX            | kSAAutoresizingMaskFloatY

#import "Masonry.h"
#endif /* SAConst_h */
