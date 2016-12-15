//
//  CouponTableView.h
//  HouseKeeper
//
//  Created by 高泽民 on 16/7/27.
//  Copyright © 2016年 zm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CouponTableViewCell.h"

@interface CouponTableView : UITableView

@property (nonatomic, assign) CouponType couponType;

@property (nonatomic, strong) CouponListModel *listModel;

@end
