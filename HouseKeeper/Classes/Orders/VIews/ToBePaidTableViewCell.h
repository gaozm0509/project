//
//  ToBePaidTableViewCell.h
//  HouseKeeper
//
//  Created by 高泽民 on 16/7/30.
//  Copyright © 2016年 zm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ToBePaidTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *orderNumber;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *unitPriceLabel;
@property (nonatomic, strong) UILabel *totalPriceLabel;
@property (nonatomic, strong) UIButton *paymentButton;
@property (nonatomic, strong) UILabel  *paymentLabel;

+ (CGFloat) getCellHieght;

@end
