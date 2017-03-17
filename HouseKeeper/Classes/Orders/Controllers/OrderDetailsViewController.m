//
//  OrderDetailsViewController.m
//  HouseKeeper
//
//  Created by 高泽民 on 16/9/14.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "OrderDetailsViewController.h"
#import "OrderDetailsTableView.h"

@interface OrderDetailsViewController ()

@property (nonatomic, assign) OrderType orderType;
@property (nonatomic, strong) OrderDetailsTableView *tableView;

@end

@implementation OrderDetailsViewController

#pragma mark - Cycle life
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"订单详情";
    
    self.orderType = [self.receiveParams[@"orderType"] integerValue];
    
    [self.view addSubview:self.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Getter and setter

- (OrderDetailsTableView *)tableView{
    if (!_tableView) {
        _tableView = [[OrderDetailsTableView alloc] initWithFrame:kViewFrame];
        _tableView.orderType = self.orderType;
    }
    return _tableView;
}

#pragma mark - Delegate



#pragma mark - Net request


#pragma mark - Event method



#pragma mark - Pravit method

@end
