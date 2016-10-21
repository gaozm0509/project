//
//  SettingTableView.h
//  HouseKeeper
//
//  Created by 高泽民 on 16/10/19.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "BaseTableView.h"
#import "SettingTableViewCell.h"


@interface SettingTableView : BaseTableView

@property (nonatomic, weak) id<BaseTableViewDelegate> clickDelegate;

@end
