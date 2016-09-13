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

#pragma Get


#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        static NSString *cellId = @"headCellId";
        AssetTableHeadViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[AssetTableHeadViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.delegate = self;
        }
        return cell;
    }
    if (indexPath.row == 0) {
        static NSString *cellId = @"firstCellId";
        AssetTableViewFirstCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[AssetTableViewFirstCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            [tableView addLineforPlainCell:cell forRowAtIndexPath:indexPath withLeftSpace:10];
        }
        return cell;
    }
    static NSString *cellId = @"cellId";
    AssetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[AssetTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == 0){
        return 1;
    }
    return 2;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return kHeadCellHieght;
    }
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.clickDelegate clickTableViewCellWithModel:@"客厅一"];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 10)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
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

