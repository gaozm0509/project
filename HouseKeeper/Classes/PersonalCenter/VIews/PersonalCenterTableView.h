//
//  PersonalCenterTableView.h
//  HouseKeeper
//
//  Created by 高泽民 on 16/7/16.
//  Copyright © 2016年 zm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserAccout.h"
#import "BaseTableView.h"

@protocol PersonalCenterTableViewDelegate <NSObject>

- (void)clickWithIndex:(NSIndexPath *)indexPath;
- (void)customClickWithIndex:(NSInteger)index;

@end

@interface PersonalCenterTableView : BaseTableView

@property (nonatomic, strong) id<PersonalCenterTableViewDelegate> clcikDelegate;

@property (nonatomic, strong) UserAccout *model;

@end
