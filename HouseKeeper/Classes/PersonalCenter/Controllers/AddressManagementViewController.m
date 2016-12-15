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
//    WS(weakSelf);
//    [_addButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.equalTo(weakSelf.view.mas_bottom);
//        make.left.equalTo(weakSelf.view);
//        make.right.equalTo(weakSelf.view.mas_right);
//        make.height.offset(kAddButtonHeight);
//    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Getter and setter

- (AddressManagementTableView *)tableView{
    if (!_tableView) {
        _tableView = [[AddressManagementTableView alloc]initWithFrame:kViewFrame];
        _tableView.clickCell = self;
    }
    return _tableView;
}

- (UIButton *)addButton{
    if (!_addButton) {
        _addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _addButton.backgroundColor = [UIColor whiteColor];
        _addButton.layer.shadowColor = [UIColor blackColor].CGColor;
        _addButton.layer.shadowOffset = CGSizeMake(1, 1);
        _addButton.layer.shadowOpacity = 0.5;
        [_addButton setTitle:@"新增" forState:UIControlStateNormal];
        [_addButton setTitleColor:KMajorColor forState:UIControlStateNormal];
        _addButton.titleLabel.font = kFont17;
        _addButton.tag = 1001;
        [_addButton addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addButton;
}

#pragma mark - Delegate

- (void)cliclCellWithIndexPath:(NSIndexPath *)indexPath{
    [self pushNewViewController:@"AssetAddaddressViewController" params:@{}];
}

#pragma mark - Net request


#pragma mark - Event

- (void)click:(UIButton *)button{

}

#pragma mark - Pravit method

@end
