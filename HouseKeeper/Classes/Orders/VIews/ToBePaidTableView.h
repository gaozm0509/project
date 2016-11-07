//
//  ToBePaidTableView.h
//  HouseKeeper
//
//  Created by 高泽民 on 16/7/30.
//  Copyright © 2016年 zm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ToBePaidTableViewCell.h"
#import "BaseTableView.h"

@protocol ToBePaidTableViewDelegate <NSObject>

- (void)ToBePaidClickCellButton;

@end

@interface ToBePaidTableView : BaseTableView

@property (nonatomic, weak) id<ToBePaidTableViewDelegate> clickDelegate;

@property (nonatomic, assign) OrderType orderType;



@end
