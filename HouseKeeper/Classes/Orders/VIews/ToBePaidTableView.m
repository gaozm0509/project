//
//  ToBePaidTableView.m
//  HouseKeeper
//
//  Created by 高泽民 on 16/7/30.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "ToBePaidTableView.h"
#import "StateModel.h"

@interface ToBePaidTableView()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) MyOrderListModel *listModel;


@end

@implementation ToBePaidTableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.dataSource = self;
        self.delegate = self;
        self.backgroundColor = kBackgroundColor;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;

        _listModel = [[MyOrderListModel alloc] initWithDic:@{}];
        
        [self netRequest];
        
        WS(weakSelf);
        [self setMorePage:^(int Page) {
            [weakSelf netRequest];
        }];
    }
    return self;
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"cellId";
    ToBePaidTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[ToBePaidTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        [tableView addLineforPlainCell:cell forRowAtIndexPath:indexPath withLeftSpace:0];
    }
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
    return [ToBePaidTableViewCell getCellHieghtOrderType:OrderTypeToBePaid];
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
    [self.clickDelegate ToBePaidClickCellButton];
}


- (void)setOrderType:(OrderType)orderType{
    _orderType = orderType;
    [self netRequest];
}

#pragma mark - Net request

- (void)netRequest{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    StateModel *stateModel = [UsersManager stateModel];
    [params setValue:stateModel.id forKey:@"address_id"];
    [params setValue:@(_orderType) forKey:@"status"];
    [params setValue:@(self.Page) forKey:@"page"];
    [kApi_orders httpRequestWithParams:params networkMethod:Post andBlock:^(id data, NSError *error) {
        self.isMJStop = YES;
        if (error) {
            [self showError:error];
            return ;
        }
        if ([data[@"code"] integerValue] == 1) {
           MyOrderListModel *model = [[MyOrderListModel alloc] initWithDic:data[@"data"]];
            
            //等于1的时候认为是刷新，清空所有数据
            if (self.Page == 1) {
                [_listModel.orderList removeAllObjects];
            }
            [_listModel.orderList addObjectsFromArray:model.orderList];
            _listModel.pageModel = model.pageModel;
            
            //当前访问的数据量等于规定的每页的数据，则认为是不是最后一页，可加载
            self.isFootOpen = model.orderList.count == _listModel.pageModel.per_page.integerValue;
            [self reloadData];
        }
    }];
}

@end
