//
//  LoginView.m
//  HouseKeeper
//
//  Created by 高泽民 on 16/7/20.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "LoginView.h"

#define kTextFont [UIFont systemFontOfSize:12]
#define kMarginLeft 35
#define kHeight 44
#define kCodeBtnWidht 85

@implementation LoginView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubViews];
    }
    return self;
}

- (UIImageView *)bgImageView{
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"login_bg"]];
    }
    return _bgImageView;
}

- (UIImageView *)topView{
    if (!_topView) {
        _topView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"logo"]];
    }
    return _topView;
}

- (UITextField *)phoneTextField{
    if (!_phoneTextField) {
        _phoneTextField = [[UITextField alloc]init];
        _phoneTextField.placeholder = @"请输入您的手机号码";
        _phoneTextField.font = kTextFont;
        _phoneTextField.textColor = [UIColor whiteColor];
        _phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
        _phoneTextField.leftViewMode = UITextFieldViewModeAlways;
        _phoneTextField.clearButtonMode = UITextFieldViewModeAlways;
        
        UIImageView *img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"login_phone_left"]];
        img.frame = CGRectMake(0, 0, 20, 20);
        img.contentMode = UIViewContentModeCenter;
        _phoneTextField.leftView = img;
        UIView *bottomLine = [[UIView alloc]init];
        bottomLine.backgroundColor = [UIColor whiteColor];
        [_phoneTextField addSubview:bottomLine];
        WS(ws);
        [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(ws.phoneTextField.mas_bottom);
            make.height.offset(0.5);
            make.left.equalTo(ws.phoneTextField);
            make.right.equalTo(ws.phoneTextField.mas_right);
        }];
        
    }
    return _phoneTextField;
}

- (UITextField *)codeTextField{
    if (!_codeTextField) {
        _codeTextField = [[UITextField alloc]init];
        _codeTextField.placeholder = @"请输入验证码";
        _codeTextField.font = kTextFont;
        _codeTextField.textColor = [UIColor whiteColor];
        _codeTextField.keyboardType = UIKeyboardTypeNumberPad;
        _codeTextField.leftViewMode = UITextFieldViewModeAlways;
        _codeTextField.clearButtonMode = UITextFieldViewModeAlways;
        
        UIImageView *img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"login_code_left"]];
        img.frame = CGRectMake(0, 0, 20, 20);
        _codeTextField.leftView = img;
        img.contentMode = UIViewContentModeCenter;
        UIView *bottomLine = [[UIView alloc]init];
        bottomLine.backgroundColor = [UIColor whiteColor];
        [_codeTextField addSubview:bottomLine];
        WS(ws);
        [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(ws.codeTextField.mas_bottom);
            make.height.offset(0.5);
            make.left.equalTo(ws.codeTextField);
            make.right.equalTo(ws.codeTextField.mas_right);
        }];
    }
    return _codeTextField;
}

- (UIButton *)codeButton{
    if (!_codeButton) {
        _codeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _codeButton.tag = 1001;
        _codeButton.backgroundColor = KMajorColor;
        [_codeButton setTitleColor:[UIColor colorWithHexString:@"ffffff" andAlpha:0.5] forState:UIControlStateHighlighted];
        [_codeButton addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [_codeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        _codeButton.titleLabel.font = kTextFont;
        _codeButton.layer.cornerRadius = 3;
    }
    return _codeButton;
}

- (UIButton *)loginButton{
    if (!_loginButton) {
        _loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _loginButton.tag = 1002;
        _loginButton.backgroundColor = KMajorColor;
        [_loginButton setTitleColor:[UIColor colorWithHexString:@"ffffff" andAlpha:0.5] forState:UIControlStateHighlighted];
        [_loginButton addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        _loginButton.titleLabel.font = [UIFont systemFontOfSize:15];
        _loginButton.layer.cornerRadius = 5;
        [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
    }
    return _loginButton;
}

- (UIButton *)wechartButton{
    if (!_wechartButton) {
        _wechartButton = [[UIButton alloc]init];
        [_wechartButton setImage:[UIImage imageNamed:@"weichart"] forState:UIControlStateNormal];
        [_wechartButton addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        _wechartButton.tag = 1003;
    }
    return _wechartButton;
}


- (UIView *)divisionView{
    if (!_divisionView) {
        _divisionView = [[UIView alloc]init];
        _divisionView.backgroundColor = [UIColor clearColor];
        
        UIView *leftLine = [[UIView alloc]init];
        leftLine.backgroundColor = [UIColor blackColor];
        [_divisionView addSubview:leftLine];
        
        UILabel *label = [[UILabel alloc]init];
        label.text = @"第三方登录";
        label.textColor = [UIColor blackColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:11];
        [_divisionView addSubview:label];
        
        UIView *rightLine = [[UIView alloc]init];
        rightLine.backgroundColor = [UIColor blackColor];
        [_divisionView addSubview:rightLine];
        
        WS(weakSelf);
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.offset(60);
            make.center.equalTo(weakSelf.divisionView);
            make.height.offset(20);
        }];
        [leftLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.divisionView);
            make.height.offset(1);
            make.right.equalTo(label.mas_left).offset(-5);
            make.centerY.equalTo(label.mas_centerY);
        }];
        [rightLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(weakSelf.divisionView.mas_right);
            make.height.offset(1);
            make.left.equalTo(label.mas_right).offset(5);
            make.centerY.equalTo(label.mas_centerY);
        }];
    }
    return _divisionView;
}

