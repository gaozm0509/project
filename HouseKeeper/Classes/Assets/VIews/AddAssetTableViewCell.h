//
//  AddAssetTableViewCell.h
//  HouseKeeper
//
//  Created by 高泽民 on 16/10/15.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "StateModel.h"

@protocol AddAssetTableViewCellDelegate <NSObject>

- (void)showCheckModelSheet;

- (void)AutomaticMatchingButtonClick;

- (void)purchase_dateTextFieldClickWithTextField:(UITextField *)textField;

@end

@interface AddAssetTableViewCell : BaseTableViewCell

@property (nonatomic, strong)UITextField *modelTextField;

@property (nonatomic, weak) id<AddAssetTableViewCellDelegate> delegate;

@property (nonatomic, strong) FurnitureModel *furnitureModel;

@end


@interface AddAssetTableViewCell1 : BaseTableViewCell

@property (nonatomic, strong) UITextField *textField;

@property (nonatomic, strong) FurnitureModel *furnitureModel;

@end


@interface AddAssetTableViewCell2 : BaseTableViewCell

@property (nonatomic, strong) UIButton *AutomaticMatchingButton;

@property (nonatomic, weak) id<AddAssetTableViewCellDelegate> delegate;

@end

@interface AddAssetTableViewAutoCell : BaseTableViewCell

@property (nonatomic, strong) UILabel *titlelabel;
@property (nonatomic, strong) UIImageView *rightIcon;

@end


@interface AddAssetTableViewPurchase_dateCell : BaseTableViewCell

@property (nonatomic, strong)UITextField *purchase_dateTextField;

@property (nonatomic, weak) id<AddAssetTableViewCellDelegate> delegate;

@property (nonatomic, strong) FurnitureModel *furnitureModel;

@end
