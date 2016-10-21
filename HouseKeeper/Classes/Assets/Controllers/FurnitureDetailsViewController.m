//
//  FurnitureDetailsViewController.m
//  HouseKeeper
//
//  Created by 高泽民 on 16/10/14.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "FurnitureDetailsViewController.h"
#import "FurnitureDetailsTableView.h"
#import "FurnitureDetailsViewMaintenanceCycleSheetView.h"

@interface FurnitureDetailsViewController ()<BaseTableViewDelegate>

@property (nonatomic, strong) FurnitureDetailsTableView *tableView;

@property (nonatomic, strong) FurnitureModel *model;

@property (nonatomic, strong) UIButton *seviceButton;

@property (nonatomic, strong) FurnitureDetailsViewMaintenanceCycleSheetView *sheetView;

@end

@implementation FurnitureDetailsViewController

#pragma mark - Cycle life
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"名称";
    
    _model = self.receiveParams[@"model"];
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.seviceButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Getter and setter

- (FurnitureDetailsTableView *)tableView{
    if (!_tableView) {
        _tableView = [[FurnitureDetailsTableView alloc] initWithFrame:kViewFrame];
        [_tableView setHeight:kScreen_Height - kNavHeight - 45];
        _tableView.model = _model;
        _tableView.clickDeleagte = self;
    }
    return _tableView;
}

//提交按钮
- (UIButton *)seviceButton{
    if (!_seviceButton) {
        _seviceButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _seviceButton.frame = CGRectMake(0, kScreen_Height - 45 - kNavHeight, kScreen_Width, 45);
        [_seviceButton setTitle:@"服务" forState:UIControlStateNormal];
        [_seviceButton setTitleColor:KMajorColor forState:UIControlStateNormal];
        _seviceButton.titleLabel.font = kFont16;
        _seviceButton.backgroundColor = [UIColor whiteColor];
        [_seviceButton addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        _seviceButton.tag = 1002;
    }
    return _seviceButton;
}

//点击保养周期cell弹出的view
- (FurnitureDetailsViewMaintenanceCycleSheetView *)sheetView{
    if (!_sheetView) {
        _sheetView = [[FurnitureDetailsViewMaintenanceCycleSheetView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 180)];
        [_sheetView.savebutton addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        _sheetView.savebutton.tag = 2001;
        _sheetView.nameField.text = _model.schedule_period;
    }
    return _sheetView;
}

#pragma mark - Delegate

#pragma mark - BaseTableViewDelegate

- (void)BaseTableViewClickWithIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 2) {
        //我的发票
        
    }
    if (indexPath.section == 3) {
        //保养周期
        [self.sheetView show];
    }
}


#pragma mark - Net request

- (void)netRequest_setSchedule{
    NSMutableDictionary *params = [NSMutableDictionary new];
    [params setValue:_model.id forKey:@"furniture_id"];
    [params setValue:_sheetView.nameField.text forKey:@"schedule_period"];
    [kApi_furniture_setSchedule httpRequestWithParams:params networkMethod:Post andBlock:^(id data, NSError *error) {
        if (error) {
            [self showError:error];
            return ;
        }
        if ([data[@"code"] integerValue] == 1) {
            FurnitureModel *furnitureModel = [[FurnitureModel alloc]initWithDic:data[@"data"]];
            _model.schedule_period = furnitureModel.schedule_period;
            _model.schedule = furnitureModel.schedule;
            _model.schedule_description = furnitureModel.schedule_description;
            self.tableView.model = _model;
            [_sheetView hid];
        }
    }];
}

#pragma mark - Event method

- (void)click:(UIButton *)button{

    if (button.tag == 1002) {
        //服务
        [self pushNewViewController:@"AsssetServiceViewController" params:@{@"model":_model}];
    }
    
    if (button.tag == 2001) {
        //保养周期保存事件
        if (_sheetView.nameField.text.length == 0) {
            [self showHudTipStr:@"请输入保养周期"];
            return;
        }
        [self netRequest_setSchedule];
    }
}

#pragma mark - Pravit method

@end
