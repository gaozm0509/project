//
//  PersonalCenterViewController.m
//  HouseKeeper
//
//  Created by 高泽民 on 16/7/16.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "PersonalCenterViewController.h"
#import "PersonalCenterTableView.h"
#import "PsersonalInfoViewController.h"
#import "CouponModel.h"
#import "SecondContactsViewController.h"

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
//    [self.view addSubview:self.leftButton];
//    [self.view addSubview:self.rightButton];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.leftButton];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightButton];
    
    [self netRequest];
    [self netRequestCoupon];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Getter and setter

- (PersonalCenterTableView *)tableView{
    if (!_tableView) {
        _tableView = [[PersonalCenterTableView alloc]initWithFrame:self.view.bounds];
        _tableView.height = kScreen_Height - kNavHeight;
        _tableView.clcikDelegate = self;
        _tableView.isHeadOpen = YES;
        _tableView.isFootOpen = NO;
        
        WS(weakSelf);
        [_tableView setMorePage:^(int Page) {
            [weakSelf netRequestCoupon];
            [weakSelf netRequest];
        }];
    }
    return _tableView;
}

- (UIButton *)leftButton{
    if (!_leftButton) {
        _leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftButton.frame = CGRectMake(0, 0, 44, 44);
        [_leftButton setImage:[UIImage imageNamed:@"设置"] forState:UIControlStateNormal];
        _leftButton.tag = 1001;
        [_leftButton addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftButton;
}

- (UIButton *)rightButton{
    if (!_rightButton) {
        _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightButton.frame = CGRectMake(0, 0, 44, 44);
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
                WS(weakSelf);
                UserAccoutBlock block = ^(UserAccout *model){
                    weakSelf.tableView.model = model;
                };
                [self pushNewViewController:@"SecondContactsViewController" params:@{@"block":block}];
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
            [self pushNewViewController:@"BalanceViewController" params:@{@"balance":_tableView.model.balance}];
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
        case 4:{
        //点击头像
            WS(weakSelf);
            UserAccoutBlock userAccoutBlock = ^(UserAccout *userAccout){
                weakSelf.tableView.model = userAccout;
            };
            [self pushNewViewController:@"PsersonalInfoViewController" params:@{@"block":userAccoutBlock}];
        }
        default:
            break;
    }
}

#pragma mark - Net request

- (void)netRequest{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [kApi_member_info httpRequestWithParams:params hudView:self.hudView networkMethod:Post andBlock:^(id data, NSError *error) {
        
        [_tableView setIsMJStop:YES];
        
        if (error) {
            [self showError:error];
            return ;
        }
        if ([data[@"code"] integerValue] == 1) {
            UserAccout *model = [[UserAccout alloc] initWithDic:data[@"data"]];
            self.tableView.model = model;
            [self netRequestGetImage];
        }
    }];
}

//获取头像
- (void)netRequestGetImage{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:[UsersManager memberId] forKey:@"type_id"];
    [params setValue:@"head" forKey:@"type"];
    [kApi_member_image httpRequestWithParams:params hudView:nil networkMethod:Post andBlock:^(id data, NSError *error) {
        if (error) {
            [self showError:error];
            return ;
        }
        if ([data[@"code"] integerValue] == 1) {
            _tableView.model.avatar = data[@"data"][@"url"];
            [_tableView reloadData];
        }
    }];
}

- (void)netRequestCoupon{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:@"1" forKey:@"type"];
    [kApi_member_coupons httpRequestWithParams:params hudView:nil networkMethod:Post andBlock:^(id data, NSError *error) {
        [_tableView setIsMJStop:YES];
        if (error) {
            [self showError:error];
            return ;
        }
        if ([data[@"code"] integerValue] == 1) {
            CouponListModel *model = [[CouponListModel alloc] initWithDic:data];
            _tableView.model.couponNumbers = model.dataList.count;
            [_tableView reloadData];
        }
    }];
}

- (void)netRequestBlabce{

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
