//
//  PayTableViewCell.m
//  HouseKeeper
//
//  Created by 高泽民 on 16/10/31.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "BasePayTableViewCell.h"

#define kPayButtonHeight 70

@implementation BasePayTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupSubViews];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = kBackgroundColor;
        _paymentMethod = PaymentMethodWechat;
    }
    return self;
}

- (UIView *)topView{
    if (!_topView) {
        _topView = [[UIView alloc] init];
        _topView.backgroundColor = [UIColor whiteColor];
        [_topView addSubview:self.titleLabel];
    }
    return _topView;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"请选择支付方式";
        _titleLabel.textColor = kText_Color;
        _titleLabel.font = kFont14;
        _titleLabel.backgroundColor = [UIColor whiteColor];
    }
    return _titleLabel;
}

- (UIView *)line{
    if (!_line) {
        _line = [[UIView alloc] init];
        _line.backgroundColor = kBorderColor;
    }
    return _line;
}

- (ChosenPaymentMethod *)wechatPay{
    if (!_wechatPay) {
        _wechatPay = [[ChosenPaymentMethod alloc] init];
        _wechatPay.platformNameLabel.text = @"微信支付";
        _wechatPay.backgroundColor = [UIColor whiteColor];
        _wechatPay.platformDescriptionLabel.text = @"推荐微信客户端注册用户使用";
        _wechatPay.imgView.image = Image(@"order微信支付");
        [_wechatPay setImage:Image(@"pay_unselect") forState:UIControlStateNormal];
        [_wechatPay setImage:Image(@"pay_select") forState:UIControlStateSelected];
        _wechatPay.selected = YES;
        [_wechatPay addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        _wechatPay.tag = 1001;
        [_wechatPay setImageEdgeInsets:UIEdgeInsetsMake(0, kScreen_Width - 27, 0, 0)];
        
        _wechatPay.frame = CGRectMake(0, 35, kScreen_Width, kPayButtonHeight);
    }
    return _wechatPay;
}

- (ChosenPaymentMethod *)airPay{
    if (!_airPay) {
        _airPay = [[ChosenPaymentMethod alloc] init];
        _airPay.platformNameLabel.text = @"支付宝支付";
        _airPay.platformDescriptionLabel.text = @"推荐支付宝客户端注册用户使用";
        _airPay.backgroundColor = [UIColor whiteColor];
        _airPay.imgView.image = Image(@"order支付宝支付");
        [_airPay setImage:Image(@"pay_unselect") forState:UIControlStateNormal];
        [_airPay setImage:Image(@"pay_select") forState:UIControlStateSelected];
        [_airPay addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        _airPay.tag = 1002;
        [_airPay setImageEdgeInsets:UIEdgeInsetsMake(0, kScreen_Width - 27, 0, 0)];
        _airPay.frame = CGRectMake(0, 35 + kPayButtonHeight, kScreen_Width, 0);
        _airPay.layer.masksToBounds = YES;
    }
    return _airPay;
}

- (UIButton *)moreButton{
    if (!_moreButton) {
        _moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _moreButton.backgroundColor = [UIColor whiteColor];
        [_moreButton setTitleColor:Color_Hex(@"666666") forState:UIControlStateNormal];
        [_moreButton setTitle:@"更多支付方式" forState:UIControlStateNormal];
        [_moreButton setImage:Image(@"支付方式下拉") forState:UIControlStateNormal];
        [_moreButton setImage:Image(@"支付方式回拉") forState:UIControlStateSelected];
        _moreButton.layer.borderColor = kBorderColor.CGColor;
        _moreButton.layer.borderWidth = 0.5;
        _moreButton.titleLabel.font = kFont14;
        _moreButton.selected = NO;
        _moreButton.tag = 1003;
        [_moreButton addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        _moreButton.frame = CGRectMake(0, 35 + kPayButtonHeight, kScreen_Width, 40);
        [_moreButton setImageEdgeInsets:UIEdgeInsetsMake(0, kScreen_Width / 2 + 50, 0, 0)];
    }
    return _moreButton;
}

- (void)setupSubViews{
    [self addSubview:self.topView];
    [self addSubview:self.line];
    [self addSubview:self.wechatPay];
    [self addSubview:self.airPay];
    [self addSubview:self.moreButton];
    
    [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.top.equalTo(self);
        make.right.equalTo(self.mas_right);
        make.height.offset(40);
    }];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.height.lessThanOrEqualTo(@20);
        make.width.lessThanOrEqualTo(@100);
        make.centerY.equalTo(self.topView.mas_centerY);
    }];
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.right.equalTo(self.mas_right);
        make.height.offset(0.5);
        make.top.equalTo(_topView.mas_bottom).offset(- 0.5);
    }];
//    [_wechatPay mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self);
//        make.right.equalTo(self.mas_right);
//        make.height.offset(kPayButtonHeight);
//        make.top.equalTo(_line.mas_bottom);
//    }];
//    [_airPay mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(_wechatPay.mas_bottom);
//        make.left.equalTo(self);
//        make.right.equalTo(self.mas_right);
//        make.height.offset(0.1);
//    }];
//    [_moreButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(_airPay.mas_bottom);
//        make.left.equalTo(self);
//        make.right.equalTo(self.mas_right);
//        make.height.offset(45);
//    }];
}

#pragma mark - event method

- (void)click:(UIButton *)button{
    if (button.tag == 1001) {
        //微信
        _wechatPay.selected = YES;
        _airPay.selected = NO;
        _paymentMethod = PaymentMethodWechat;
        
        [self.delegate BasePayTableViewCellGetPaymentMethod:_paymentMethod];
    }
    if (button.tag == 1002) {
        //支付宝
        _wechatPay.selected = NO;
        _airPay.selected = YES;
        _paymentMethod = PaymentMethodAirpay;
        
        [self.delegate BasePayTableViewCellGetPaymentMethod:_paymentMethod];
    }
    if (button.tag == 1003) {
        //更多支付
        _moreButton.selected = !_moreButton.selected;
        if (!_moreButton.selected) {
            [self showMore];
        }
        else{
            [self hidMore];
        }
    }
}

#pragma mark - paravit method

- (void)showMore{
    [UIView animateWithDuration:0.5 animations:^{
        _airPay.height = 0;
        _moreButton.top = _airPay.bottom;
    }];
}

- (void)hidMore{
    [UIView animateWithDuration:0.5 animations:^{
        _airPay.height = kPayButtonHeight;
        _moreButton.top = _airPay.bottom;
    }];
}

+ (CGFloat)getHeight{
    return 200;
}

@end

@implementation ChosenPaymentMethod

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
