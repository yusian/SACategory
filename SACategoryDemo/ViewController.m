//
//  ViewController.m
//  SACategoryDemo
//
//  Created by 余西安 on 2018/8/20.
//  Copyright © 2018年 yusian. All rights reserved.
//

#import "ViewController.h"
#import "UIView+WebCache.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = UIColor.redColor;
    [self.view sd_setIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [self.view sd_addActivityIndicator];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.view sd_removeActivityIndicator];
    });
}

@end
