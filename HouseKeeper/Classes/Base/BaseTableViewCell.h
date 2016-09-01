//
//  BaseTableViewCell.h
//  HouseKeeper
//
//  Created by 高泽民 on 16/8/15.
//  Copyright © 2016年 zm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseModel.h"

@interface BaseTableViewCell : UITableViewCell

+ (CGFloat)getHeightWithModel:(BaseModel *)model;

+ (CGFloat) getHeightWith;

- (void) setupSubViews;

@end
