//
//  IntegralTableViewCell.h
//  HouseKeeper
//
//  Created by 高泽民 on 16/8/11.
//  Copyright © 2016年 zm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IntegralTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *integrallabel;
@property (nonatomic ,strong) UILabel *timeLabel;

+ (CGFloat)getCellHeight;

@end
