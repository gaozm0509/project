//
//  PsersonalInfoTableView.h
//  HouseKeeper
//
//  Created by 高泽民 on 16/11/7.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "BaseTableView.h"
#import "PsersonalInfoTableViewCell.h"

@interface PsersonalInfoTableView : BaseTableView

@property (nonatomic, weak) id<BaseTableViewDelegate> clickDelegate;

@property (nonatomic, strong) UserAccout *userAccout;

@end
