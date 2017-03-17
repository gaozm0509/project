//
//  ToBePaidTableViewCell.m
//  HouseKeeper
//
//  Created by 高泽民 on 16/7/30.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "ToBePaidTableViewCell.h"

#define kTextFont kFont14

static CGFloat itemHeight = 40.f;

@interface ToBePaidTableViewCell()


@end

@implementation ToBePaidTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupSubViews];
        
        _orderType = OrderTypeToBePaid;
    }
    return self;
}

#pragma mark - getter

- (UILabel *)orderNumber{
    if (!_orderNumber) {
        _orderNumber = [[UILabel alloc]init];
    }
    return _orderNumber;
}

- (UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.font = kTextFont;
        _timeLabel.textColor = kText_Color;
        _timeLabel.text = @"下单时间：2015-10-11";
    }
    return _timeLabel;
}

- (UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.font = kTextFont;
        _nameLabel.textColor = kText_Color;
        _nameLabel.text = @"订单类型";
    }
    return _nameLabel;
}

- (UILabel *)nameValueLabel{
    if (!_nameValueLabel) {
        _nameValueLabel = [[UILabel alloc] init];
        _nameValueLabel.textAlignment = NSTextAlignmentRight;
        _nameValueLabel.text = @"待支付";
        _nameValueLabel.font = kTextFont;
        _nameValueLabel.textColor = kText_Color;
    }
    return _nameValueLabel;
}

- (UILabel *)serviceTypeLabel{
    if (!_serviceTypeLabel) {
        _serviceTypeLabel = [[UILabel alloc] init];
        _serviceTypeLabel.text = [NSString stringWithFormat:@"服务类型:%@",@"保修"];
        _serviceTypeLabel.font = kTextFont;
        _serviceTypeLabel.textColor = kText_Color;
    }
    return _serviceTypeLabel;
}

- (UILabel *)sumLabel{
    if (!_sumLabel) {
        _sumLabel = [[UILabel alloc] init];
        _sumLabel.text = [NSString stringWithFormat:@"金额:%@元",@"99"];
        _sumLabel.font = kTextFont;
        _sumLabel.textColor = kText_Color;
    }
    return _sumLabel;
}

- (UILabel *)doorEntryFeeLabel{
    if (!_doorEntryFeeLabel) {
        _doorEntryFeeLabel = [[UILabel alloc] init];
        _doorEntryFeeLabel.text = [NSString stringWithFormat:@"上门费:%@元",@"99.00"];
        _doorEntryFeeLabel.font = kTextFont;
        _doorEntryFeeLabel.textColor = kText_Color;
    }
    return _doorEntryFeeLabel;
}


- (UILabel *)paymentLabel{
    if(!_paymentLabel){
        _paymentLabel = [[UILabel alloc]init];
        
    }
    return _paymentLabel;
}

- (UIButton *)paymentButton{
    if (!_paymentButton) {
        _paymentButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_paymentButton setTitleColor:KMajorColor forState:UIControlStateNormal];
        [_paymentButton setTitle:@"支付" forState:UIControlStateNormal];
        _paymentButton.layer.borderColor = KMajorColor.CGColor;
        _paymentButton.layer.borderWidth = 1;
        _paymentButton.titleLabel.font = kFont14;
        _paymentButton.layer.cornerRadius = 4;
        _paymentButton.tag = 1001;
        [_paymentButton addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _paymentButton;
}

- (UIButton *)cancelButton{
    if (!_cancelButton) {
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelButton setTitleColor:KMajorColor forState:UIControlStateNormal];
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        _cancelButton.layer.borderColor = KMajorColor.CGColor;
        _cancelButton.layer.borderWidth = 1;
        _cancelButton.titleLabel.font = kFont14;
        _cancelButton.layer.cornerRadius = 4;
        _cancelButton.tag = 1002;
        [_cancelButton addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
}

+ (CGFloat)getCellHieghtOrderType:(OrderType)orderType{
    if (orderType == OrderTypeToBePaid) {
        return itemHeight * 5;
    }
    return itemHeight * 4;
}

#pragma mark - setter

- (void)setOrderModel:(MyOrderModel *)orderModel{
    _orderModel = orderModel;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMdd"];
    NSDate *date = [NSDate dateFromString:_orderModel.created_at withFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateStr = [NSDate stringFromDate:date withFormat:@"yyyyMMdd"];
    
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc]initWithString:@"订单号：" attributes:@{NSFontAttributeName:kTextFont,NSForegroundColorAttributeName:kText_Color}];
    NSMutableAttributedString *text1 = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@%@",dateStr,_orderModel.id] attributes:@{NSFontAttributeName:kTextFont,NSForegroundColorAttributeName:KMajorColor}];
    [text appendAttributedString:text1];
    _orderNumber.attributedText = text;
    
    _timeLabel.text = _orderModel.order_date;
    _nameValueLabel.text = [self getTypeName:_orderType];
    
    if ([_orderModel.type isEqualToString:@"9"]) {
        _serviceTypeLabel.text = [NSString stringWithFormat:@"服务类型:上门服务"];
    }
    else{
        _serviceTypeLabel.text = [NSString stringWithFormat:@"服务类型:%@",_orderModel.server];
    }
    _sumLabel.text = [NSString stringWithFormat:@"金额:%@元",_orderModel.amount];
    _doorEntryFeeLabel.text = [NSString stringWithFormat:@"上门费:%@元",_orderModel.amount];
    
    NSMutableAttributedString *paymentText = [[NSMutableAttributedString alloc]initWithString:@"应付金额：" attributes:@{NSFontAttributeName:kFont14,NSForegroundColorAttributeName:[UIColor blackColor]}];
    NSMutableAttributedString *paymentText1 = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@元",_orderModel.amount] attributes:@{NSFontAttributeName:kTextFont,NSForegroundColorAttributeName:KMajorYellowColor}];
    [paymentText appendAttributedString:paymentText1];
    _paymentLabel.attributedText = paymentText;
    _nameValueLabel.text = [self getStatusDescrptionWithState:_orderModel.status];
    
    [self addPayButtonWithType:_orderModel.status];
}



#pragma mark - event

- (void)click:(UIButton *)button{
    switch (button.tag) {
        case 1001:{
            //支付
            if ([self.delegate respondsToSelector:@selector(payWithModel:)]){
                [self.delegate payWithModel:_orderModel];
            }
            break;
        }
        case 1002:{
            //取消
            if ([self.delegate respondsToSelector:@selector(cancelPayWithModel:)]){
                [self.delegate cancelPayWithModel:_orderModel];
            }
        }
        default:
            break;
    }
}

#pragma mark - setSubViews

- (void)addPayButtonWithType:(OrderType)orderType{
    if (orderType == OrderTypeToBePaid) {
        [self addSubview:self.paymentButton];
        [self addSubview:self.cancelButton];
        
        [_cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).offset(- 10);
            make.width.offset(50);
            make.height.offset(25);
            make.centerY.equalTo(self.mas_bottom).offset(- itemHeight / 2);
        }];
        [_paymentButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.cancelButton.mas_left).offset(- 10);
            make.width.equalTo(self.cancelButton.mas_width);
            make.height.equalTo(self.cancelButton.mas_height);
            make.centerY.equalTo(self.cancelButton.mas_centerY);
        }];
    }
    else{
        [_paymentButton removeFromSuperview];
        [_cancelButton removeFromSuperview];
    }
}

