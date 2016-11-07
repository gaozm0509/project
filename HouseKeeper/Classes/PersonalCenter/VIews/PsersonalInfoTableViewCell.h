//
//  PsersonalInfoTableViewCell.h
//  HouseKeeper
//
//  Created by 高泽民 on 16/11/7.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "UserAccout.h"

@interface PsersonalInfoTableViewCell : BaseTableViewCell

@property (nonatomic, strong) UIImageView *avaterImageView;

@end

@interface PsersonalInfoTableViewCell1 : BaseTableViewCell

@property (nonatomic, strong) UILabel *label;

@end

@interface PsersonalInfoTableViewCell2 : BaseTableViewCell

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *manButton;
@property (nonatomic, strong) UIButton *wemanButton;

@end
