//
//  PayTableViewCell.m
//  HouseKeeper
//
//  Created by 高泽民 on 16/8/15.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "PayTableViewCell.h"
#define kHieght 12
#define kPadding 10
#define kTitleheight 30

@implementation PayTableViewCell

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
    }
    return self;
}


- (UILabel *)contactsInfoLabel{
    if (!_contactsInfoLabel) {
        _contactsInfoLabel = [[UILabel alloc]init];
        _contactsInfoLabel.text = @"联系人信息";
        _contactsInfoLabel.font = [UIFont boldSystemFontOfSize:13];
        _contactsInfoLabel.textColor = [UIColor blackColor];
    }
    return _contactsInfoLabel;
}

- (UIView *)lineView1{
    if (!_lineView1) {
        _lineView1 = [[UIView alloc]init];
        _lineView1.backgroundColor = kBorderColor;
    }
    return _lineView1;
}

- (UILabel *)contactsLabel{
    if (!_contactsLabel) {
        _contactsLabel = [[UILabel alloc]init];
        _contactsLabel.textColor = Color_Hex(@"666666");
        _contactsLabel.font = kFont12;
        _contactsLabel.text = @"联系人：王尼玛";
    }
    return _contactsLabel;
}

- (UILabel *)phoneLabel{
    if (!_phoneLabel) {
        _phoneLabel = [[UILabel alloc]init];
        _phoneLabel.textColor = Color_Hex(@"666666");
        _phoneLabel.font = kFont12;
        _phoneLabel.text = @"联系电话：王尼玛";
    }
    return _phoneLabel;
}

- (UILabel *)addressLabel{
    if (!_addressLabel) {
        _addressLabel = [[UILabel alloc]init];
        _addressLabel.textColor = Color_Hex(@"666666");
        _addressLabel.font = kFont12;
        _addressLabel.text = @"用户地址：上海市";
    }
    return _addressLabel;
}

- (UILabel *)orderNumberLabel{
    if (!_orderNumberLabel) {
        _orderNumberLabel = [[UILabel alloc]init];
        _orderNumberLabel.textColor = [UIColor blackColor];
        _orderNumberLabel.font = kFont12;
        _orderNumberLabel.text = @"订单号：1232321321";
    }
    return _orderNumberLabel;
}

- (UIView *)lineView2{
    if (!_lineView2) {
        _lineView2 = [[UIView alloc]init];
        _lineView2.backgroundColor = kBorderColor;
    }
    return _lineView2;
}

- (UILabel *)inputLabel{
    if (!_inputLabel) {
        _inputLabel = [[UILabel alloc]init];
        _inputLabel.textColor = Color_Hex(@"666666");
        _inputLabel.font = kFont12;
        _inputLabel.text = @"上门录入-资产录入：99/次";
    }
    return _inputLabel;
}

- (UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.textColor = Color_Hex(@"666666");
        _timeLabel.font = kFont12;
        _timeLabel.text = @"上门服务时间：2016-03-01 下午";
    }
    return _timeLabel;
}

- (UILabel *)couponLabel{
    if (!_couponLabel) {
        _couponLabel = [[UILabel alloc]init];
        _couponLabel.textColor = [UIColor blackColor];
        _couponLabel.font = kFont12;
        _couponLabel.text = @"优惠券信息";
    }
    return _couponLabel;
}

- (UILabel *)coupnDescriptionLabel{
    if (!_coupnDescriptionLabel) {
        _coupnDescriptionLabel = [[UILabel alloc]init];
        _coupnDescriptionLabel = [[UILabel alloc]init];
        _coupnDescriptionLabel.textColor = Color_Hex(@"666666");
        _coupnDescriptionLabel.font = kFont12;
        _coupnDescriptionLabel.text = @"超过100才能用";
    }
    return _coupnDescriptionLabel;
}

- (UIButton *)myCouponListButton{
    if (!_myCouponListButton) {
        _myCouponListButton = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _myCouponListButton;
}

- (UILabel *)myCouponLabel{
    if (!_myCouponLabel) {
        _myCouponLabel = [[UILabel alloc]init];
        _myCouponLabel.text = @"我的优惠券列表";
        _myCouponLabel.textColor = Color_Hex(@"ee530e");
        _myCouponLabel.font = kFont12;
    }
    return _myCouponLabel;
}

- (UIImageView *)arrowIcon{
    if (!_arrowIcon) {
        _arrowIcon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"order优惠卷"]];
    }
    return _arrowIcon;
}

