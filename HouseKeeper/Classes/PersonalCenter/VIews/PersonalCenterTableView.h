//
//  PersonalCenterTableView.h
//  HouseKeeper
//
//  Created by 高泽民 on 16/7/16.
//  Copyright © 2016年 zm. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PersonalCenterTableViewDelegate <NSObject>

- (void)clickWithIndex:(NSIndexPath *)indexPath;
- (void)customClickWithIndex:(NSInteger)index;

@end

@interface PersonalCenterTableView : UITableView

@property (nonatomic, strong) id<PersonalCenterTableViewDelegate> clcikDelegate;

@end
