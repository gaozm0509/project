//
//  DoorEntryTableView.h
//  HouseKeeper
//
//  Created by 高泽民 on 16/10/28.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "BaseTableView.h"
#import "DoorEntryTableViewCell.h"

@interface DoorEntryTableView : BaseTableView

@property(nonatomic, strong) DoorEntryModel *model1;
@property(nonatomic, strong) DoorEntryModel *model2;
@property(nonatomic, assign) NSInteger selectRow;//1为上门资产录入，2位深度资产录入

@end
