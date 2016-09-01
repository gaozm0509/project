//
//  ToBePaidTableViewCell.m
//  HouseKeeper
//
//  Created by 高泽民 on 16/7/30.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "ToBePaidTableViewCell.h"

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
    }
    return self;
}


- (UILabel *)orderNumber{
    if (!_orderNumber) {
        _orderNumber = [[UILabel alloc]init];
        NSMutableAttributedString *text = [[NSMutableAttributedString alloc]initWithString:@"订单号：G23098" attributes:@{NSFontAttributeName:kFont12,NSForegroundColorAttributeName:[UIColor blackColor]}];
        [text addAttributes:@{NSFontAttributeName:kFont12,NSForegroundColorAttributeName:KMajorColor} range:NSMakeRange(4, 6)];
        _orderNumber.attributedText = text;
    }
    return _orderNumber;
}

- (UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.font = kFont12;
        _timeLabel.textColor = [UIColor blackColor];
        _timeLabel.text = @"下单时间：2015-10-11 05：12：33";
    }
    return _timeLabel;
}

- (UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.font = kFont12;
        _nameLabel.textColor = [UIColor blackColor];
        _nameLabel.text = @"上门录入资产";
    }
    return _nameLabel;
}
- (UILabel *)unitPriceLabel{
    if (!_unitPriceLabel) {
        _unitPriceLabel = [[UILabel alloc]init];
        _unitPriceLabel.font = kFont10;
        _unitPriceLabel.textColor = Color_Hex(@"666666");
        _unitPriceLabel.text = @"单价：88/次";
    }
    return _unitPriceLabel;
}

- (UILabel *)totalPriceLabel{
    if (!_totalPriceLabel) {
        _totalPriceLabel = [[UILabel alloc]init];
        _totalPriceLabel.font = kFont10;
        _totalPriceLabel.textColor = Color_Hex(@"ee530e");
        _totalPriceLabel.text = @"总价：99";
        _totalPriceLabel.textAlignment = NSTextAlignmentRight;
    }
    return _totalPriceLabel;
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

+ (CGFloat)getCellHieght{
    return 10 + 12 +20 + 12 + 5 +10 + 20 + 30 + 10;
}

- (void)setupSubViews{
    [self addSubview:self.orderNumber];
    [self addSubview:self.timeLabel];
    [self addSubview:self.nameLabel];
    [self addSubview:self.unitPriceLabel];
    [self addSubview:self.totalPriceLabel];
    [self addSubview:self.paymentButton];
    [self addSubview:self.paymentLabel];
    
    UIView *line1 = [[UIView alloc]init];
    line1.backgroundColor = kBorderColor;
    [self addSubview:line1];
    
    UIView *line2 = [[UIView alloc]init];
    line2.backgroundColor = kBorderColor;
    [self addSubview:line2];
    
    
    WS(weakSelf);
    [_orderNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.equalTo(weakSelf).offset(10);
        make.right.equalTo(weakSelf.mas_centerX);
        make.height.offset(12);
    }];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.mas_right).offset(- 10);
        make.height.offset(10);
        make.left.equalTo(weakSelf.mas_centerX);
        make.centerY.equalTo(weakSelf.orderNumber.mas_centerY);
    }];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.orderNumber.mas_bottom).offset(20);
        make.left.equalTo(weakSelf.orderNumber);
        make.right.equalTo(weakSelf.mas_right);
        make.height.offset(12);
    }];
    [_unitPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.nameLabel.mas_bottom).offset(5);
        make.height.offset(10);
        make.left.equalTo(weakSelf.orderNumber);
        make.width.offset(100);
    }];
    [_totalPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.mas_right).offset(- 10);
        make.height.offset(10);
        make.width.offset(100);
        make.centerY.equalTo(weakSelf.unitPriceLabel);
    }];
    [_paymentButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.mas_right).offset(- 10);
        make.width.offset(80);
        make.height.offset(30);
        make.top.equalTo(weakSelf.totalPriceLabel.mas_bottom).offset(20);
    }];
    [_paymentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.orderNumber);
        make.width.offset(200);
        make.centerY.equalTo(weakSelf.paymentButton.mas_centerY).offset(0);
        make.height.offset(14);
    }];
    
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf);
        make.right.equalTo(weakSelf.mas_right);
        make.top.equalTo(weakSelf.orderNumber.mas_bottom).offset(10);
        make.height.offset(0.5);
    }];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf);
        make.right.equalTo(weakSelf.mas_right);
        make.top.equalTo(weakSelf.unitPriceLabel.mas_bottom).offset(10);
        make.height.offset(0.5);
    }];
}

@end

