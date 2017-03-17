//
//  AddressManagementTableView.h
//  HouseKeeper
//
//  Created by 高泽民 on 16/7/16.
//  Copyright © 2016年 zm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StateModel.h"

@protocol AddressManagementTableViewDelegate <NSObject>

- (void)cliclCellWithModel:(StateModel *)model;

- (void)editStateWithModel:(StateModel *)model;

@end

@interface AddressManagementTableView : UITableView

@property (nonatomic, strong) StateModelDataModel *stateModelDataModel;

@property (nonatomic, weak) id<AddressManagementTableViewDelegate> clickCell;

@end
