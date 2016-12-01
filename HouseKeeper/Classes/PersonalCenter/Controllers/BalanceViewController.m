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

@end

@implementation BalanceViewController

#pragma mark - Life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"余额";
    [self.view addSubview:self.balanceView];
    self.balanceView.balanceLabel.text = [NSString stringWithFormat:@"%.2f",[self.receiveParams[@"balance"] floatValue]];
    
    [self netRequest];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Getter and setter

- (BalanceView *)balanceView {
    if (!_balanceView) {
        _balanceView = [[BalanceView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, self.view.bounds.size.height)];
    }
    return _balanceView;
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


#pragma mark - Pravit method

@end
