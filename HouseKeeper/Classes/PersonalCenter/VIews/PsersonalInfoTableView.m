//
//  PsersonalInfoTableView.m
//  HouseKeeper
//
//  Created by 高泽民 on 16/11/7.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "PsersonalInfoTableView.h"



@interface PsersonalInfoTableView()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation PsersonalInfoTableView

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
        
        if (indexPath.row == 0) {
            
            static NSString *cellId = @"PsersonalInfoTableViewCell";
            PsersonalInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
            if (!cell) {
                
                cell = [[PsersonalInfoTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
                
                
            }
            
            [tableView addLineforPlainCell:cell forRowAtIndexPath:indexPath withLeftSpace:0];
            
            [cell.avaterImageView sd_setImageWithURL:[NSURL URLWithString:_userAccout.avatar] placeholderImage:nil];
            return cell;
        }
        else{
            
            static NSString *cellId = @"PsersonalInfoTableViewCell11";
            PsersonalInfoTableViewCell1 *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
            if (!cell) {
                cell = [[PsersonalInfoTableViewCell1 alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            }
            
            [tableView addLineforPlainCell:cell forRowAtIndexPath:indexPath withLeftSpace:0];
            
            if (indexPath.row == 1) {
                cell.label.text = [NSString stringWithFormat:@"姓名 %@",_userAccout.name];
            }
            else if(indexPath.row == 2){
                cell.label.text = [NSString stringWithFormat:@"昵称 %@",_userAccout.nickname];
            }
            else{
                cell.label.text = [NSString stringWithFormat:@"出生日期 %@",_userAccout.birth];
            }
            return cell;
            
        }
        
    }
    static NSString *cellId = @"PsersonalInfoTableViewCell12";
    PsersonalInfoTableViewCell2 *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[PsersonalInfoTableViewCell2 alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    [tableView addLineforPlainCell:cell forRowAtIndexPath:indexPath withLeftSpace:0];
    
    if (_userAccout.gender == 0) {
        cell.manButton.selected = YES;
        cell.wemanButton.selected = NO;
    }
    else{
        cell.manButton.selected = NO;
        cell.wemanButton.selected = YES;
    }
    return cell;

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 3;
    }
    else{
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 && indexPath.row == 0) {
        return 120;
    }
    return 45;
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section{
    view.tintColor = [UIColor clearColor];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    }
    return 10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.clickDelegate BaseTableViewClickWithIndexPath:indexPath];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)setUserAccout:(UserAccout *)userAccout{
    _userAccout = userAccout;
    [self reloadData];
}

@end
