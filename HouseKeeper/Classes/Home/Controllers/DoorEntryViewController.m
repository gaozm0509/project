//
//  DoorEntryViewController.m
//  HouseKeeper
//
//  Created by 高泽民 on 16/10/28.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "DoorEntryViewController.h"
#import "DoorEntryTableView.h"
#import "PayModel.h"

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
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //    self.hidesBottomBarWhenPushed = YES;
    
    UINavigationBar *navigationBarAppearance = [UINavigationBar appearance];
    NSDictionary *textAttributes = nil;
    textAttributes = @{
                       NSFontAttributeName: [UIFont boldSystemFontOfSize:kNavTitleFontSize],
                       NSForegroundColorAttributeName: [UIColor whiteColor],
                       };
    
    [navigationBarAppearance setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forBarMetrics:UIBarMetricsDefault];
    [navigationBarAppearance setTitleTextAttributes:textAttributes];
    [navigationBarAppearance setShadowImage:[UIImage imageWithColor:KMajorColor]];
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

- (void)netRequestCreatOrderWithModel:(DoorEntryModel *)model{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:model.id forKey:@"type"];
    StateModel *stateModel = [UsersManager stateModel];
    [params setValue:stateModel.id forKey:@"state_id"];
    [params setValue:model.price forKey:@"amount"];
    
    [kApi_orders_create httpRequestWithParams:params hudView:self.hudView networkMethod:Post andBlock:^(id data, NSError *error) {
        if (error) {
            [self showError:error];
            return ;
        }
        if ([data[@"code"] integerValue] == 1) {
            PayModel *orderModel = [[PayModel alloc] initWithDic:data[@"data"]];
            [self pushNewViewController:@"CreatOrderViewController" params:@{@"orderModel":orderModel,@"name":model.name}];
        }
    }];
    
}

#pragma mark - Event method

- (void)bottomButtonClick:(UIButton *)button{
    //点击下单按钮
    if(_tableView.selectRow == 1){
        [self netRequestCreatOrderWithModel:self.tableView.model1];
    }
    else{
        [self netRequestCreatOrderWithModel:self.tableView.model2];
    }
    
}

#pragma mark - Pravit method


@end
