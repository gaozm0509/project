//
//  BalanceTableViewCell.m
//  HouseKeeper
//
//  Created by 高泽民 on 16/7/19.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "BalanceTableViewCell.h"


@implementation BalanceTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupSubViews];
    }
    return self;
}

- (UILabel *)typeLabel{
    if (!_typeLabel) {
        _typeLabel = [self normalLabel];
        _typeLabel.text = @"微信支付";
        _typeLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _typeLabel;
}

- (UILabel *)moneylabel{
    if (!_moneylabel) {
        _moneylabel = [self normalLabel];
        _moneylabel.text = @"500元";
        _moneylabel.textAlignment = NSTextAlignmentRight;
    }
    return _moneylabel;
}

- (UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [self normalLabel];
        _timeLabel.text = @"2014-02-24 07：27：34";
        _timeLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _timeLabel;
}

- (UILabel *)numberLabel{
    if (!_numberLabel) {
        _numberLabel = [self normalLabel];
        _numberLabel.text = @"交易号：1995784";
        _numberLabel.textAlignment = NSTextAlignmentRight;
    }
    return _numberLabel;
}

- (UILabel *)normalLabel{
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:12];
    label.textColor = [UIColor blackColor];
    return label;
}

- (void)setupSubViews{
    [self addSubview:self.typeLabel];
    [self addSubview:self.moneylabel];
    [self addSubview:self.timeLabel];
    [self addSubview:self.numberLabel];
    
    WS(ws);
    [_typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws).offset(kMarginTop);
        make.left.equalTo(ws).offset(kMarginLeft);
        make.right.equalTo(ws.mas_centerX);
        make.height.offset(kHeight);
    }];
    [_moneylabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(ws.typeLabel.mas_centerY);
        make.right.equalTo(ws.mas_right).offset(-10);
        make.height.offset(kHeight);
        make.left.equalTo(ws.mas_centerX);
    }];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.typeLabel.mas_bottom).offset(kMarginTop);
        make.left.equalTo(ws).offset(kMarginLeft);
        make.right.equalTo(ws.mas_centerX);
        make.height.offset(kHeight);
    }];
    [_numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(ws.timeLabel.mas_centerY);
        make.right.equalTo(ws.mas_right).offset(-10);
        make.height.offset(kHeight);
        make.left.equalTo(ws.mas_centerX);
    }];
}

@end
