//
//  OrderBottomTableViewCell.m
//  HouseKeeper
//
//  Created by 高泽民 on 16/8/15.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "OrderBottomTableViewCell.h"

@implementation OrderBottomTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupSubViews];
    }
    return self;
}

- (UILabel *)paymentLabel{
    if(!_paymentLabel){
        _paymentLabel = [[UILabel alloc]init];
        NSMutableAttributedString *text = [[NSMutableAttributedString alloc]initWithString:@"应付金额：99元" attributes:@{NSFontAttributeName:kFont14,NSForegroundColorAttributeName:[UIColor blackColor]}];
        [text addAttributes:@{NSFontAttributeName:kFont14,NSForegroundColorAttributeName:Color_Hex(@"ee530e")} range:NSMakeRange(5, 3)];
        _paymentLabel.attributedText = text;
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
    }
    return _paymentButton;
}

+ (CGFloat)getHeight{
    return 70;
}

- (void)setupSubViews{
    [self addSubview:self.paymentLabel];
    [self addSubview:self.paymentButton];
    
    WS(weakSelf);
    [_paymentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.height.offset(15);
        make.left.equalTo(weakSelf).offset(10);
        make.width.offset(200);
    }];
    [_paymentButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.right.equalTo(weakSelf.mas_right).offset(- 10);
        make.width.offset(80);
        make.height.offset(30);
    }];
}

@end


@implementation OrderBottomTableViewCell2

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupSubViews];
    }
    return self;
}

- (UILabel *)homeFeeLabel{
    if (!_homeFeeLabel) {
        _homeFeeLabel = [[UILabel alloc]init];
        NSMutableAttributedString *text = [[NSMutableAttributedString alloc]initWithString:@"上门费用：30元" attributes:@{NSFontAttributeName:kFont14,NSForegroundColorAttributeName:[UIColor blackColor]}];
        [text addAttributes:@{NSFontAttributeName:kFont14,NSForegroundColorAttributeName:Color_Hex(@"ee530e")} range:NSMakeRange(5, 3)];
        _homeFeeLabel.attributedText = text;
    }
    return _homeFeeLabel;
}

- (UILabel *)paymentLabel{
    if(!_paymentLabel){
        _paymentLabel = [[UILabel alloc]init];
        NSMutableAttributedString *text = [[NSMutableAttributedString alloc]initWithString:@"应付金额：99元" attributes:@{NSFontAttributeName:kFont14,NSForegroundColorAttributeName:[UIColor blackColor]}];
        [text addAttributes:@{NSFontAttributeName:kFont14,NSForegroundColorAttributeName:Color_Hex(@"ee530e")} range:NSMakeRange(5, 3)];
        _paymentLabel.attributedText = text;
        _paymentLabel.textAlignment = NSTextAlignmentRight;
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
    }
    return _paymentButton;
}

+ (CGFloat)getHeight{
    return 85;
}

- (void)setupSubViews{
    [self addSubview:self.homeFeeLabel];
    [self addSubview:self.paymentLabel];
    [self addSubview:self.paymentButton];
    
    WS(weakSelf);
    [_homeFeeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf).offset(10);
        make.height.offset(15);
        make.left.equalTo(weakSelf).offset(10);
        make.width.offset(200);
    }];
    [_paymentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf).offset(10);
        make.height.offset(15);
        make.right.equalTo(weakSelf.mas_right).offset(- 10);
        make.width.offset(200);
    }];
    [_paymentButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.paymentLabel.mas_bottom).offset(10);
        make.right.equalTo(weakSelf.mas_right).offset(- 10);
        make.width.offset(80);
        make.height.offset(30);
    }];
}

@end