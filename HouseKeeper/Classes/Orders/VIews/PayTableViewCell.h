//
//  PayTableViewCell.h
//  HouseKeeper
//
//  Created by 高泽民 on 16/8/15.
//  Copyright © 2016年 zm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewCell.h"

@class chosenPaymentMethod;
@interface PayTableViewCell : BaseTableViewCell

//联系人信息
//-------------------------
@property (nonatomic, strong) UILabel *contactsInfoLabel;//联系人信息
@property (nonatomic, strong) UIView *lineView1;
@property (nonatomic, strong) UILabel *contactsLabel;
@property (nonatomic, strong) UILabel *phoneLabel;
@property (nonatomic, strong) UILabel *addressLabel;

@property (nonatomic, strong) UIView *splitView1;

//订单号：
@property (nonatomic, strong) UILabel *orderNumberLabel;
@property (nonatomic, strong) UIView *lineView2;
@property (nonatomic, strong) UILabel *inputLabel;
@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) UIView *splitView2;


//优惠券信息
@property (nonatomic, strong) UILabel *couponLabel;
@property (nonatomic, strong) UILabel *coupnDescriptionLabel;
@property (nonatomic, strong) UIButton *myCouponListButton;
@property (nonatomic, strong) UILabel *myCouponLabel;
@property (nonatomic, strong) UIImageView *arrowIcon;

@property (nonatomic, strong) UIView *splitView3;

//应付
@property (nonatomic, strong) UILabel *paymentLabel;
@property (nonatomic, strong) UILabel *actualCostLabel;

@property (nonatomic, strong) UIView *splitView4;

//选择付款方式
@property (nonatomic, strong) UILabel *chosenPaymentMethodLabel;
@property (nonatomic, strong) UIView *lineView3;

@property (nonatomic, strong) chosenPaymentMethod *airPay;
@property (nonatomic, strong) chosenPaymentMethod *weichart;
@property (nonatomic, strong) chosenPaymentMethod *balance;

@end

@interface chosenPaymentMethod : UIButton

@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *platformNameLabel;
@property (nonatomic, strong) UILabel *platformDescriptionLabel;
@property (nonatomic, strong) UIView *line;
@end
