//
//  AsssetServiceTableView.h
//  HouseKeeper
//
//  Created by 高泽民 on 16/10/17.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "BaseTableView.h"
#import "AssetServiceTableViewCell.h"
#import "FurnitureDetailsTableViewCell.h"

@protocol AsssetServiceTableViewDelegate <NSObject>

- (void)schedule_periodCellClick;

- (void)chosenMaintenanceOrWarrantyButton:(BOOL )isMaintenance;

@end

@interface AsssetServiceTableView : BaseTableView

@property (nonatomic, strong) NSString *city;

@property (nonatomic, strong) FurnitureModel *furnitureModel;

@property (nonatomic, weak) id<AsssetServiceTableViewDelegate> clickDelegate;

@end
