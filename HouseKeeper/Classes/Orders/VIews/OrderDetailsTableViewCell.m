//
//  OrderDetailsTableViewCell.m
//  HouseKeeper
//
//  Created by 高泽民 on 16/9/14.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "OrderDetailsTableViewCell.h"

static const CGFloat leftViewWidth = 7;

@implementation OrderDetailsTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupSubViews];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = kFont14;
        _titleLabel.textColor = kText_Color;
    }
    return _titleLabel;
}

- (UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.font = kFont12;
        _contentLabel.textColor = Color_Hex(@"666666");
    }
    return _contentLabel;
}

- (UIView *)leftLineView{
    if (!_leftLineView) {
        _leftLineView = [[UIView alloc] init];
        _leftLineView.backgroundColor = KMajorColor;
    }
    return _leftLineView;
}

- (UIView *)leftView{
    if (!_leftView) {
        _leftView = [[UIView alloc] init];
        _leftView.backgroundColor = KMajorColor;
        _leftView.layer.cornerRadius = leftViewWidth / 2;
    }
    return _leftView;
}


- (void)setupSubViews{
    [self addSubview:self.titleLabel];
    [self addSubview:self.contentLabel];
    [self addSubview:self.leftView];
    [self addSubview:self.leftLineView];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(25);
        make.height.mas_lessThanOrEqualTo(20);
        make.right.equalTo(self.mas_right).offset(- 10);
        make.top.equalTo(self).offset(10);
    }];
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(25);
        make.height.mas_lessThanOrEqualTo(20);
        make.right.equalTo(self.mas_right).offset(- 10);
        make.bottom.equalTo(self.mas_bottom).offset(- 10);
    }];
    [_leftLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.width.offset(2);
    }];
    [_leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.leftLineView.mas_centerX);
        make.width.offset(leftViewWidth);
        make.height.offset(leftViewWidth);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
}

- (void)setIsLastRow:(BOOL)isLastRow{
    _isLastRow = isLastRow;
    if (_isLastRow) {
        self.titleLabel.textColor = KMajorColor;
        
        [_leftView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.offset(leftViewWidth * 2);
            make.height.offset(leftViewWidth * 2);
        }];
        _leftView.layer.cornerRadius = leftViewWidth;
        
        [_leftLineView mas_updateConstraints:^(MASConstraintMaker *make) {
            if (_isFirstRow) {
                make.top.equalTo(self.mas_centerY);
            }
            else{
                make.top.equalTo(self.mas_top);
            }
            make.bottom.equalTo(self.mas_centerY);
        }];
    }
    else{
        [_leftView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.offset(leftViewWidth);
            make.height.offset(leftViewWidth);
        }];
        _leftView.layer.cornerRadius = leftViewWidth / 2;
        
        [_leftLineView mas_updateConstraints:^(MASConstraintMaker *make) {
            if (_isFirstRow) {
                make.top.equalTo(self.mas_centerY);
            }
            else{
                make.top.equalTo(self.mas_top);
            }
            make.bottom.equalTo(self.mas_bottom);
        }];
    }
    
    [self layoutIfNeeded];
    
    
}

- (void)setTextWithIndex:(NSInteger)index{
    switch (index) {
        case 0:{
            self.titleLabel.text = @"订单已提交";
            self.contentLabel.text = @"请耐心等待管理女士确认";
            break;
        }
        case 1:{
            self.titleLabel.text = @"支付";
            self.contentLabel.text = @"";
            break;
        }
        case 2:{
            self.titleLabel.text = @"客服确认";
            self.contentLabel.text = @"";
            break;
        }
        case 3:{
            self.titleLabel.text = @"管家女士已接单";
            self.contentLabel.text = @"";
            break;
        }
        case 4:{
            self.titleLabel.text = @"人员分配完成";
            self.contentLabel.text = @"请耐心等待管理女士确认";
            break;
        }
        case 5:{
            self.titleLabel.text = @"商价";
            self.contentLabel.text = @"";
            break;
        }
        case 6:{
            self.titleLabel.text = @"服务中";
            self.contentLabel.text = @"请耐心等待服务完成";
            break;
        }
        case 7:{
            self.titleLabel.text = @"验收";
            self.contentLabel.text = @"";
            break;
        }
        case 8:{
            self.titleLabel.text = @"订单完成";
            self.contentLabel.text = @"";
            break;
        }
        default:
            break;
    }
}

@end
