//
//  PersonalCenterTableView.m
//  HouseKeeper
//
//  Created by 高泽民 on 16/7/16.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "PersonalCenterTableView.h"
#import "PersonalCenterTableViewCell.h"

@interface PersonalCenterTableView()<UITableViewDelegate,UITableViewDataSource,PersonalCenterTableViewCellDelegate>{}

@end

@implementation PersonalCenterTableView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.backgroundColor = kBackgroundColor;
    }
    return self;
}

- (void)setModel:(UserAccout *)model{
    _model = model;
    [self reloadData];
}

#pragma mark - Delegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId0 = @"Cell0";
    static NSString *cellId2 = @"Cell2";
    static NSString *cellId3 = @"Cell3";
    
    if (indexPath.section == 0) {
        PersonalCenterTableViewTopCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId0];
        if (!cell) {
            cell = [[PersonalCenterTableViewTopCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId0];
            cell.delegate = self;
        }
        cell.model = _model;
        return cell;
    }
    else if (indexPath.section == 1) {
        PersonalCenterTableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:cellId2];
        if (!cell) {
            cell = [[PersonalCenterTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId2];
            [tableView addLineforPlainCell:cell forRowAtIndexPath:indexPath withLeftSpace:kMarginLeft];
        }
        switch (indexPath.row) {
            case 0:
                cell.titleLabel.text = @"地址管理";
                cell.leftIcon.image = [UIImage imageNamed:@"地址管理"];
                break;
            case 1:
                cell.titleLabel.text = @"第二联系人";
                cell.leftIcon.image = [UIImage imageNamed:@"头像"];
                break;
            default:
                break;
        }
        return cell;
    }
    else {
        PersonalCenterTableViewBottomCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId3];
        if (!cell) {
            cell = [[PersonalCenterTableViewBottomCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId3];
            [tableView addLineforPlainCell:cell forRowAtIndexPath:indexPath withLeftSpace:kMarginLeft];
        }
        if (indexPath.row == 0) {
            cell.leftLabel.text = @"洗衣服务";
            cell.centerLabel.text = @"等待上门";
        }
        if (indexPath.row == 1) {
            cell.leftLabel.text  = @"空调维修";
            cell.centerLabel.text = @"正在服务";
        }
        return cell;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    if (section == 1) {
        return 2;
    }
    if (section == 2) {
        return 2;
    }
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return [PersonalCenterTableViewTopCell getHieght];
    }
    if (indexPath.section == 1) {
        return 45;
    }
    return 45;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 1)  {
        return 40;
    }
    if (section == 2) {
        return 40;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, kScreen_Width, 40)];
        label.text = @"    管理";
        label.textColor = Color_Hex(@"a4a4a4");
        label.font = kFont12;
        label.backgroundColor = kBackgroundColor;
        return label;
    }
    if (section == 2) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, kScreen_Width, 40)];
        label.text = @"    正在为您服务";
        label.textColor = Color_Hex(@"a4a4a4");
        label.font = kFont12;
        label.backgroundColor = kBackgroundColor;
        return label;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.clcikDelegate clickWithIndex:indexPath];
}

#pragma mark PersonalCenterTableViewCellDelegate

- (void)click:(NSInteger)index{
    [self.clcikDelegate customClickWithIndex:index];
}

@end
