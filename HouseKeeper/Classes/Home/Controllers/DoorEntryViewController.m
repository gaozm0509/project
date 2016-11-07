//
//  DoorEntryViewController.m
//  HouseKeeper
//
//  Created by 高泽民 on 16/10/28.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "DoorEntryViewController.h"
#import "DoorEntryTableView.h"

@interface DoorEntryViewController ()

@property (nonatomic, strong) DoorEntryTableView *tableView;
@property (nonatomic, strong) UIButton *bottomButton;
@property (nonatomic, strong) NSString *priceId;
@property (nonatomic, strong) DoorEntryModel *model;

@end

@implementation DoorEntryViewController

#pragma mark - Cycle life
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"上门录入";
    
    _priceId = self.receiveParams[@"priceId"];
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.bottomButton];

    [self netRequest];
    [self netRequest1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Getter and setter

- (DoorEntryTableView *)tableView{
    if (!_tableView) {
        _tableView = [[DoorEntryTableView alloc] initWithFrame:kViewFrame];
        _tableView.height = kScreen_Height - kNavHeight - 45;
        _tableView.selectRow = [_priceId isEqualToString:@"1"] ? 1 : 2;
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

- (void)netRequest{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:@(1) forKey:@"price_id"];
    [kApi_orders_getPrice httpRequestWithParams:params networkMethod:Post andBlock:^(id data, NSError *error) {
        if (error) {
            [self showError:error];
            return ;
        }
        if ([data[@"code"] integerValue] == 1) {
            _tableView.model1 = [[DoorEntryModel alloc] initWithDic:data[@"data"]];
            
        }
    }];
}

- (void)netRequest1{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:@(2) forKey:@"price_id"];
    [kApi_orders_getPrice httpRequestWithParams:params networkMethod:Post andBlock:^(id data, NSError *error) {
        if (error) {
            [self showError:error];
            return ;
        }
        if ([data[@"code"] integerValue] == 1) {
            _tableView.model2 = [[DoorEntryModel alloc] initWithDic:data[@"data"]];
            
        }
    }];
}

#pragma mark - Event method

- (void)bottomButtonClick:(UIButton *)button{
//点击下单按钮
    
}

#pragma mark - Pravit method


@end
