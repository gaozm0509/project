//
//  OrderTopTableViewCell.m
//  HouseKeeper
//
//  Created by 高泽民 on 16/8/15.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "OrderTopTableViewCell.h"

@implementation OrderTopTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
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

+ (CGFloat)getHeight{
    return 50;
}

- (void)setupSubViews{
    [self addSubview:self.orderNumber];
    [self addSubview:self.timeLabel];
    
    WS(weakSelf);
    [_orderNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.width.offset(200);
        make.height.offset(12);
        make.left.equalTo(weakSelf);
    }];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.mas_right).offset(10);
        make.left.equalTo(weakSelf.orderNumber.mas_right);
        make.height.offset(12);
        make.centerY.equalTo(weakSelf.mas_centerY);
    }];
}

@end
