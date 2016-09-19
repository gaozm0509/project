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

@property (nonatomic, strong) UIButton *payButton;

@end

@implementation PayViewController

#pragma mark - Cycle life
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"支付";
    
    [self setupSubViews];

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

- (UIButton *)payButton{
    if (!_payButton) {
        _payButton = [UIButton buttonWithType: UIButtonTypeCustom];
        _payButton.backgroundColor = [UIColor whiteColor];
        [_payButton setTitle:@"确认支付" forState:UIControlStateNormal];
        [_payButton setTitleColor:Color_Hex(@"37a037") forState:UIControlStateNormal];
        _payButton.layer.shadowOffset = CGSizeMake(1, 1);
        _payButton.layer.shadowColor = [UIColor blackColor].CGColor;
        _payButton.layer.shadowOpacity = 0.6;
        _payButton.tag = 1001;
        [_payButton addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _payButton;
}

#pragma mark - Delegate



#pragma mark - Net request



#pragma mark - Event method

//支付
- (void)click:(UIButton *)button{
    if (button.tag == 1001) {
        
    }
}

#pragma mark - Pravit method

- (void)setupSubViews{
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.payButton];
    
    WS(weakSelf);
    [_payButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.view.mas_bottom);
        make.left.equalTo(weakSelf.view);
        make.right.equalTo(weakSelf.view.mas_right);
        make.height.offset(49);
    }];
}

@end
