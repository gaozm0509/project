//
//  PayTableViewCell.h
//  HouseKeeper
//
//  Created by 高泽民 on 16/10/31.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "BaseTableViewCell.h"

typedef NS_ENUM(NSInteger, BasePayTableViewSelectPaymentMethod) {
    PaymentMethodWechat = 0,
    PaymentMethodAirpay,
    PaymentMethodBlance
};

@class ChosenPaymentMethod;

@protocol BasePayTableViewCellDelegate <NSObject>

- (void)BasePayTableViewCellGetPaymentMethod:(BasePayTableViewSelectPaymentMethod)paymentMethod;

@end

@interface BasePayTableViewCell : BaseTableViewCell

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) ChosenPaymentMethod *wechatPay;
@property (nonatomic, strong) ChosenPaymentMethod *airPay;
@property (nonatomic, strong) ChosenPaymentMethod *balance;
@property (nonatomic, strong) UIButton *moreButton;
@property (nonatomic, assign) BasePayTableViewSelectPaymentMethod paymentMethod;
@property (nonatomic, strong) UIView *morePayView;//放置余额支付和支付宝支付的view
@property (nonatomic, weak) id<BasePayTableViewCellDelegate> delegate;

@property (nonatomic, assign) BOOL isBalance;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier isBalance:(BOOL)isBalance;

+ (CGFloat)getHeight;

@end

@interface ChosenPaymentMethod : UIButton

@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *platformNameLabel;
@property (nonatomic, strong) UILabel *platformDescriptionLabel;
@property (nonatomic, strong) UIView *line;
@end
