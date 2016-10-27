//
//  PersonalCenterViewController.m
//  HouseKeeper
//
//  Created by 高泽民 on 16/7/16.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "PersonalCenterViewController.h"
#import "PersonalCenterTableView.h"

@interface PersonalCenterViewController ()<PersonalCenterTableViewDelegate>

@property (nonatomic, strong) PersonalCenterTableView *tableView;
@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UIButton *rightButton;

@end

@implementation PersonalCenterViewController

#pragma mark - Lefe cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.leftButton];
    [self.view addSubview:self.rightButton];
    
    [self netApiGet];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [self.navigationController setNavigationBarHidden:YES];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
//    [self.navigationController setNavigationBarHidden:NO];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Getter and setter

- (PersonalCenterTableView *)tableView{
    if (!_tableView) {
        _tableView = [[PersonalCenterTableView alloc]initWithFrame:self.view.bounds];
        _tableView.clcikDelegate = self;
    }
    return _tableView;
}

- (UIButton *)leftButton{
    if (!_leftButton) {
        _leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftButton.frame = CGRectMake(10, 12, 44, 44);
        [_leftButton setImage:[UIImage imageNamed:@"设置"] forState:UIControlStateNormal];
        _leftButton.tag = 1001;
        [_leftButton addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftButton;
}

- (UIButton *)rightButton{
    if (!_rightButton) {
        _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightButton.frame = CGRectMake(kScreen_Width - 10 - 44, 12, 44, 44);
        [_rightButton setImage:[UIImage imageNamed:@"我的资产"] forState:UIControlStateNormal];
        _rightButton.tag = 1002;
        [_rightButton addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightButton;
}

#pragma mark - Delegate

- (void)clickWithIndex:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 1:{
            if (indexPath.row == 0) {
                [self pushNewViewController:@"AddressManagementViewController"];
            }
            if (indexPath.row == 1) {
                [self pushNewViewController:@"InvoiceViewController"];
            }
            break;
        }
            
        default:
            break;
    }
}

//自定义的三个按钮
- (void)customClickWithIndex:(NSInteger)index{
    switch (index) {
        case 0:{
            //余额BalanceViewController
            [self pushNewViewController:@"BalanceViewController"];
            break;
        }
        case 1:{
            //优惠卷
            [self pushNewViewController:@"CouponViewController"];
            break;
        }
        case 2:{
            //积分
            [self pushNewViewController:@"IntegralViewController"];
            break;
        }
            
        default:
            break;
    }
}

#pragma mark - Net request

- (void)netApiGet{
//    [kApi_employee_sendVerificationCode httpRequestWithParams:[@{@"mobile":@"18036396675"} mutableCopy]  networkMethod:Post andBlock:^(id data, NSError *error) {
//        NSLog(@"+++%@++++",data);
//    }];
    
}

#pragma mark - Pravit method

- (void)click:(UIButton *)button{
    switch (button.tag) {
            //设置按钮
        case 1001:{
            [self pushNewViewController:@"SettingViewController"];
            break;
        }
            //我的资产
        case 1002:{
            
            break;
        }
        default:
            break;
    }
}

@end
