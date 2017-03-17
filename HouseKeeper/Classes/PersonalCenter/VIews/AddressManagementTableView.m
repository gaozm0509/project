//
//  AddressManagementTableView.m
//  HouseKeeper
//
//  Created by 高泽民 on 16/7/16.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "AddressManagementTableView.h"
#import "AddressManagementCell.h"

@interface AddressManagementTableView()<UITableViewDelegate,UITableViewDataSource,AddressManagementCellDelegate>{}

@end
@implementation AddressManagementTableView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

#pragma mark - Delegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"AddressManagementCell";
    AddressManagementCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[AddressManagementCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        [tableView addLineforPlainCell:cell forRowAtIndexPath:indexPath withLeftSpace:kMarginLeft];
        cell.delegate = self;
    }
    cell.stateModel = _stateModelDataModel.StateModelList[indexPath.row];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _stateModelDataModel.StateModelList.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kMarginTop + kNameHeight + kMarginTop + kAdreeHeight + kMarginTop;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    StateModel * model = _stateModelDataModel.StateModelList[indexPath.row];
    [self.clickCell cliclCellWithModel:model];
}

- (void)setStateModelDataModel:(StateModelDataModel *)stateModelDataModel{
    _stateModelDataModel = stateModelDataModel;
    [self reloadData];
}

- (void)editStateWithModel:(StateModel *)model{
    [self.clickCell editStateWithModel:model];
}

@end
