//
//  InvoiceViewController.m
//  HouseKeeper
//
//  Created by 高泽民 on 16/8/12.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "InvoiceViewController.h"
#import "InvoiceTableView.h"

@interface InvoiceViewController ()

@property (nonatomic, strong) InvoiceTableView *tableView;

@end

@implementation InvoiceViewController

#pragma mark - Cycle life
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Getter and setter

- (InvoiceTableView *)tableView{
    if (!_tableView) {
        _tableView = [[InvoiceTableView alloc]initWithFrame:kViewFrame];
    }
    return _tableView;
}

#pragma mark - Delegate



#pragma mark - Net request



#pragma mark - Event method



#pragma mark - Pravit method

@end
