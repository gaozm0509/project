//
//  AssetTableView.m
//  HouseKeeper
//
//  Created by gzm on 16/9/11.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "AssetTableView.h"

#define kHeadCellHieght 80

@interface AssetTableView()<UITableViewDataSource,UITableViewDelegate,AssetTableHeadViewCellDelegate>

@end

@implementation AssetTableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.dataSource = self;
        self.delegate = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

#pragma mark - Getter

#pragma mark - Setter

- (void)setModel:(StateModel *)model{
    _model = model;
    [self reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
}

- (void)setRoomClassModel:(RoomClassModel *)roomClassModel{
    _roomClassModel = roomClassModel;
    [self reloadData];
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        static NSString *cellId = @"headCellId";
        AssetTableHeadViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[AssetTableHeadViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.delegate = self;
        }
        cell.model = _model;
        return cell;
    }
    if (indexPath.row == 0) {
        static NSString *cellId = @"firstCellId";
        AssetTableViewFirstCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[AssetTableViewFirstCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [tableView addLineforPlainCell:cell forRowAtIndexPath:indexPath withLeftSpace:10];
        
        cell.roomListModel = _roomClassModel.roomClasses[indexPath.section - 1];
        return cell;
    }
    static NSString *cellId = @"cellId";
    AssetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[AssetTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    [tableView addLineforPlainCell:cell forRowAtIndexPath:indexPath withLeftSpace:10];
    RoomListModel *roomListModel = _roomClassModel.roomClasses[indexPath.section - 1];
    cell.roomModel = roomListModel.rooms[indexPath.row - 1];
    return cell;
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1 + _roomClassModel.roomClasses.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == 0){
        return 1;
    }
    RoomListModel *roomListModel = _roomClassModel.roomClasses[section - 1];
    return roomListModel.rooms.count + 1;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return kHeadCellHieght;
    }
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section > 0 && indexPath.row != 0) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        RoomListModel *roomListModel = _roomClassModel.roomClasses[indexPath.section - 1];
        [self.clickDelegate clickTableViewCellWithModel:roomListModel.rooms[indexPath.row - 1]];
    }
    
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section > 0) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 10)];
        view.backgroundColor = [UIColor clearColor];
        return view;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section > 0 && section < _roomClassModel.roomClasses.count) {
        return 10;
    }
    return 0;
}



#pragma mark - AssetTableHeadViewCellDelegate

- (void)assetCollection{
    [self.clickDelegate assetCollection];
}

- (void)assetChange{
    [self.clickDelegate assetChange];
}

@end

