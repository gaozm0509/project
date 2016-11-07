//
//  DoorEntryTableView.m
//  HouseKeeper
//
//  Created by 高泽民 on 16/10/28.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "DoorEntryTableView.h"


@interface DoorEntryTableView()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UIImageView *headImageView;

@property (nonatomic, strong) DoorEntryModel *model;


@end

@implementation DoorEntryTableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.dataSource = self;
        self.delegate = self;
        self.backgroundColor = kBackgroundColor;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableHeaderView = self.headImageView;
        self.selectRow = 1;
    }
    return self;
}

- (UIImageView *)headImageView{
    if (!_headImageView) {
        _headImageView = [[UIImageView alloc] initWithImage:Image(@"service_资产录入顶图")];
        _headImageView.frame = CGRectMake(0, 0, kScreen_Width, 150);
    }
    return _headImageView;
}

- (void)setModel1:(DoorEntryModel *)model1{
    _model1 = model1;
    if (_selectRow == 1) {
        _model = _model1;
    }
    else{
        _model = _model2;
    }
    [self reloadData];
}

- (void)setModel2:(DoorEntryModel *)model2{
    _model2 = model2;
    if (_selectRow == 1) {
        _model = _model1;
    }
    else{
        _model = _model2;
    }
    [self reloadData];
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        static NSString *cellId = @"cellId";
        DoorEntryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[DoorEntryTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        [tableView addLineforPlainCell:cell forRowAtIndexPath:indexPath withLeftSpace:10];
        
        if (indexPath.row == 0) {
            cell.contentLabel.text = [NSString stringWithFormat:@"%@元上门费",_model1.price];
            cell.titleLabel.text = @"上门资产录入";
            cell.selectButton.selected = self.selectRow == 1 ? YES : NO;
        }
        else{
            cell.contentLabel.text = [NSString stringWithFormat:@"%@元上门费",_model2.price];
            cell.titleLabel.text = @"深度资产录入";
            cell.selectButton.selected = self.selectRow == 2 ? YES : NO;
        }
        
        return cell;
    }
    if (indexPath.section == 1) {
        static NSString *cellId = @"cellId1";
        DoorEntryTableViewCell1 *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[DoorEntryTableViewCell1 alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        [tableView addLineforPlainCell:cell forRowAtIndexPath:indexPath withLeftSpace:10];
        cell.model = _model;
        return cell;
    }
    return nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 2;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 45;
    }
    if (indexPath.section == 1) {
        return 115;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return nil;
    }
    if (section == 1) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 10)];
        return view;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    }
    if (section == 1) {
        return 10;
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    _selectRow = _selectRow == 1 ? 2 : 1;
    _model = _selectRow == 1 ? _model1 : _model2;
    [tableView reloadData];
}


@end
