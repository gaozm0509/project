//
//  LifeServiceTableView.h
//  HouseKeeper
//
//  Created by 高泽民 on 16/11/24.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "BaseTableView.h"
#import "LifeServiceTableViewCell.h"

@interface LifeServiceTableView : BaseTableView

@property (nonatomic, strong) LifeServiceListDataModel *listModel;

@property (nonatomic, weak) id<BaseTableViewDelegate> clickDelegate;

@end
