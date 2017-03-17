//
//  FurnitureDetailsTableView.m
//  HouseKeeper
//
//  Created by 高泽民 on 16/10/14.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "FurnitureDetailsTableView.h"

@interface FurnitureDetailsTableView()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation FurnitureDetailsTableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.dataSource = self;
        self.delegate = self;
        self.backgroundColor = kBackgroundColor;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return self;
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        static NSString *cellId = @"cellId";
        FurnitureDetailsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[FurnitureDetailsTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        cell.model = _model;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    
    if (indexPath.section == 1) {
        static NSString *cellId = @"cellId1";
        FurnitureDetailsTableViewCell1 *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[FurnitureDetailsTableViewCell1 alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        [tableView addLineforPlainCell:cell forRowAtIndexPath:indexPath withLeftSpace:10];
        
        NSString *text;
        
        if (indexPath.row == 0) {
            text = [NSString stringWithFormat:@"商品名称:%@",_model.name];
        }
        if (indexPath.row == 1) {
            text = [NSString stringWithFormat:@"商品品牌:%@",_model.brand];
        }
        if (indexPath.row == 2) {
            text = [NSString stringWithFormat:@"商品编号:%@",_model.serial];
        }
        if (indexPath.row == 3) {
            text = [NSString stringWithFormat:@"采购时间:%@",_model.purchase_date];
        }
        cell.nameLabel.text = text;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    if (indexPath.section == 2 || indexPath.section == 3) {
        static NSString *cellId = @"cellId2||3";
        FurnitureDetailsTableViewCell2 *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[FurnitureDetailsTableViewCell2 alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        
        if (indexPath.section == 2) {
            cell.titleLabel.text = @"我的发票";
            cell.rightLabel.text = nil;
        }
        else{
            cell.titleLabel.text = [NSString stringWithFormat:@"保养周期:%@天一次",_model.schedule_period];
            cell.rightLabel.text = @"修改";
        }
        
        [tableView addLineforPlainCell:cell forRowAtIndexPath:indexPath withLeftSpace:10];
        
        return cell;
    }
    return nil;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    if (section == 1) {
        return 4;
    }
    if (section == 2 || section == 3) {
        return 1;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 80;
    }
    if (indexPath.section == 1) {
        return 46;
    }
    if (indexPath.section == 2 || indexPath.section == 3) {
        return 46;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 1 || section == 2 || section == 3) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width , 10)];
        view.backgroundColor = [UIColor clearColor];
        return view;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 1 || section == 2 || section == 3) {
        return 10;
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 2 || indexPath.section == 3) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        [self.clickDeleagte BaseTableViewClickWithIndexPath:indexPath];
    }
}

- (void)setModel:(FurnitureModel *)model{
    _model = model;
    [self reloadData];
}

@end
