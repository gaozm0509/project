//
//  BaseTableView.h
//  HouseKeeper
//
//  Created by 高泽民 on 16/8/15.
//  Copyright © 2016年 zm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseModel.h"

@protocol  BaseTableViewDelegate <NSObject>

- (void)BaseTableViewClickWithModel:(BaseModel *)baseModel;

- (void)BaseTableViewClickWithIndexPath:(NSIndexPath *)indexPath;

@end

@interface BaseTableView : UITableView

@end
