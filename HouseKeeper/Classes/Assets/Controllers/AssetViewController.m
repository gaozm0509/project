//
//  AssetViewController.m
//  HouseKeeper
//
//  Created by 高泽民 on 16/7/16.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "AssetViewController.h"
#import "AssetTableView.h"

@interface AssetViewController ()<AssetTableViewDelegate>

@property (nonatomic, strong) AssetTableView *tableView;

@end

@implementation AssetViewController

#pragma mark - Lefe cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的资产";
    [self.view addSubview:self.tableView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Getter and setter

- (AssetTableView *)tableView{
    if (!_tableView) {
        _tableView = [[AssetTableView alloc]initWithFrame:kViewFrame];
        _tableView.clickDelegate = self;
    }
    return _tableView;
}

#pragma mark - Delegate

#pragma mark AssetTableViewDelegate

//前去采集
- (void)assetCollection{

}

//更换
- (void)assetChange{

}


#pragma mark - Net request



#pragma mark - Event



#pragma mark - Pravit method




@end