- (UILabel *)paymentLabel{
    if (!_paymentLabel) {
        _paymentLabel = [[UILabel alloc]init];
        _paymentLabel.textColor = Color_Hex(@"ee530e");
        _paymentLabel.font = kFont12;
        _paymentLabel.text = @"应付：99元";
    }
    return _paymentLabel;
}

- (UILabel *)actualCostLabel{
    if (!_actualCostLabel ) {
        _actualCostLabel = [[UILabel alloc]init];
        _actualCostLabel.textColor = Color_Hex(@"ee530e");
        _actualCostLabel.font = kFont12;
        _actualCostLabel.text = @"实付：99元";
        _actualCostLabel.textAlignment = NSTextAlignmentRight;
    }
    return _actualCostLabel;
}

- (UILabel *)chosenPaymentMethodLabel{
    if (!_chosenPaymentMethodLabel) {
        _chosenPaymentMethodLabel = [[UILabel alloc]init];
        _chosenPaymentMethodLabel.text  = @"选择付款方式";
        _chosenPaymentMethodLabel.font = kFont12;
        _chosenPaymentMethodLabel.textColor = [UIColor blackColor];
    }
    return _chosenPaymentMethodLabel;
}

- (UIView *)lineView3{
    if (!_lineView3) {
        _lineView3 = [[UIView alloc]init];
        _lineView3.backgroundColor = kBorderColor;
    }
    return _lineView3;
}

- (chosenPaymentMethod *)weichart{
    if (!_weichart) {
        _weichart = [[chosenPaymentMethod alloc]init];
        _weichart.imgView.image = [UIImage imageNamed:@"order微信支付"];
        _weichart.platformNameLabel.text = @"微信支付";
        _weichart.platformDescriptionLabel.text = @"推荐微信客户端注册用户使用";
    }
    return _weichart;
}

- (chosenPaymentMethod *)airPay{
    if (!_airPay) {
        _airPay = [[chosenPaymentMethod alloc]init];
        _airPay.imgView.image = [UIImage imageNamed:@"order支付宝支付"];
        _airPay.platformNameLabel.text = @"支付宝支付";
        _airPay.platformDescriptionLabel.text = @"推荐支付宝客户端注册用户使用";
    }
    return _airPay;
}

- (chosenPaymentMethod *)balance{
    if (!_balance) {
        _balance = [[chosenPaymentMethod alloc]init];
        _balance.imgView.image = [UIImage imageNamed:@"order余额支付"];
        _balance.platformNameLabel.text = @"余额支付";
        _balance.platformDescriptionLabel.text = @"推荐用户使用";
    }
    return _balance;
}

- (UIView *)splitView1{
    if (!_splitView1) {
        _splitView1 = [self getSplitView];
    }
    return _splitView1;
}

- (UIView *)splitView2{
    if (!_splitView2) {
        _splitView2 = [self getSplitView];
    }
    return _splitView2;
}

- (UIView *)splitView3{
    if (!_splitView3) {
        _splitView3 = [self getSplitView];
    }
    return _splitView3;
}

- (UIView *)splitView4{
    if (!_splitView4) {
        _splitView4 = [self getSplitView];
    }
    return _splitView4;
}

- (UIView *)getSplitView{
    UIView *getSplitView = [[UIView alloc]init];
    getSplitView.backgroundColor = kBackgroundColor;
    return getSplitView;
}

+ (CGFloat)getHeightWith{
    //以“+”分割，相乘的两位数第一位是元素的高度，第二位是元素的个数，依次是title的高度，普通label的高度，间隔的高度，分割view的高度，优惠券Button的高度，支付类型view的高度，应付实付的高度
   return kTitleheight * 3 + 0.5 * 3 + kHieght * 5 + kPadding * 7 + 10 * 4 + 60 + 70 * 3 + 42;
}

