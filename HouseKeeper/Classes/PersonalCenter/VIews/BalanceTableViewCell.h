//
//  BalanceTableViewCell.h
//  HouseKeeper
//
//  Created by 高泽民 on 16/7/19.
//  Copyright © 2016年 zm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BalanceHistoryModel.h"

#define kMarginTop 8
#define kHeight 12
#define kMarginLeft 10
@interface BalanceTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *typeLabel;
@property (nonatomic, strong) UILabel *moneylabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *numberLabel;

@property (nonatomic, strong) BalanceHistoryModel *model;

@end
