//
//  MBProgressHUD+Custom.m
//  HouseKeeper
//
//  Created by 高泽民 on 16/11/9.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "MBProgressHUD+Custom.h"

@implementation MBProgressHUD (Custom)

//+ (MBProgressHUD *)showProgressCustomViewForView:(UIView *)view animated:(BOOL)animated{
//    MBProgressHUD *hud = [MBProgressHUD showProgressCustomViewForView:view animated:YES];
//    hud.mode = MBProgressHUDModeCustomView;
//    //indicator
//    UIProgressView *progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 0, MIN(view.width, 200), 5)];
//    progressView.center = view.center;
//    progressView.progressTintColor = [UIColor clearColor];
//    progressView.trackTintColor = KMajorColor;
//    progressView.progress = hud.progress;
//    if (progressView.progress >= 1) {
//        [progressView removeFromSuperview];
//    }
//    hud.customView = progressView;
//    return nil;
//}

@end
