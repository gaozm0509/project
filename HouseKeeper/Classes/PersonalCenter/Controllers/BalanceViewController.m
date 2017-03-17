//
//  BalanceViewController.m
//  HouseKeeper
//
//  Created by 高泽民 on 16/7/19.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "BalanceViewController.h"
#import "BalanceView.h"

@interface BalanceViewController ()

@property (nonatomic, strong) BalanceView *balanceView;
@property (nonatomic, strong) UIButton *rightButton;

@end

@implementation BalanceViewController

#pragma mark - Life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"余额";
    [self.view addSubview:self.balanceView];
    self.balanceView.balanceLabel.text = [NSString stringWithFormat:@"%.2f",[self.receiveParams[@"balance"] floatValue]];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightButton];
    
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self netRequest];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Getter and setter

- (BalanceView *)balanceView {
    if (!_balanceView) {
        _balanceView = [[BalanceView alloc]initWithFrame:kViewFrame];
    }
    return _balanceView;
}

- (UIButton *)rightButton{
    if (!_rightButton) {
        _rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
        [_rightButton setTitle:@"充值" forState:UIControlStateNormal];
        [_rightButton setTitleColor:KMajorColor forState:UIControlStateNormal];
        _rightButton.titleLabel.font = kFont14;
        [_rightButton addTarget:self action:@selector(rightButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightButton;
}

#pragma mark - Delegate



#pragma mark - Net request

- (void)netRequest{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [kApi_member_balanceHistory httpRequestWithParams:params hudView:self.hudView networkMethod:Post andBlock:^(id data, NSError *error) {
        if (error) {
            [self showError:error];
            return ;
        }
        if ([data[@"code"] integerValue] == 1) {
            BalanceHistoryListModel *listModel = [[BalanceHistoryListModel alloc] initWithDic:data];
            self.balanceView.listModel = listModel;
        }
    }];
}

#pragma mark - Event

- (void)rightButtonClick{
    [self pushNewViewController:@"RechargeViewController"];
}

#pragma mark - Pravit method

@end
