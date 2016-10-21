//
//  FurnitureDetailsTableView.h
//  HouseKeeper
//
//  Created by 高泽民 on 16/10/14.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "BaseTableView.h"
#import "FurnitureDetailsTableViewCell.h"

@interface FurnitureDetailsTableView : BaseTableView

@property (nonatomic, strong) FurnitureModel *model;

@property (nonatomic, weak) id<BaseTableViewDelegate> clickDeleagte;

@end
