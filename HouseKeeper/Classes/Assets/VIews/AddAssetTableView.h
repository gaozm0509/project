//
//  AddAssetTableView.h
//  HouseKeeper
//
//  Created by 高泽民 on 16/10/15.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "BaseTableView.h"
#import "AddAssetTableViewCell.h"

@protocol AddAssetTableViewDelegate <NSObject>

- (void)showCheckModelSheet;

- (void)AutomaticMatchingButtonClick;

- (void)addOthers;

- (void)purchase_dateTextFieldClickWithTextField:(UITextField *)textField;

@end

@interface AddAssetTableView : BaseTableView

@property (nonatomic, weak) id<AddAssetTableViewDelegate> clickDelegate;

@property (nonatomic, strong) FurnitureModel *furnitureModel;

@property (nonatomic, assign) BOOL isAuto;


@end
