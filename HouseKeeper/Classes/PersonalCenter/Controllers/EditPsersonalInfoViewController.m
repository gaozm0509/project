//
//  EditPsersonalInfoViewController.m
//  HouseKeeper
//
//  Created by 高泽民 on 16/11/8.
//  Copyright © 2016年 zm. All rights reserved.
//



#import "EditPsersonalInfoViewController.h"

@interface EditPsersonalInfoViewController ()
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIButton *rightButton;
@property (nonatomic, strong) UserAccout *userAccout;
@property (nonatomic ,strong) NSString *type;//1为修改name，2为修改nickName

@property (nonatomic, copy) EditInfoBlock editInfoBlock;

@end

@implementation EditPsersonalInfoViewController

#pragma mark - Cycle life
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.receiveParams[@"title"];
    self.editInfoBlock = self.receiveParams[@"block"];
    self.userAccout = self.receiveParams[@"userAccout"];
    self.type = self.receiveParams[@"type"];
    
    [self.view addSubview:self.textField];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.rightButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Getter and setter

- (UITextField *)textField{
    if (!_textField) {
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 10, kScreen_Width, 45)];
        _textField.placeholder = [NSString stringWithFormat:@"请输入%@",self.title];
        _textField.text = [_type isEqualToString:@"1"] ? _userAccout.name : _userAccout.nickname;
        _textField.font = kFont14;
        _textField.textColor = kText_Color;
        _textField.backgroundColor = [UIColor whiteColor];
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _textField.leftViewMode = UITextFieldViewModeAlways;
        [_textField becomeFirstResponder];
        
        UILabel *leftView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, self.textField.height)];
        leftView.text = self.title;
        leftView.font = kFont14;
        leftView.textColor = kText_Color;
        leftView.textAlignment = NSTextAlignmentCenter;
        
        _textField.leftView = leftView;
        
        [_textField addTarget:self action:@selector(textFieldEvent:) forControlEvents:UIControlEventEditingChanged];
    }
    return _textField;
}

- (UIButton *)rightButton{
    if (!_rightButton) {
        _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightButton.frame = CGRectMake(0, 0, 30, 44);
        
        [_rightButton setTitle:@"保存" forState:UIControlStateNormal];
        [_rightButton setTitleColor:[UIColor colorWithHexString:@"35932a" andAlpha:0.7] forState:UIControlStateNormal];
        [_rightButton setTitleColor:KMajorColor forState:UIControlStateSelected];
        
        _rightButton.titleLabel.font = kFont14;
        
        [_rightButton addTarget:self action:@selector(save:) forControlEvents:UIControlEventTouchUpInside];
        
        _rightButton.userInteractionEnabled = NO;
    }
    return _rightButton;
}

#pragma mark - Delegate



#pragma mark - Net request

- (void)netRequest{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if ([_type isEqualToString:@"1"]) {
        [params setValue:_textField.text forKey:@"name"];
        [params setValue:_userAccout.nickname forKey:@"nickname"];
    }
    else{
        [params setValue:_userAccout.name forKey:@"name"];
        [params setValue:_textField.text forKey:@"nickname"];
    }
    [params setValue:_userAccout.gender forKey:@"gender"];
    [params setValue:_userAccout.birth forKey:@"birth"];
    [kApi_member_update httpRequestWithParams:params networkMethod:Post andBlock:^(id data, NSError *error) {
        if (error) {
            [self showError:error];
            return ;
        }
        if ([data[@"code"] integerValue] == 1) {
            _userAccout = [[UserAccout alloc] initWithDic:data[@"data"]];
            if (self.editInfoBlock) {
                self.editInfoBlock(_userAccout);
            }
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
}

#pragma mark - Event method

- (void)save:(UIButton *)button{
    [self netRequest];
}

- (void)textFieldEvent:(UITextField *)textField{
    int limit = 20;
    if (textField.text.length > limit) {
        textField.text = [textField.text substringToIndex:limit];
    }
    NSString *text = @"";
    if ([_type isEqualToString:@"1"]) {
        text = _userAccout.name;
    }
    else{
        text = _userAccout.nickname;
    }
    
    if ((![textField.text isEqualToString:text]) && textField.text.length > 0) {
        _rightButton.selected = YES;
        _rightButton.userInteractionEnabled = YES;
    }
    else{
        _rightButton.selected = NO;
        _rightButton.userInteractionEnabled = NO;
    }
}

#pragma mark - Pravit method

@end
