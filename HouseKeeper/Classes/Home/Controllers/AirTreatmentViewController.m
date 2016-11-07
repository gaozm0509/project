//
//  AirTreatmentViewController.m
//  HouseKeeper
//
//  Created by 高泽民 on 16/11/1.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "AirTreatmentViewController.h"
#import "AirTreatmentTableView.h"


#define kBottomHeight 45

@interface AirTreatmentViewController ()

@property(nonatomic, strong) AirTreatmentTableView *tableView;
@property (nonatomic, strong) UIButton *bottomButton;
@property (nonatomic, strong) DoorEntryModel *model;

@end

@implementation AirTreatmentViewController

#pragma mark - Cycle life
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"空气治理";
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.bottomButton];
    
    [self netRequest];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Getter and setter

- (AirTreatmentTableView *)tableView{
    if (!_tableView) {
        _tableView = [[AirTreatmentTableView alloc] initWithFrame:kViewFrame];
        _tableView.height = kScreen_Height - kNavHeight - kBottomHeight;
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
    [params setValue:@"5" forKey:@"price_id"];
    [kApi_orders_getPrice httpRequestWithParams:params networkMethod:Post andBlock:^(id data, NSError *error) {
        if (error) {
            [self showError:error];
            return ;
        }
        if ([data[@"code"] integerValue] == 1) {
            _model = [[DoorEntryModel alloc] initWithDic:data[@"data"]];
            _tableView.model = _model;
        }
    }];
}

#pragma mark - Event method

- (void)bottomButtonClick:(UIButton *)button{
    //点击下单按钮
    
}

#pragma mark - Pravit method

@end
