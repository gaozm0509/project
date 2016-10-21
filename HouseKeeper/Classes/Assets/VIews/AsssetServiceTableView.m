//
//  AsssetServiceTableView.m
//  HouseKeeper
//
//  Created by 高泽民 on 16/10/17.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "AsssetServiceTableView.h"


@interface AsssetServiceTableView()<UITableViewDelegate,UITableViewDataSource,AssetServiceTableViewCellDelegate>

@end

@implementation AsssetServiceTableView

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

- (void)setFurnitureModel:(FurnitureModel *)furnitureModel{
    _furnitureModel = furnitureModel;
    [self reloadData];
}

- (void)setCity:(NSString *)city{
    _city = city;
    [self reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        
        static NSString *cellId = @"cellId";
        AssetServiceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[AssetServiceTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [tableView addLineforPlainCell:cell forRowAtIndexPath:indexPath withLeftSpace:0];
        
        cell.phoneLabel.text = [NSString stringWithFormat:@"手机号：%@",kmobile];
        cell.loctionLabel.text = _city;
        return cell;
        
    }
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            static NSString *cellId = @"FurnitureDetailsTableViewCell1";
            FurnitureDetailsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
            if (!cell) {
                cell = [[FurnitureDetailsTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            }
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [tableView addLineforPlainCell:cell forRowAtIndexPath:indexPath withLeftSpace:0];
            
            cell.model = _furnitureModel;
            
            return cell;
        }
        
        static NSString *cellId = @"cellId1";
        AssetServiceTableViewCell1 *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[AssetServiceTableViewCell1 alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.delegate = self;
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [tableView addLineforPlainCell:cell forRowAtIndexPath:indexPath withLeftSpace:0];
        
        
        return cell;
        
    }
    
    if (indexPath.section == 2) {
        static NSString *cellId = @"FurnitureDetailsTableViewCell2";
        FurnitureDetailsTableViewCell2 *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[FurnitureDetailsTableViewCell2 alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        
        [tableView addLineforPlainCell:cell forRowAtIndexPath:indexPath withLeftSpace:0];
        
        cell.titleLabel.text = [NSString stringWithFormat:@"保养周期:%@天",_furnitureModel.schedule_period];
        
        return cell;
    }
    
    return nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 1) {
        return 2;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0 ){
        return 60;
    }
    if (indexPath.section == 2) {
        return 45;
    }
    else{
        if (indexPath.row == 0) {
            return 80;
        }
        return 45;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 10)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 2) {
        [self.clickDelegate schedule_periodCellClick];
    }
    
}

#pragma mark - Delegate

- (void)chosenMaintenanceOrWarrantyButton:(BOOL)isMaintenance{
    [self.clickDelegate chosenMaintenanceOrWarrantyButton:isMaintenance];
}

@end
