//
//  LoginViewController.m
//  HouseKeeper
//
//  Created by 高泽民 on 16/7/20.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginView.h"

@interface LoginViewController ()

@property (nonatomic, strong)LoginView *loginView;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.loginView];
    self.navigationController.navigationBarHidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (LoginView *)loginView{
    if (!_loginView) {
        _loginView = [[LoginView alloc]initWithFrame:self.view.bounds];
    }
    return _loginView;
}

@end
