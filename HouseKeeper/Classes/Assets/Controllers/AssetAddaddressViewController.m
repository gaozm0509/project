//
//  AssetAddaddressViewController.m
//  HouseKeeper
//
//  Created by 高泽民 on 16/10/10.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "AssetAddaddressViewController.h"
#import "TabBarViewController.h"


#define kTextFieldHeight 46

@interface AssetAddaddressViewController ()

@property (nonatomic, strong) UITextField *estatesField;
@property (nonatomic, strong) UITextField *houseStyleField;
@property (nonatomic, strong) UITextField *forestsField;
@property (nonatomic, strong) UITextField *addressField;

@property (nonatomic, strong) UIButton *submitButton;
@property (nonatomic, strong) StateModel *stateModel;

@property (nonatomic, assign) BOOL isEdit;

@end

@implementation AssetAddaddressViewController

#pragma mark - Cycle life
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.stateModel = self.receiveParams[@"model"];
    if ([self.receiveParams[@"isEdit"] length] > 0) {
        self.isEdit = YES;
    }
    
    self.title = self.isEdit ? @"编辑地址" : @"地址";
    
    [self setupSubViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Getter and setter

- (UITextField *)estatesField{
    if (!_estatesField) {
        _estatesField = [self nomarlTextFieldWithPlaceholder:@"请输入小区物业名称" leftViewTitle:@"物业名称"];
        _estatesField.text = self.stateModel.residential;
        _estatesField.userInteractionEnabled = _isEdit;
    }
    return _estatesField;
}

- (UITextField *)houseStyleField{
    if (!_houseStyleField) {
        _houseStyleField = [self nomarlTextFieldWithPlaceholder:@"如：三房两厅两卫" leftViewTitle:@"房屋描述"];
        _houseStyleField.text = self.stateModel.layout;
        _houseStyleField.userInteractionEnabled = _isEdit;
    }
    return _houseStyleField;
}

- (UITextField *)forestsField{
    if (!_forestsField) {
        _forestsField = [self nomarlTextFieldWithPlaceholder:@"单位（平方米）" leftViewTitle:@"房屋面积"];
        _forestsField.keyboardType = UIKeyboardTypeDecimalPad;
        _forestsField.text = self.stateModel.area;
        _forestsField.userInteractionEnabled = _isEdit;
    }
    return _forestsField;
}

- (UITextField *)addressField{
    if (!_addressField) {
        _addressField = [self nomarlTextFieldWithPlaceholder:@"请输入房屋地址（必填）" leftViewTitle:@"房屋地址"];
        _addressField.text = self.stateModel.address;
        _addressField.userInteractionEnabled = _isEdit;
    }
    return _addressField;
}

- (UIButton *)submitButton{
    if (!_submitButton) {
        _submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_submitButton setTitle:@"确定" forState:UIControlStateNormal];
        [_submitButton setTitleColor:KMajorColor forState:UIControlStateNormal];
        _submitButton.titleLabel.font = kFont16;
        [_submitButton addTarget:self action:@selector(sumbit) forControlEvents:UIControlEventTouchUpInside];
        _submitButton.backgroundColor = [UIColor whiteColor];
        _submitButton.hidden = !_isEdit;
    }
    return _submitButton;
}

#pragma mark - Delegate



#pragma mark - Net request

- (void)netRequest{
    NSMutableDictionary *params = [NSMutableDictionary new];
    
    [params setValue:_estatesField.text forKey:@"residential"];
    [params setValue:_houseStyleField.text forKey:@"layout"];
    [params setValue:_forestsField.text forKey:@"area"];
    [params setValue:_addressField.text forKey:@"address"];
    [params setValue:@"1" forKey:@"rights"];
    [params setValue:_stateModel.id forKey:@"state_id"];
    
    NSString *api = self.stateModel.id.length > 0 ? kApi_state_update : kApi_state_create;
    
    [api httpRequestWithParams:params networkMethod:Post andBlock:^(id data, NSError *error) {
        if (error) {
            [self showError:error];
        }
        if ([data[@"code"] integerValue] == 1) {
            if ([self.receiveParams[@"fromVC"] isEqualToString:@"AddressManagementViewController"]) {
                [self.navigationController popViewControllerAnimated:YES];
            }
            else{
                UIWindow * window = [[UIApplication sharedApplication].delegate window];
                window.rootViewController = [TabBarViewController new];
            }
            
            StateModel *stateModel = [[StateModel alloc] initWithDic:data[@"data"]];
            [UsersManager saveStateModel:stateModel];
        }
    }];
}

#pragma mark - Event method

/*
 *提交
 */
- (void)sumbit{
    if (_addressField.text.length == 0) {
        [self showHudTipStr:@"请填写房屋地址"];
        return;
    }
    [self netRequest];
}


#pragma mark - Pravit method

- (UITextField *)nomarlTextFieldWithPlaceholder:(NSString *)placeholder leftViewTitle:(NSString *)leftViewTitle{
    
    UITextField *textField = [[UITextField alloc]init];
    textField.placeholder = placeholder;
    textField.textColor = [UIColor blackColor];
    textField.font = kFont14;
    textField.leftViewMode = UITextFieldViewModeAlways;
    textField.backgroundColor = [UIColor whiteColor];
    
    UILabel *leftView = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, kTextFieldHeight)];
    leftView.text = leftViewTitle;
    leftView.font = kFont14;
    leftView.textColor = [UIColor blackColor];
    leftView.textAlignment = NSTextAlignmentCenter;
    
    textField.leftView = leftView;
    
    return textField;
}


- (void)setupSubViews{
    [self.view addSubview:self.estatesField];
    [self.view addSubview:self.houseStyleField];
    [self.view addSubview:self.forestsField];
    [self.view addSubview:self.addressField];
    [self.view addSubview:self.submitButton];
    
    WS(weakSelf);
    [_estatesField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view);
        make.right.equalTo(weakSelf.view.mas_right);
        make.height.offset(kTextFieldHeight);
        make.top.equalTo(weakSelf.view).offset(10);
    }];
    [_houseStyleField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view);
        make.right.equalTo(weakSelf.view.mas_right);
        make.height.offset(kTextFieldHeight);
        make.top.equalTo(weakSelf.estatesField.mas_bottom).offset(0.5);
    }];
    [_forestsField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view);
        make.right.equalTo(weakSelf.view.mas_right);
        make.height.offset(kTextFieldHeight);
        make.top.equalTo(weakSelf.houseStyleField.mas_bottom).offset(0.5);
    }];
    [_addressField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view);
        make.right.equalTo(weakSelf.view.mas_right);
        make.height.offset(kTextFieldHeight);
        make.top.equalTo(weakSelf.forestsField.mas_bottom).offset(0.5);
    }];
    [_submitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.view.mas_bottom);
        make.left.equalTo(weakSelf.view);
        make.right.equalTo(weakSelf.view.mas_right);
        make.height.offset(kTextFieldHeight);
    }];
}


@end
