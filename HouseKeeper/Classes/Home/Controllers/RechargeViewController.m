//
//  RechargeViewController.m
//  HouseKeeper
//
//  Created by 高泽民 on 16/10/31.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "RechargeViewController.h"
#import "RechargeTableView.h"

@interface RechargeViewController ()

@property (nonatomic ,strong)RechargeTableView *tableView;
@property (nonatomic, strong) UIButton *bottomButton;

@end

@implementation RechargeViewController

#pragma mark - Cycle life
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"充值";
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.bottomButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Getter and setter

- (RechargeTableView *)tableView{
    if (!_tableView) {
        _tableView = [[RechargeTableView alloc] initWithFrame:kViewFrame];
        _tableView.height = kScreen_Height - kNavHeight - 45;
    }
    return _tableView;
}

- (UIButton *)bottomButton{
    if (!_bottomButton) {
        _bottomButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _bottomButton.frame = CGRectMake(0, kScreen_Height - kNavHeight - 45, kScreen_Width, 45);
        [_bottomButton setTitle:@"下单" forState:UIControlStateNormal];
        [_bottomButton setTitleColor:KMajorColor forState:UIControlStateNormal];
        _bottomButton.backgroundColor = [UIColor whiteColor];
        _bottomButton.layer.borderColor = kBorderColor.CGColor;
        _bottomButton.layer.borderWidth = 0.5;
        _bottomButton.tag = 1001;
        [_bottomButton addTarget:self action:@selector(bottomButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bottomButton;
}

#pragma mark - Delegate



#pragma mark - Net request



#pragma mark - Event method

- (void)bottomButtonClick:(UIButton *)button{
    //充值按钮
    
}

#pragma mark - Pravit method

@end
