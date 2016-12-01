//
//  ToBePaidTableView.m
//  HouseKeeper
//
//  Created by 高泽民 on 16/7/30.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "ToBePaidTableView.h"
#import "StateModel.h"

@interface ToBePaidTableView()<UITableViewDataSource,UITableViewDelegate,ToBePaidTableViewCellDelegate>

@property (nonatomic, strong) MyOrderListModel *listModel;



@end

@implementation ToBePaidTableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _listModel = [[MyOrderListModel alloc] initWithDic:@{}];
        
        [self addSubview:self.tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self);
            make.bottom.equalTo(self.mas_bottom);
            make.width.and.height.equalTo(self);
        }];
        
        [self netRequest];
    }
    return self;
}

- (BaseTableView *)tableView{
    if (!_tableView) {
        _tableView = [[BaseTableView alloc] init];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = kBackgroundColor;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.isHeadOpen = YES;
        
        WS(weakSelf);
        [_tableView setMorePage:^(int Page) {
            [weakSelf netRequest];
        }];
    }
    return _tableView;
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"cellId";
    ToBePaidTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[ToBePaidTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.delegate = self;
    }
    [tableView addLineforPlainCell:cell forRowAtIndexPath:indexPath withLeftSpace:0];
    cell.orderType = _orderType;
    cell.orderModel = [_listModel.orderList objectAtIndex:indexPath.section];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _listModel.orderList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [ToBePaidTableViewCell getCellHieghtOrderType:_orderType];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    }
    return 10;
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section{
    view.tintColor = [UIColor clearColor];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.clickDelegate ToBePaidClickCellButton];
}


#pragma mark  ToBePaidTableViewCellDelegate

- (void)cancelPayWithModel:(MyOrderModel *)model{
    [self netApiCancelOrderWithMyOrderModel:model];
    
}

- (void)payWithModel:(MyOrderModel *)model{
    if ([self.clickDelegate respondsToSelector:@selector(payWithModel:)]) {
        [self.clickDelegate payWithModel:model];
    }
}

- (void)setOrderType:(OrderType)orderType{
    _orderType = orderType;
    [self netRequest];
}



#pragma mark - Net request

- (void)netApiCancelOrderWithMyOrderModel:(MyOrderModel *)model{
    NSMutableDictionary *params = [NSMutableDictionary new];
    [params setValue:model.id forKey:@"order_id"];
    [params setValue:model.coupon_id forKey:@"coupon_id"];
    [MBProgressHUD showHUDAddedTo:self animated:YES];
    [kApi_orders_cancel httpRequestWithParams:params networkMethod:Post isShowHud:NO andBlock:^(id data, NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self animated:YES];
        if (error) {
            [self showError:error];
            return ;
        }
        if ([data[@"code"] integerValue] == 1) {
            if ([_listModel.orderList containsObject:model]) {
                [_listModel.orderList removeObject:model];
                [self.tableView reloadData];
            }
        }
    }];
}

- (void)netRequest{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    StateModel *stateModel = [UsersManager stateModel];
    [params setValue:stateModel.id forKey:@"address_id"];
    [params setValue:@(_orderType) forKey:@"status"];
    [params setValue:@(self.tableView.Page) forKey:@"page"];
    
    [MBProgressHUD showHUDAddedTo:self animated:YES];
    [kApi_orders httpRequestWithParams:params networkMethod:Post isShowHud:NO andBlock:^(id data, NSError *error) {
        
        [MBProgressHUD hideAllHUDsForView:self animated:YES];
        
        self.tableView.isMJStop= YES;
        if (error) {
            [self showError:error];
            return ;
        }
        if ([data[@"code"] integerValue] == 1) {
           MyOrderListModel *model = [[MyOrderListModel alloc] initWithDic:data[@"data"]];
            
            //等于1的时候认为是刷新，清空所有数据
            if (self.tableView.Page == 1) {
                [_listModel.orderList removeAllObjects];
            }
            [_listModel.orderList addObjectsFromArray:model.orderList];
            _listModel.pageModel = model.pageModel;
            
            //当前访问的数据量等于规定的每页的数据，则认为是不是最后一页，可加载
            self.tableView.isFootOpen = model.orderList.count == _listModel.pageModel.per_page.integerValue;
            [self.tableView reloadData];
        }
    }];
}

@end
