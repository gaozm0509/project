//
//  BalanceView.h
//  HouseKeeper
//
//  Created by 高泽民 on 16/7/19.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "BaseVIew.h"
#import "BalanceTableViewCell.h"

@interface BalanceView : BaseVIew

@property (nonatomic, strong) BalanceHistoryListModel *listModel;
@property (nonatomic, strong) UILabel *balanceLabel;

@end
