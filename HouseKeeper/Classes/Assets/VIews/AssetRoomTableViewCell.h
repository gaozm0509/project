//
//  AssetRoomTableViewCell.h
//  HouseKeeper
//
//  Created by 高泽民 on 16/9/11.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "StateModel.h"

@interface AssetRoomTableViewCell : BaseTableViewCell

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *rightIcon;
@property (nonatomic, strong) UILabel *contentlabel;
@property (nonatomic, strong) UILabel *appliancesName;

@property (nonatomic, strong) FurnitureModel *model;

@end


@interface AssetRoomTableViewCell1 : BaseTableViewCell

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *rightIcon;
@property (nonatomic, strong) UILabel *appliancesName;

@property (nonatomic, strong) FurnitureModel *model;

@end

