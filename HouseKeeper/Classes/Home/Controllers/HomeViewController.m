//
//  HomeViewController.m
//  HouseKeeper
//
//  Created by 高泽民 on 16/7/16.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@property (nonatomic, strong) UIButton *rightButton;

@end

@implementation HomeViewController

#pragma mark - Life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"首页";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.rightButton];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    self.hidesBottomBarWhenPushed = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - Getter and setter

- (UIButton *)rightButton{
    if (!_rightButton) {
        _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightButton.frame = CGRectMake(0, 0, 30, 30);
        [_rightButton setTitle:@"服务" forState:UIControlStateNormal];
        [_rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _rightButton.titleLabel.font = kFont14;
        [_rightButton addTarget:self action:@selector(rightButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightButton;
}

#pragma mark - Delegate



#pragma mark - Net request



#pragma mark - Pravit method

- (void)rightButtonClick:(UIButton *)button{
    [self pushNewViewController:@"LifeServiceViewController"];
}

@end
