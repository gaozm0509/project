//
//  LifeSerViceListViewController.m
//  HouseKeeper
//
//  Created by 高泽民 on 16/11/24.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "LifeSerViceListViewController.h"
#import "LifeServiceTableView.h"


@interface LifeSerViceListViewController ()<BaseTableViewDelegate>

@property (nonatomic, strong) NSString *type;//生活类型的type 1 - 8
@property (nonatomic, strong) LifeServiceTableView *tableView;
@property (nonatomic, assign) BOOL isDetailViewController;//列表页面和详情页面公用一个页面，YES表示详情页

@property (nonatomic, strong) LifeServiceListModel *detailModel;



@end

@implementation LifeSerViceListViewController

#pragma mark - Cycle life
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"生活服务";
    
    self.detailModel = self.receiveParams[@"detailModel"];
    if (self.detailModel) {
        self.isDetailViewController = YES;
    }
    
    
    [self.view addSubview:self.tableView];
    
    if (!_isDetailViewController) {
        self.type = self.receiveParams[@"type"];
        [self netRequest];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Getter and setter


- (LifeServiceTableView *)tableView{
    if (!_tableView) {
        _tableView = [[LifeServiceTableView alloc] initWithFrame:kViewFrame];
        _tableView.isFootOpen = NO;
        _tableView.clickDelegate = self;
       
        if (_isDetailViewController) {
            LifeServiceListDataModel *listModel = [[LifeServiceListDataModel alloc] initWithDic:@{}];
            listModel.dataList = [@[self.detailModel] mutableCopy];
            listModel.isDetailViewController = YES;
            _tableView.listModel = listModel;
            _tableView.isHeadOpen = NO;
        }
        else{
            WS(weakSelf);
            [_tableView setMorePage:^(int Page) {
                [weakSelf netRequest];
            }];
            _tableView.isHeadOpen = YES;
        }
    }
    return _tableView;
}

#pragma mark - Delegate

#pragma mark BaseTableViewDelegate

//点击cell事件
- (void)BaseTableViewClickWithModel:(BaseModel *)baseModel{
    [self pushNewViewController:@"LifeSerViceListViewController" params:@{@"detailModel":baseModel}];
}

#pragma mark - Net request

- (void)netRequest{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:self.type forKey:@"advertisement_type_id"];
    [kApi_member_advertisements httpRequestWithParams:params hudView:self.hudView networkMethod:Post andBlock:^(id data, NSError *error) {
        self.tableView.isMJStop = YES;
        if (error) {
            [self showError:error];
            return ;
        }
        if ([data[@"code"] integerValue] == 1) {
            LifeServiceListDataModel *listData = [[LifeServiceListDataModel alloc] initWithDic:data];
            self.tableView.listModel = listData;
        }
    }];
}

#pragma mark - Event method


#pragma mark - Pravit method

@end
