//
//  OrderDetailsTableViewCell.h
//  HouseKeeper
//
//  Created by 高泽民 on 16/9/14.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface OrderDetailsTableViewCell : BaseTableViewCell

@property (nonatomic, strong) UILabel *orderNumberLabel;
@property (nonatomic, strong) UIView *lineView1;
@property (nonatomic, strong) UILabel *orderTimeLabel;
@property (nonatomic, strong) UILabel *serviceTimeLabel;
@property (nonatomic, strong) UIView *lineView2;
@property (nonatomic, strong) UILabel *contactsLabel;
@property (nonatomic, strong) UILabel *contactsMobileLabel;
@property (nonatomic, strong) UILabel *addressLabel;

@end
