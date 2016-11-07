//
//  BottomOrderView.m
//  HouseKeeper
//
//  Created by 高泽民 on 16/11/2.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "BottomOrderView.h"

#define kOrderButtonWidth 80

@implementation BottomOrderView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.borderColor = kBorderColor.CGColor;
        self.layer.borderWidth = 0.5;
        _sum = 0;
        [self setupSubViews];
    }
    return self;
}

- (UILabel *)label{
    if (!_label) {
        _label = [[UILabel alloc] init];
    }
    return _label;
}

- (UIView *)line{
    if (!_line) {
        _line = [[UIView alloc] init];
        _line.backgroundColor = KMajorColor;
    }
    return _line;
}

- (UIButton *)orderButton{
    if (!_orderButton) {
        _orderButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_orderButton setTitleColor:KMajorColor forState:UIControlStateNormal];
        [_orderButton setTitle:@"下单" forState:UIControlStateNormal];
        _orderButton.titleLabel.font = kFont14;
        [_orderButton addTarget:self action:@selector(orderButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _orderButton;
}

- (void)setSum:(NSString *)sum{
    _sum = sum;
    
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@：",_orderTitle] attributes:@{NSFontAttributeName:kFont14,NSForegroundColorAttributeName:Color_Hex(@"666666")}];
    NSMutableAttributedString *value = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@元",_sum] attributes:@{NSFontAttributeName:kFont14,NSForegroundColorAttributeName:KMajorColor}];
    [text appendAttributedString:value];
    _label.attributedText = text;
}

- (void)orderButtonClick{
    if (self.orderAction) {
        self.orderAction(_sum);
    }
}

- (void)setupSubViews{
    [self addSubview:self.label];
    [self addSubview:self.line];
    [self addSubview:self.orderButton];
    
    [_orderButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self);
        make.bottom.equalTo(self.mas_bottom);
        make.width.offset(kOrderButtonWidth);
    }];
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.orderButton.mas_left).offset(0);
        make.top.equalTo(self).offset(10);
        make.centerY.equalTo(self.mas_centerY);
        make.width.offset(1);
    }];
    [_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.top.equalTo(self);
        make.bottom.equalTo(self.mas_bottom);
        make.width.lessThanOrEqualTo(@(kScreen_Width));
    }];
}

@end
