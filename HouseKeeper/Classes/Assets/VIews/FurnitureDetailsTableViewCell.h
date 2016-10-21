//
//  FurnitureDetailsTableViewCell.h
//  HouseKeeper
//
//  Created by 高泽民 on 16/10/14.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "StateModel.h"

@interface FurnitureDetailsTableViewCell : BaseTableViewCell

@property (nonatomic, strong) UIImageView *logoImageView;
@property (nonatomic, strong) UILabel *modelLabel;
@property (nonatomic, strong) UILabel *serialLabel;//型号

@property (nonatomic, strong) FurnitureModel *model;



@end


@interface FurnitureDetailsTableViewCell1 : BaseTableViewCell

@property (nonatomic, strong) UILabel *purchaseDateLabel;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic ,strong) UILabel *brandLabel;
@property (nonatomic, strong) UILabel *fimeiLabel;

@property (nonatomic, strong) FurnitureModel *model;
@end


@interface FurnitureDetailsTableViewCell2 : BaseTableViewCell

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic ,strong) UIImageView *rightIcon;

@end


@interface FurnitureDetailsTableViewCell3 : BaseTableViewCell

@property (nonatomic, strong) FurnitureModel *model;

@end
