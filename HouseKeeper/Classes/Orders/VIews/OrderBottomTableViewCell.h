//
//  OrderBottomTableViewCell.h
//  HouseKeeper
//
//  Created by 高泽民 on 16/8/15.
//  Copyright © 2016年 zm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderBottomTableViewCell : UITableViewCell

@property (nonatomic, strong) UIButton *paymentButton;
@property (nonatomic, strong) UILabel *paymentLabel;

+ (CGFloat)getHeight;

@end

@interface OrderBottomTableViewCell2 : UITableViewCell

@property (nonatomic, strong) UIButton *paymentButton;
@property (nonatomic, strong) UILabel *paymentLabel;
@property (nonatomic, strong) UILabel *homeFeeLabel;

+ (CGFloat)getHeight;

@end