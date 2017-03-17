//
//  OrderDetailsTableView.m
//  HouseKeeper
//
//  Created by 高泽民 on 16/9/14.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "OrderDetailsTableView.h"


@interface OrderDetailsTableView()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation OrderDetailsTableView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.backgroundColor = [UIColor whiteColor];
        self.isFootOpen = NO;
        self.isHeadOpen = NO;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return self;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"OrderDetailsTableViewCell";
    OrderDetailsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[OrderDetailsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.orderType = _orderType;
    cell.isFirstRow = indexPath.row == 0;
    cell.isLastRow = indexPath.row == [self getTotalRowRow] - 1;
    [cell setTextWithIndex:indexPath.row];
    cell.layer.masksToBounds = YES;
    
    [tableView addLineforPlainCell:cell forRowAtIndexPath:indexPath withLeftSpace:25];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger totalRow = [self getTotalRowRow];
    return totalRow;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.orderType == OrderTypeCancle && indexPath.row == 2) {
        return 0;
    }
    return 55;
}

- (void)setOrderType:(OrderType)orderType{
    _orderType = orderType;
    [self reloadData];
}

- (NSInteger)getTotalRowRow{
    
    NSInteger totalRow = 0;
    switch (self.orderType) {
        case OrderTypeToBePaid:{
            totalRow = 1;
            break;
        }
        case OrderTypeCompletedPaid:{
            totalRow = 2;
            break;
        }
        case OrderTypeArrange:{
            totalRow = 2;
            break;
        }
        case OrderTypeServering:{
            totalRow = 7;
            break;
        }
        case OrderTypeCompletedAll:{
            totalRow = 9;
            break;
        }
        case OrderTypeCancle:{
            totalRow = 9;
            break;
        }
        default:
            break;
    }
    return totalRow;
}

@end
