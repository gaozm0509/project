//
//  AddressManagementViewController.m
//  HouseKeeper
//
//  Created by 高泽民 on 16/7/16.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "AddressManagementViewController.h"
#import "AddressManagementTableView.h"
#import "BalanceViewController.h"


#define kAddButtonHeight 45

@interface AddressManagementViewController ()<AddressManagementTableViewDelegate>

@property (nonatomic, strong) AddressManagementTableView *tableView;
@property (nonatomic, strong) UIButton *addButton;

@end

@implementation AddressManagementViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"地址管理";
    [self.view addSubview:self.tableView];
//    [self.view addSubview:self.addButton];
    
    
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

- (AddressManagementTableView *)tableView{
    if (!_tableView) {
        _tableView = [[AddressManagementTableView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height - kNavHeight - 44)];
        _tableView.clickCell = self;
    }
    return _tableView;
}

- (UIButton *)addButton{
    if (!_addButton) {
        _addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _addButton.backgroundColor = [UIColor whiteColor];
        [_addButton setTitle:@"新增" forState:UIControlStateNormal];
        [_addButton setTitleColor:KMajorColor forState:UIControlStateNormal];
        _addButton.titleLabel.font = kFont17;
        _addButton.tag = 1001;
        [_addButton addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        _addButton.frame = CGRectMake(0, self.tableView.height, kScreen_Width, 44);
    }
    return _addButton;
}

#pragma mark - Delegate

- (void)cliclCellWithModel:(StateModel *)model{
    [self pushNewViewController:@"AssetAddaddressViewController" params:@{@"model":model,@"fromVC":@"AddressManagementViewController"}];
}

- (void)editStateWithModel:(StateModel *)model{
    [self pushNewViewController:@"AssetAddaddressViewController" params:@{@"model":model,@"isEdit":@"isEdit",@"fromVC":@"AddressManagementViewController"}];
}

#pragma mark - Net request

- (void)netRequest{
    [kApi_state httpRequestWithParams:nil hudView:self.hudView networkMethod:Post andBlock:^(id data, NSError *error) {
        if (error) {
            [self showError:error];
            return ;
        };
        if ([data[@"code"] integerValue] == 1) {
            StateModelDataModel *stateModelDataModel = [[StateModelDataModel alloc] initWithDic:data[@"data"]];
            self.tableView.stateModelDataModel = stateModelDataModel;
        }
    }];
}

#pragma mark - Event

- (void)click:(UIButton *)button{
    [self pushNewViewController:@"AssetAddaddressViewController" params:@{@"fromVC":@"AddressManagementViewController",@"isEdit":@"isEdit"}];
}

#pragma mark - Pravit method

@end
