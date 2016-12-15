//
//  ToBePaidTableViewCell.h
//  HouseKeeper
//
//  Created by 高泽民 on 16/7/30.
//  Copyright © 2016年 zm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyOrderModel.h"



@protocol ToBePaidTableViewCellDelegate <NSObject>

@optional
- (void)payWithModel:(MyOrderModel *)model;
- (void)cancelPayWithModel:(MyOrderModel *)model;

@end

@interface ToBePaidTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *orderNumber;         //订单号
@property (nonatomic, strong) UILabel *timeLabel;           //下单时间
@property (nonatomic, strong) UILabel *nameLabel;           //订单类型名称
@property (nonatomic, strong) UILabel *nameValueLabel;      //订单类型
@property (nonatomic, strong) UILabel *serviceTypeLabel;    //服务类型
@property (nonatomic, strong) UILabel *sumLabel;            //金额
@property (nonatomic, strong) UILabel *doorEntryFeeLabel;   //上门服务费
@property (nonatomic, strong) UILabel *paymentLabel;       //应付金额

@property (nonatomic, strong) UIButton *paymentButton;
@property (nonatomic, strong) UIButton *cancelButton;

@property (nonatomic, strong) id<ToBePaidTableViewCellDelegate> delegate;

@property (nonatomic, assign) OrderType orderType;

@property (nonatomic, strong) MyOrderModel *orderModel;

+ (CGFloat)getCellHieghtOrderType:(OrderType)orderType;



@end