- (void)setupSubViews{
    [self addSubview:self.contactsInfoLabel];
    [self addSubview:self.lineView1];
    [self addSubview:self.contactsLabel];
    [self addSubview:self.phoneLabel];
    [self addSubview:self.addressLabel];
    [self addSubview:self.splitView1];
    
    [self addSubview:self.orderNumberLabel];
    [self addSubview:self.lineView2];
    [self addSubview:self.inputLabel];
    [self addSubview:self.timeLabel];
    [self addSubview:self.splitView2];
    
    [self addSubview:self.myCouponListButton];
    [_myCouponListButton addSubview:self.couponLabel];
    [_myCouponListButton addSubview:self.coupnDescriptionLabel];
    [_myCouponListButton addSubview:self.arrowIcon];
    [_myCouponListButton addSubview:self.myCouponLabel];
    [self addSubview:self.splitView3];
    
    [self addSubview:self.paymentLabel];
    [self addSubview:self.actualCostLabel];
    [self addSubview:self.splitView4];
    
    [self addSubview:self.chosenPaymentMethodLabel];
    [self addSubview:self.lineView3];
    [self addSubview:self.airPay];
    [self addSubview:self.weichart];
    [self addSubview:self.balance];
    
    WS(weakSelf);
    [_contactsInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).offset(10);
        make.top.equalTo(weakSelf);
        make.height.offset(kTitleheight);
        make.right.equalTo(weakSelf.mas_right);
    }];
    [_lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.contactsInfoLabel.mas_bottom).offset(0);
        make.height.offset(0.5);
        make.left.equalTo(weakSelf).offset(10);
        make.right.equalTo(weakSelf.mas_right).offset(- 10);
    }];
    [_contactsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.contactsInfoLabel);
        make.right.equalTo(weakSelf.mas_right);
        make.height.offset(kHieght);
        make.top.equalTo(weakSelf.lineView1.mas_bottom).offset(kPadding);
    }];
    [_phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.contactsInfoLabel);
        make.height.offset(kHieght);
        make.top.equalTo(weakSelf.contactsLabel.mas_bottom).offset(kPadding);
        make.right.equalTo(weakSelf.mas_right);
    }];
    [_addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.contactsInfoLabel);
        make.height.offset(kHieght);
        make.top.equalTo(weakSelf.phoneLabel .mas_bottom).offset(kPadding);
        make.right.equalTo(weakSelf.mas_right);
    }];
    [_splitView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.addressLabel.mas_bottom).offset(kPadding);
        make.height.offset(10);
        make.left.equalTo(weakSelf);
        make.right.equalTo(weakSelf.mas_right);
    }];
    
    
    [_orderNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.splitView1.mas_bottom).offset(0);
        make.height.offset(kTitleheight);
        make.left.equalTo(weakSelf.contactsInfoLabel);
        make.right.equalTo(weakSelf.mas_right);
    }];
    [_lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.orderNumberLabel.mas_bottom).offset(0);
        make.height.offset(0.5);
        make.left.equalTo(weakSelf).offset(10);
        make.right.equalTo(weakSelf.mas_right).offset(- 10);
    }];
    [_inputLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.contactsInfoLabel);
        make.right.equalTo(weakSelf.mas_right);
        make.height.offset(12);
        make.top.equalTo(weakSelf.lineView2.mas_bottom).offset(kPadding);
    }];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.contactsInfoLabel);
        make.right.equalTo(weakSelf.mas_right);
        make.height.offset(12);
        make.top.equalTo(weakSelf.inputLabel.mas_bottom).offset(kPadding);
    }];
    
    [_splitView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.timeLabel.mas_bottom).offset(kPadding);
        make.height.offset(10);
        make.left.equalTo(weakSelf);
        make.right.equalTo(weakSelf.mas_right);
    }];
    
    
    [_myCouponListButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.splitView2.mas_bottom);
        make.left.equalTo(weakSelf);
        make.right.equalTo(weakSelf.mas_right);
        make.height.offset(60);
    }];
    [_couponLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.myCouponListButton.mas_centerY).offset(- kPadding / 2);
        make.height.offset(12);
        make.width.lessThanOrEqualTo(@(kScreen_Width));
        make.left.equalTo(weakSelf).offset(10);
    }];
    [_coupnDescriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.myCouponListButton.mas_centerY).offset(kPadding / 2);
        make.height.offset(12);
        make.width.lessThanOrEqualTo(@(kScreen_Width));
        make.left.equalTo(weakSelf).offset(10);
    }];
    [_myCouponLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.myCouponListButton.mas_centerY);
        make.right.equalTo(weakSelf.mas_right).offset(- 25);
        make.width.lessThanOrEqualTo(@(kScreen_Width));
        make.height.offset(12);
    }];
    [_arrowIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.myCouponListButton.mas_centerY);
        make.right.equalTo(weakSelf.mas_right).offset(- 10);
        make.width.offset(9);
        make.height.offset(15);
    }];
    
    [_splitView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.myCouponListButton.mas_bottom).offset(0);
        make.height.offset(10);
        make.left.equalTo(weakSelf);
        make.right.equalTo(weakSelf.mas_right);
    }];
    
    
    [_paymentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.splitView3.mas_bottom).offset(0);
        make.height.offset(42);
        make.left.equalTo(weakSelf.contactsInfoLabel);
        make.width.offset(200);
    }];
    [_actualCostLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.paymentLabel).offset(0);
        make.height.offset(42);
        make.right.equalTo(weakSelf.mas_right).offset(- 10);
        make.width.offset(200);
    }];
    
    [_splitView4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.paymentLabel.mas_bottom).offset(0);
        make.height.offset(10);
        make.left.equalTo(weakSelf);
        make.right.equalTo(weakSelf.mas_right);
    }];

    
    [_chosenPaymentMethodLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.splitView4.mas_bottom).offset(0);
        make.height.offset(kTitleheight);
        make.left.equalTo(weakSelf.contactsInfoLabel);
        make.right.equalTo(weakSelf.mas_right);
    }];
    [_lineView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.chosenPaymentMethodLabel.mas_bottom);
        make.height.offset(0.5);
        make.left.equalTo(weakSelf).offset(10);
        make.right.equalTo(weakSelf.mas_right).offset(- 10);
    }];
    [_weichart mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.lineView3.mas_bottom);
        make.left.equalTo(weakSelf);
        make.right.equalTo(weakSelf.mas_right);
        make.height.offset(70);
    }];
    [_airPay mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.weichart.mas_bottom);
        make.left.equalTo(weakSelf);
        make.right.equalTo(weakSelf.mas_right);
        make.height.offset(70);
    }];
    [_balance mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.airPay.mas_bottom);
        make.left.equalTo(weakSelf);
        make.right.equalTo(weakSelf.mas_right);
        make.height.offset(70);
    }];
    
}

