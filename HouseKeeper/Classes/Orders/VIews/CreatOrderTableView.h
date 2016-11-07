//
//  CreatOrderTableView.h
//  HouseKeeper
//
//  Created by 高泽民 on 16/11/4.
//  Copyright © 2016年 zm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CreatOrderTableViewCell.h"
#import "BasePayTableViewCell.h"

@interface CreatOrderTableView : UITableView

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *amount;

@property (nonatomic, assign) BasePayTableViewSelectPaymentMethod paymentMethod;

@end
