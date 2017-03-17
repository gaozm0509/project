//
//  DoorEntryTableViewCell.h
//  HouseKeeper
//
//  Created by 高泽民 on 16/10/28.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "DoorEntryModel.h"

@interface DoorEntryTableViewCell : BaseTableViewCell

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIButton *selectButton;

@end

@interface DoorEntryTableViewCell1 : BaseTableViewCell

@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *descriptionLabel;
@property (nonatomic, strong) UILabel *feeLabel;

@property (nonatomic, strong) DoorEntryModel *model;

+ (CGFloat)getHieghtWithModel:(DoorEntryModel *)model;

@end
