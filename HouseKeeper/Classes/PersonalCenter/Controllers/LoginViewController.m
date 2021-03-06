//
//  LoginViewController.m
//  HouseKeeper
//
//  Created by 高泽民 on 16/7/20.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginView.h"
#import "AssetAddaddressViewController.h"
#import "TabBarViewController.h"
#import "UserAccout.h"
#import "StateModel.h"

#define kSendCodeTime 60

@interface LoginViewController ()<LoginViewDelegate>

@property (nonatomic, strong)LoginView *loginView;

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger currentTimer;

@property (nonatomic, strong) UIButton *backButton;

@end

@implementation LoginViewController

#pragma mark - Cycle life

- (void)dealloc{
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.loginView];
    
    
//    if (_isFirstStartUp) {
//        [self.view addSubview:self.backButton];
//    }
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
    [self.view endEditing:YES];
    [self netRequestLogin];
}

- (void)sendCodeEvent{
    [self netRequestSendCode];
}

#pragma mark - Net request

- (void)netRequestSendCode{
    
    NSMutableDictionary *params = [NSMutableDictionary new];
    [params setValue:_loginView.phoneTextField.text forKey:@"mobile"];
    
    [kApi_member_sendVerificationCode httpRequestWithParams:params networkMethod:Post andBlock:^(id data, NSError *error) {
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
    
//    [params setValue:@"18036396675" forKey:@"mobile"];
//    [params setValue:@"123456" forKey:@"code"];
    
    [kApi_member_signin httpRequestWithParams:params networkMethod:Post andBlock:^(id data, NSError *error) {
        
        if (error) {
            [self showError:error];
            NSLog(@"%@",error);
//            UIWindow * window = [[UIApplication sharedApplication].delegate window];
//            window.rootViewController = [[UINavigationController alloc]initWithRootViewController:[AssetAddaddressViewController new]];
//            window.rootViewController = [TabBarViewController new];
            return ;
        }
        if ([data[@"code"] integerValue] == 1) {
            UserAccout *userAccout = [[UserAccout alloc]initWithDic:data[@"data"]];
            
            [UsersManager savePhone:userAccout.mobile];
            [UsersManager saveMemberId:userAccout.id];
            [UsersManager saveRights:userAccout.rights];
            [UsersManager saveName:userAccout.name];
            
            NSLog(@"%@",userAccout);
            [self getState];
            
        }
    }];
}

- (void)getState{
    [kApi_state httpRequestWithParams:[@{} mutableCopy] hudView:self.hudView networkMethod:Post andBlock:^(id data, NSError *error) {
        if (error) {
            [self showError:error];
            return ;
        }
        if ([data[@"code"] integerValue] == 1) {
            id stateObj = data[@"data"][@"data"];
            StateModel *state;
            if ([stateObj isKindOfClass:[NSDictionary class]]) {
                state = [[StateModel alloc] initWithDic:stateObj];
            }
            if ([stateObj isKindOfClass:[NSArray class]]) {
                state = [[StateModel alloc] initWithDic:[stateObj firstObject]];
            }
            
            UIWindow * window = [[UIApplication sharedApplication].delegate window];
            if (state.id.length > 0) {
                window.rootViewController = [TabBarViewController new];
                [UsersManager saveStateModel:state];
            }
            else{
                AssetAddaddressViewController *vc = [[AssetAddaddressViewController alloc] init];
                vc.receiveParams = [[NSMutableDictionary alloc] init];
                [vc.receiveParams setValue:@"isEdit" forKey:@"isEdit"];
                window.rootViewController = [[UINavigationController alloc]initWithRootViewController:vc];
            }
        }
    }];
}


#pragma mark - Event method

- (void)sendCodeButtonChange:(NSTimer *)timer{
    _currentTimer --;
    if (_currentTimer > 0) {
        [_loginView.codeButton setTitle:[NSString stringWithFormat:@"%ld重新获取",_currentTimer] forState:UIControlStateNormal];
        _loginView.codeButton.userInteractionEnabled = NO;
    }
    else{
        [_loginView.codeButton setBackgroundColor:KMajorColor];
        [_loginView.codeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        _loginView.codeButton.userInteractionEnabled = YES;
    }
}

- (void)click:(UIButton *)button{
    if (button.tag == 1001) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark - Pravit method


@end
