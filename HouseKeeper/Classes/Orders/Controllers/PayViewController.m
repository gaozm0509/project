//
//  PayViewController.m
//  HouseKeeper
//
//  Created by 高泽民 on 16/8/15.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "PayViewController.h"
#import "PayTableView.h"

@interface PayViewController ()

@property (nonatomic, strong) PayTableView *tableView;

@end

@implementation PayViewController

#pragma mark - Cycle life
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Getter and setter

- (PayTableView *)tableView{
    if (!_tableView) {
        _tableView = [[PayTableView alloc]initWithFrame:kViewFrame];
    }
    return _tableView;
}

#pragma mark - Delegate



#pragma mark - Net request



#pragma mark - Event method



#pragma mark - Pravit method

@end
