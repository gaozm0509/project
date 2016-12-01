//
//  LifeServiceTableViewCell.h
//  HouseKeeper
//
//  Created by 高泽民 on 16/11/24.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "LifeServiceListModel.h"
#import "BQRatingView.h"

@interface LifeServiceTableViewCell : BaseTableViewCell

@property (nonatomic, strong) LifeServiceListModel *model;

@property (nonatomic, strong) UIImageView *leftImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *areaLabel;
@property (nonatomic, strong) UILabel *distanceLabel;
@property (nonatomic, strong) BQRatingView *ratingView;

@end

@interface LifeServiceTableViewCell1 : BaseTableViewCell

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *leftIcon;
@property (nonatomic, strong)UIImageView *rightIcon;

@end
