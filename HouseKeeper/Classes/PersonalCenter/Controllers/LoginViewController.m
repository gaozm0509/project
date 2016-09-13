//
//  LoginViewController.m
//  HouseKeeper
//
//  Created by 高泽民 on 16/7/20.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginView.h"

#define kSendCodeTime 60

@interface LoginViewController ()<LoginViewDelegate>

@property (nonatomic, strong)LoginView *loginView;

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger currentTimer;

@property (nonatomic, strong) UIButton *backButton;

@end

@implementation LoginViewController

#pragma mark - Cycle life
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.loginView];
    [self.view addSubview:self.backButton];
    
    [self.navigationController.navigationBar setHidden:YES];
    
    _currentTimer = 60;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setHidden:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Getter and setter

- (LoginView *)loginView{
    if (!_loginView) {
        _loginView = [[LoginView alloc]initWithFrame:self.view.bounds];
        _loginView.delegate = self;
    }
    return _loginView;
}

- (UIButton *)backButton{
    if (!_backButton) {
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _backButton.frame = CGRectMake(5, 15, 30, 30);
        [_backButton setImage:Image(@"back") forState:UIControlStateNormal];
        _backButton.tag = 1001;
        [_backButton addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backButton;
}

#pragma mark - Delegate
#pragma mark LoginViewDelegate

- (void)loginEvent{
    [self netRequestLogin];
}

- (void)sendCodeEvent{
    [self netRequestSendCode];
}

#pragma mark - Net request

- (void)netRequestSendCode{
    
    NSMutableDictionary *params = [NSMutableDictionary new];
    [params setValue:_loginView.phoneTextField.text forKey:@"mobile"];
    
    [kApi_employee_sendVerificationCode httpRequestWithParams:params networkMethod:Post andBlock:^(id data, NSError *error) {
        if (error) {
            [self showError:error];
            return ;
        }
        if ([data[@"code"] integerValue] == 1) {
            [self showHudTipStr:@"验证码已发送"];
            //验证码框获取焦点
            [self.loginView.codeTextField becomeFirstResponder];
            
            _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(sendCodeButtonChange:) userInfo:nil repeats:YES];
            [_loginView.codeButton setBackgroundColor:Color_Hex(@"999999")];
        }
    }];
}

- (void)netRequestLogin{
    
    NSMutableDictionary *params = [NSMutableDictionary new];
    [params setValue:_loginView.phoneTextField.text forKey:@"mobile"];
    [params setValue:_loginView.codeTextField.text forKey:@"code"];
    
    [kApi_employee_signin httpRequestWithParams:params networkMethod:Post andBlock:^(id data, NSError *error) {
        if (error) {
            [self showError:error];
            return ;
        }
        if ([data[@"code"] integerValue] == 0) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }];
}

#pragma mark - Event method

- (void)sendCodeButtonChange:(NSTimer *)timer{
    _currentTimer --;
    if (_currentTimer > 0) {
        [_loginView.codeButton setTitle:[NSString stringWithFormat:@"%ld",_currentTimer] forState:UIControlStateNormal];
        _loginView.userInteractionEnabled = NO;
    }
    else{
        [_loginView.codeButton setBackgroundColor:KMajorColor];
        [_loginView.codeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        _loginView.userInteractionEnabled = YES;
    }
}

- (void)click:(UIButton *)button{
    if (button.tag == 1001) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark - Pravit method


@end