- (UIButton *)weiboButton{
    if (!_weiboButton) {
        _weiboButton = [[UIButton alloc]init];
        [_weiboButton setImage:[UIImage imageNamed:@"weibo"] forState:UIControlStateNormal];
//        _weiboButton.img.image = [UIImage imageWithColor:[UIColor redColor]];
//        _weiboButton.textLabel.text = @"微博";
        [_weiboButton addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        _weiboButton.tag = 1004;
    }
    return _weiboButton;
}

- (UIButton *)qqButton{
    if (!_qqButton) {
        _qqButton = [[ThirdPartyButton alloc]init];
        [_qqButton setImage:[UIImage imageNamed:@"qq"] forState:UIControlStateNormal];
        [_qqButton addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        _qqButton.tag = 1005;
    }
    return _qqButton;
}

- (void)setupSubViews{
    [self addSubview:self.bgImageView];
    [self addSubview:self.topView];
    [self addSubview:self.phoneTextField];
    [self addSubview:self.codeTextField];
    [self addSubview:self.codeButton];
    [self addSubview:self.loginButton];
//    [self addSubview:self.divisionView];
//    [self addSubview:self.wechartButton];
//    [self addSubview:self.weiboButton];
//    [self addSubview:self.qqButton];
    
    WS(ws);
    [_bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(ws.mas_right);
        make.left.equalTo(ws);
        make.top.equalTo(ws);
        make.bottom.equalTo(ws.mas_bottom);
    }];
    [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws).with.offset(30 + kNavHeight);
        make.width.offset(110);
        make.height.offset(80);
        make.centerX.equalTo(ws.mas_centerX);
    }];
    [_phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.topView.mas_bottom).offset(30);
        make.left.equalTo(ws).offset(kMarginLeft);
        make.right.equalTo(ws.mas_right).offset(- kMarginLeft);
        make.height.offset(kHeight / 2);
    }];

    [_codeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws).offset(kMarginLeft);
        make.height.offset(kHeight / 2);
        make.top.equalTo(ws.phoneTextField.mas_bottom).offset(20);
        make.right.equalTo(ws.mas_right).offset(- kMarginLeft - kCodeBtnWidht - 10);
    }];
    [_codeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(ws.codeTextField.mas_bottom);
        make.width.offset(kCodeBtnWidht);
        make.right.equalTo(ws.mas_right).offset(- kMarginLeft);
        make.height.offset(kHeight / 2);
    }];
    [_loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.codeTextField.mas_bottom).offset(40);
        make.left.equalTo(ws).offset(kMarginLeft);
        make.right.equalTo(ws.mas_right).offset(- kMarginLeft);
        make.height.offset(kHeight);
    }];
//    [_divisionView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(ws).offset(15);
//        make.height.offset(20);
//        make.right.equalTo(ws.mas_right).offset(- 15);
//        make.top.equalTo(ws.loginButton.mas_bottom).offset(25);
//    }];
//    [_wechartButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(ws.divisionView.mas_bottom).offset(10);
//        make.left.equalTo(ws).offset(2 *kMarginLeft);
//        make.width.offset(40);
//        make.height.offset(40);
//    }];
//    [_weiboButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(ws.wechartButton.mas_centerY);
//        make.centerX.equalTo(ws.mas_centerX);
//        make.width.offset(40);
//        make.height.offset(40);
//    }];
//    [_qqButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(ws.wechartButton.mas_centerY);
//        make.right.equalTo(ws).offset(- 2 *kMarginLeft);
//        make.width.offset(40);
//        make.height.offset(40);
//    }];
}

- (void)click:(UIButton *)button{
    if (button.tag == 1001) {
        if (![self.phoneTextField.text isPhoneNum]) {
            [self showHudTipStr:@"请输入正确手机号码"];
            return;
        }
        //发送验证码
        [self.delegate sendCodeEvent];
    }
    if (button.tag == 1002) {
        //登录
        if (![self.phoneTextField.text isPhoneNum]) {
            [self showHudTipStr:@"请输入正确手机号码"];
            return;
        }
        if (self.codeTextField.text.length == 0) {
            [self showHudTipStr:@"请输入验证码"];
            return;
        }
        [self.delegate loginEvent];
    }
}

@end



@implementation ThirdPartyButton

- (instancetype)init{
    self = [super init];
    if (self) {
        [self setupSubViews];
    }
    return self;
}

- (UIImageView *)img{
    if (!_img) {
        _img = [[UIImageView alloc]init];
    }
    return _img;
}

- (UILabel *)textLabel{
    if (!_textLabel) {
        _textLabel = [[UILabel alloc]init];
        _textLabel.font = [UIFont systemFontOfSize:10];
        _textLabel.textColor = [UIColor blackColor];
        _textLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _textLabel;
}

- (void)setupSubViews{
    [self addSubview:self.img];
    [self addSubview:self.textLabel];
    
    WS(weakSelf);
    [_img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf);
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.height.offset(20);
        make.width.offset(20);
    }];
    [_textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.img.mas_bottom).offset(10);
        make.height.offset(12);
        make.width.offset(25);
        make.centerX.equalTo(weakSelf.mas_centerX);
    }];
}

@end
