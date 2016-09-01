//
//  OrderTopTableViewCell.h
//  HouseKeeper
//
//  Created by 高泽民 on 16/8/15.
//  Copyright © 2016年 zm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderTopTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *orderNumber;
@property (nonatomic, strong) UILabel *timeLabel;

+ (CGFloat)getHeight;

@end
