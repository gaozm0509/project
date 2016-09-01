//
//  ToBePaidTableView.h
//  HouseKeeper
//
//  Created by 高泽民 on 16/7/30.
//  Copyright © 2016年 zm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ToBePaidTableViewCell.h"

@protocol ToBePaidTableViewDelegate <NSObject>

- (void)ToBePaidClickCellButton;

@end

@interface ToBePaidTableView : UITableView

@property (nonatomic, weak) id<ToBePaidTableViewDelegate> clickDelegate;

@end
