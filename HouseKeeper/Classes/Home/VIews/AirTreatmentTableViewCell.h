//
//  AirTreatmentTableViewCell.h
//  HouseKeeper
//
//  Created by 高泽民 on 16/11/1.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "DoorEntryModel.h"

@interface AirTreatmentTableViewCell : BaseTableViewCell

@property (nonatomic, strong) UILabel *titleLbael;
@property (nonatomic, strong) UILabel *rightTitleLabel;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UILabel *contentLabel;

@property (nonatomic ,strong) DoorEntryModel *model;


@end
