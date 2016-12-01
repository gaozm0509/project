//
//  BaseViewController.m
//  HouseKeeper
//
//  Created by 高泽民 on 16/7/16.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "BaseViewController.h"
#import "HomeViewController.h"
#import "OrderViewController.h"
#import "AssetViewController.h"
#import "PersonalCenterViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"f0f0f0"];

    
    
    self.navigationController.interactivePopGestureRecognizer.delegate=(id)self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear: animated];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

- (void)setBackgroundImage:(UIImage *)backgroundImage{
    UIImageView *imgView = [[UIImageView alloc]initWithImage:backgroundImage];
    imgView.frame = self.view.bounds;
}

- (MBProgressHUD *)hudView{
    if (!_hudView) {
        _hudView = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    }
    return _hudView;
}

#pragma mark - 子类中实现的方法
- (void)netRequest{};




@end
