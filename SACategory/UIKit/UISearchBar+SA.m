//
//  UISearchBar+SA.m
//  SACategoryDemo
//
//  Created by 余西安 on 2018/9/12.
//  Copyright © 2018年 yusian. All rights reserved.
//

#import "UISearchBar+SA.h"

@implementation UISearchBar (SA)

- (UITextField *)searchField
{
    UITextField *searchField = nil;
    @try {
         searchField = [self valueForKey:@"_searchField"];
    } @catch (NSException *exception) {
        
    } @finally {
        return searchField;
    }
}
@end
