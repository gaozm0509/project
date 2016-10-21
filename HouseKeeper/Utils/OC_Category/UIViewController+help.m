//
//  UIViewController+help.m
//  HouseKeeper
//
//  Created by 高泽民 on 16/9/11.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "UIViewController+help.h"
#import "BaseViewController.h"

@implementation UIViewController (help)

- (void)pushNewViewController:(NSString *)VCName params:(NSDictionary *)params{
    BaseViewController *VC = (BaseViewController *)[[NSClassFromString(VCName) alloc]init];
    if (params != nil) {
        VC.receiveParams = params;
    }
    
    self.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:VC animated:YES];
    if (([self isKindOfClass:NSClassFromString(@"AssetViewController")] ||
          [self isKindOfClass:NSClassFromString(@"HomeViewController")] ||
          [self isKindOfClass:NSClassFromString(@"OrderViewController")] ||
          [self isKindOfClass:NSClassFromString(@"PersonalCenterViewController")])
        ){
        self.hidesBottomBarWhenPushed=NO;
    }
}


- (void)pushNewViewController:(NSString *)VCName{
    BaseViewController *VC = (BaseViewController *)[[NSClassFromString(VCName) alloc]init];
        
    self.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:VC animated:YES];
    if (([self isKindOfClass:NSClassFromString(@"AssetViewController")] ||
        [self isKindOfClass:NSClassFromString(@"HomeViewController")] ||
        [self isKindOfClass:NSClassFromString(@"OrderViewController")] ||
        [self isKindOfClass:NSClassFromString(@"PersonalCenterViewController")])
        ){
        self.hidesBottomBarWhenPushed=NO;
    }
    
}

@end
