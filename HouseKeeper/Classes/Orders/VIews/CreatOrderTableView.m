//
//  CreatOrderTableView.m
//  HouseKeeper
//
//  Created by 高泽民 on 16/11/4.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "CreatOrderTableView.h"


@interface CreatOrderTableView()<UITableViewDelegate,UITableViewDataSource,BasePayTableViewCellDelegate>

@end

@implementation CreatOrderTableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.dataSource = self;
        self.delegate = self;
        self.backgroundColor = kBackgroundColor;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        _paymentMethod = PaymentMethodWechat;
    }
    return self;
}

- (void)setAmount:(NSString *)amount{
    _amount = amount;
    [self reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
}

- (void)setName:(NSString *)name{
    _name = name;
    [self reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:{
            static NSString *cellId = @"cellId";
            CreatOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
            if (!cell) {
                cell = [[CreatOrderTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            return cell;
            break;
        }
        case 1:{
            static NSString *cellId = @"cellId";
            BaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
            if (!cell) {
                cell = [[BaseTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
            }
            cell.textLabel.text = _name;
            cell.textLabel.textColor = kText_Color;
            cell.textLabel.font = kFont14;
            cell.textLabel.textAlignment = NSTextAlignmentLeft;
            
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@元",_amount];
            cell.detailTextLabel.textColor = KMajorColor;
            cell.detailTextLabel.font = kFont14;
            
            return cell;
        }
            
        default:{
            static NSString *cellId = @"cellId2";
            BasePayTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
            if (!cell) {
                cell = [[BasePayTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId isBalance:YES];
                cell.delegate = self;
            }
            return cell;
            break;
        }
    }
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:{
            return 70;
            break;
        }
        case 1:{
            return 45;
            break;
        }
        case 2:{
            return [BasePayTableViewCell getHeight];
            break;
        }
            
        default:
            return 45;
            break;
    }
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section{
    view.tintColor = [UIColor clearColor];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
}

#pragma mark - BasePayTableViewCellDelegate

- (void)BasePayTableViewCellGetPaymentMethod:(BasePayTableViewSelectPaymentMethod)paymentMethod{
    _paymentMethod = paymentMethod;
}

@end