@end

@implementation chosenPaymentMethod

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupSubViews];
    }
    return self;
}

- (UIView *)line{
    if (!_line) {
        _line = [[UILabel alloc]init];
        _line.backgroundColor = kBorderColor;
    }
    return _line;
}

- (UIImageView *)imgView{
    if (!_imgView) {
        _imgView = [[UIImageView alloc]init];
    }
    return _imgView;
}

- (UILabel *)platformNameLabel{
    if (!_platformNameLabel) {
        _platformNameLabel = [[UILabel alloc]init];
        _platformNameLabel.font = kFont13;
        _platformNameLabel.textColor = Color_Hex(@"1a1a1a");
    }
    return _platformNameLabel;
}

- (UILabel *)platformDescriptionLabel{
    if (!_platformDescriptionLabel) {
        _platformDescriptionLabel = [[UILabel alloc]init];
        _platformDescriptionLabel.font = kFont13;
        _platformDescriptionLabel.textColor = Color_Hex(@"1a1a1a");
    }
    return _platformDescriptionLabel;
}

- (void)setupSubViews{
    [self addSubview:self.line];
    [self addSubview:self.imgView];
    [self addSubview:self.platformNameLabel];
    [self addSubview:self.platformDescriptionLabel];
    
    WS(weakSelf);
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf);
        make.left.equalTo(weakSelf).offset(10);
        make.right.equalTo(weakSelf.mas_right).offset(10);
        make.height.offset(0.5);
    }];
    [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.height.offset(30);
        make.width.offset(30);
        make.left.equalTo(weakSelf).offset(10);
    }];
    [_platformNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.mas_centerY).offset(- 2.5);
        make.height.offset(13);
        make.left.equalTo(weakSelf.imgView.mas_right).offset(5);
        make.right.equalTo(weakSelf.mas_right);
    }];
    [_platformDescriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_centerY).offset(2.5);
        make.height.offset(13);
        make.left.equalTo(weakSelf.imgView.mas_right).offset(5);
        make.right.equalTo(weakSelf.mas_right);
    }];
}

@end