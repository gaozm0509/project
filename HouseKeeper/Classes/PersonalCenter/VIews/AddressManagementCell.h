//
//  PersonalCenterCell.h
//  HouseKeeper
//
//  Created by 高泽民 on 16/7/16.
//  Copyright © 2016年 zm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StateModel.h"

#define kMarginTop 10
#define kMarginLeft 10
#define kNameHeight 15
#define kAdreeHeight 12

@protocol AddressManagementCellDelegate;

@interface AddressManagementCell : UITableViewCell

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UILabel *phoneNumLabel;

@property (nonatomic, strong) UILabel *addressLabel;

@property (nonatomic, strong) UIButton *editButton;

@property (nonatomic, strong) StateModel *stateModel;

@property (nonatomic, strong) UIImageView *arrowIcon;

@property (nonatomic, weak) id<AddressManagementCellDelegate> delegate;

+ (CGFloat)getHieght;

@end

@protocol AddressManagementCellDelegate <NSObject>

- (void)editStateWithModel:(StateModel *)model;

@end
