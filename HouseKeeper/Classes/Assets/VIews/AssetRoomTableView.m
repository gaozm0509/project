//
//  AssetRoomTableView.m
//  HouseKeeper
//
//  Created by 高泽民 on 16/9/11.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "AssetRoomTableView.h"

@interface AssetRoomTableView()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation AssetRoomTableView

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
        AssetRoomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[AssetRoomTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        return cell;
    }
   static NSString *cellId = @"cellId1";
    AssetRoomTableViewCell1 *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[AssetRoomTableViewCell1 alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 20)];
    
    UILabel *title = [[UILabel alloc]init];
    title.text = section == 0 ? @"保养提醒" : @"重要资产";
    title.textColor = Color_Hex(@"a4a4a4");
    title.font = kFont12;
    title.textAlignment = NSTextAlignmentCenter;
    [view addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(view);
        make.width.lessThanOrEqualTo(@100);
        make.height.offset(12);
    }];
    
    UIView *leftView = [[UIView alloc]init];
    leftView.backgroundColor = Color_Hex(@"a4a4a4");
    [view addSubview:leftView];
    [leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view).offset(10);
        make.height.offset(0.5);
        make.centerY.equalTo(view.mas_centerY);
        make.right.equalTo(title.mas_left).offset(- 10);
    }];
    
    UIView *rightView = [[UIView alloc]init];
    rightView.backgroundColor = Color_Hex(@"a4a4a4");
    [view addSubview:rightView];
    [rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(view.mas_right).offset(- 10);
        make.height.offset(0.5);
        make.centerY.equalTo(view.mas_centerY);
        make.left.equalTo(title.mas_right).offset(10);
    }];
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
}

@end
