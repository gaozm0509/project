//
//  PsersonalInfoViewController.m
//  HouseKeeper
//
//  Created by 高泽民 on 16/11/7.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "PsersonalInfoViewController.h"
#import "PsersonalInfoTableView.h"

@interface PsersonalInfoViewController ()

@property (nonatomic, strong) PsersonalInfoTableView *tableView;

@end

@implementation PsersonalInfoViewController

#pragma mark - Cycle life
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人信息";
    
    [self.view addSubview:self.tableView];
    
    [self netRequest];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Getter and setter

- (PsersonalInfoTableView *)tableView{
    if (!_tableView) {
        _tableView = [[PsersonalInfoTableView alloc] initWithFrame:kViewFrame];
    }
    return _tableView;
}

#pragma mark - Delegate



#pragma mark - Net request

- (void)netRequest{
    [kApi_member_info httpRequestWithParams:nil networkMethod:Post andBlock:^(id data, NSError *error) {
        if (error) {
            [self showError:error];
            return ;
        }
        if ([data[@"code"] integerValue] == 1) {
            UserAccout *userAccout = [[UserAccout alloc] initWithDic:data[@"data"]];
            _tableView.userAccout = userAccout;
        }
    }];
}

#pragma mark - Event method



#pragma mark - Pravit method

@end
