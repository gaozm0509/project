//
//  AssetServiceTableViewCell.h
//  HouseKeeper
//
//  Created by 高泽民 on 16/10/17.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "StateModel.h"

@protocol AssetServiceTableViewCellDelegate <NSObject>

- (void)chosenMaintenanceOrWarrantyButton:(BOOL )isMaintenance;

@end

@interface AssetServiceTableViewCell : BaseTableViewCell

@property (nonatomic, strong) UIImageView *loctionIcon;
@property (nonatomic ,strong) UILabel *phoneLabel;
@property (nonatomic, strong) UILabel *loctionLabel;

@end


@interface AssetServiceTableViewCell1 : BaseTableViewCell

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *maintenanceButton;//保养
@property (nonatomic, strong) UIButton *warrantyButton;//保修

@property (nonatomic, weak) id<AssetServiceTableViewCellDelegate> delegate;

@end