- (NSString *)getStatusDescrptionWithState:(OrderType)type{
    switch (type) {
        case OrderTypeToBePaid:
            return @"待支付";
            break;
        case OrderTypeCompletedPaid:
            return @"已支付";
            break;
        case OrderTypeArrange:
            return @"安排中";
            break;
        case OrderTypeServering:
            return @"服务中";
            break;
        case OrderTypeCompletedAll:
            return @"已完成";
            break;
        case OrderTypeAll:
            return @"全部";
            break;
        case OrderTypeCancle:
            return @"已取消";
            break;
        default:
            break;
    }
}


- (void)setupSubViews{
    
    [self addSubview:self.orderNumber];
    [self addSubview:self.timeLabel];
    [self addSubview:self.nameLabel];
    [self addSubview:self.nameValueLabel];
    [self addSubview:self.serviceTypeLabel];
    [self addSubview:self.sumLabel];
    [self addSubview:self.doorEntryFeeLabel];
    [self addSubview:self.paymentLabel];
    
    [_orderNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.width.lessThanOrEqualTo(@kScreen_Width);
        make.height.lessThanOrEqualTo(@20);
        make.centerY.equalTo(self.mas_top).offset(itemHeight / 2);
    }];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_lessThanOrEqualTo(kScreen_Width);
        make.height.mas_lessThanOrEqualTo(20);
        make.centerY.equalTo(self.orderNumber.mas_centerY);
        make.right.equalTo(self.mas_right).offset(- 10);
    }];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.width.mas_lessThanOrEqualTo(kScreen_Width);
        make.height.mas_lessThanOrEqualTo(20);
        make.centerY.equalTo(self.orderNumber.mas_centerY).offset(itemHeight);
    }];
    [_nameValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_lessThanOrEqualTo(kScreen_Width);
        make.height.mas_lessThanOrEqualTo(20);
        make.centerY.equalTo(self.nameLabel.mas_centerY);
        make.right.equalTo(self.mas_right).offset(- 10);
    }];
    [_serviceTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.width.mas_lessThanOrEqualTo(kScreen_Width);
        make.height.mas_lessThanOrEqualTo(20);
        make.centerY.equalTo(self.nameLabel.mas_centerY).offset(itemHeight);
    }];
    [_sumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.serviceTypeLabel.mas_centerY);
        make.right.equalTo(self.mas_right).offset(- 10);
        make.width.mas_lessThanOrEqualTo(kScreen_Width);
        make.height.mas_lessThanOrEqualTo(20);
    }];
    [_doorEntryFeeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.width.mas_lessThanOrEqualTo(kScreen_Width);
        make.height.mas_lessThanOrEqualTo(20);
        make.centerY.equalTo(self.serviceTypeLabel.mas_centerY).offset(itemHeight);
    }];
    [_paymentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(- 10);
        make.width.lessThanOrEqualTo(@kScreen_Width);
        make.height.mas_lessThanOrEqualTo(20);
        make.centerY.equalTo(self.doorEntryFeeLabel.mas_centerY);
    }];
    
    for (NSInteger i = 1; i <= 4; i ++) {
        CALayer *layer = [[CALayer alloc] init];
        layer.frame = CGRectMake(10, i * itemHeight , kScreen_Width - 20, 0.5);
        layer.backgroundColor = kBorderColor.CGColor;
        [self.layer addSublayer:layer];
    }
}

#pragma mark - pravit method

- (NSString *)getTypeName:(OrderType)type{
    if (type == OrderTypeToBePaid) {
        return @"待支付";
    }
    else if (type == OrderTypeCompletedPaid) {
        return @"已支付";
    }
    else if (type == OrderTypeArrange) {
        return @"安排中";
    }
    else if (type == OrderTypeServering) {
        return @"服务中";
    }
    else if (type == OrderTypeCompletedAll) {
        return @"已完成";
    }
    else{
        return @"全部";
    }
}

@end

