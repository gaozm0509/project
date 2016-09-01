//
//  PersonalCenterCell.h
//  HouseKeeper
//
//  Created by 高泽民 on 16/7/16.
//  Copyright © 2016年 zm. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kMarginTop 10
#define kMarginLeft 10
#define kNameHeight 15
#define kAdreeHeight 12

@interface AddressManagementCell : UITableViewCell

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UILabel *phoneNumLabel;

@property (nonatomic, strong) UILabel *addressLabel;

@property (nonatomic, strong) UIButton *editButton;

+ (CGFloat)getHieght;

@end
