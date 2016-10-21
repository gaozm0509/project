//
//  SettingTableViewCell.h
//  HouseKeeper
//
//  Created by 高泽民 on 16/10/19.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface SettingTableViewCell : BaseTableViewCell

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *rightIcon;

@end

@interface SettingTableViewCell1 : BaseTableViewCell

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentlabel;

@end
