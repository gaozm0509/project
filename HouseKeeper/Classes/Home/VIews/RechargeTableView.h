//
//  RechargeTableView.h
//  HouseKeeper
//
//  Created by 高泽民 on 16/10/31.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "BaseTableView.h"
#import "RechargeTableViewCell.h"
#import "BasePayTableViewCell.h"

@interface RechargeTableView : BaseTableView

@property (nonatomic, assign) BasePayTableViewSelectPaymentMethod paymentMethod;

@end
