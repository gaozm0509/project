//
//  CouponTableViewCell.h
//  HouseKeeper
//
//  Created by 高泽民 on 16/7/27.
//  Copyright © 2016年 zm. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kText @"优惠券使用说明：超过40元才能使用。"
#define kMarginleft 10
#define kStateLabelWidth 60
#define kBgViewWidht (kScreen_Width - 2 * kMarginleft)

typedef NS_ENUM(NSInteger, CouponType) {
    CouponTypeUnUsed = 0,
    CouponTypeUsed,
    CouponTypeOverdue,
};

@interface CouponTableViewCell : UITableViewCell

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UILabel *sumLabel;
@property (nonatomic, strong) UIImageView *line;
@property (nonatomic, strong) UILabel *nameLabl;
@property (nonatomic, strong) UILabel *instructionLabel;
@property (nonatomic ,strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *stateLabel;

@property (nonatomic, assign) CouponType couponType;
@end
