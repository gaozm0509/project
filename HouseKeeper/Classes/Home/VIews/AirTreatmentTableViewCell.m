//
//  AirTreatmentTableViewCell.m
//  HouseKeeper
//
//  Created by 高泽民 on 16/11/1.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "AirTreatmentTableViewCell.h"

#define kContentText @"1、专业空气检测治理人员上门进行房屋空气检测\n2、出具房屋空气检测报告\n3、使用专业仪器及药剂对房屋进行深入空气治理\n4、治理完成后给予用户相关专业治理证明"

@implementation AirTreatmentTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupSubViews];
    }
    return self;
}

- (UILabel *)titleLbael{
    if (!_titleLbael) {
        _titleLbael = [[UILabel alloc] init];
        _titleLbael.textColor = kText_Color;
        _titleLbael.font = kFont14;
    }
    return _titleLbael;
}

- (UILabel *)rightTitleLabel{
    if (!_rightTitleLabel) {
        _rightTitleLabel = [[UILabel alloc] init];
        _rightTitleLabel.textColor = kText_Color;
        _rightTitleLabel.font = kFont14;
        _rightTitleLabel.textAlignment = NSTextAlignmentRight;
    }
    return _rightTitleLabel;
}

- (UIView *)line{
    if (!_line) {
        _line = [[UIView alloc] init];
        _line.backgroundColor = kBorderColor;
    }
    return _line;
}

- (UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.textColor = kText_Color;
        _contentLabel.font = kFont14;
        _contentLabel.text = kContentText;
        _contentLabel.numberOfLines = 0;
        _contentLabel.lineBreakMode = NSLineBreakByCharWrapping;
    }
    return _contentLabel;
}

-(void)setModel:(DoorEntryModel *)model{
    _model = model;
    _titleLbael.text = [NSString stringWithFormat:@"限定%@元/套",_model.price];
    _rightTitleLabel.text = [NSString stringWithFormat:@"优惠价%@元/套",_model.price];
    
}

- (void)setupSubViews{
    [self addSubview:self.titleLbael];
    [self addSubview:self.rightTitleLabel];
    [self addSubview:self.line];
    [self addSubview:self.contentLabel];
    
    [_titleLbael mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(12.5);
        make.left.equalTo(self).offset(10);
        make.width.lessThanOrEqualTo(@(kScreen_Width));
        make.height.offset(20);
    }];
    [_rightTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(- 10);
        make.centerY.equalTo(_titleLbael.mas_centerY);
        make.width.lessThanOrEqualTo(@(kScreen_Width));
        make.height.offset(20);
    }];
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.right.equalTo(self.mas_right);
        make.height.offset(0.5);
        make.top.equalTo(_titleLbael.mas_bottom).offset(12.5);
    }];
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(- 10);
        make.left.equalTo(self).offset(10);
        make.bottom.equalTo(self.mas_bottom).offset(- 5);
        make.top.equalTo(_line.mas_bottom).offset(5);
    }];
}

+ (CGFloat)getHeight{
    CGFloat height = [kContentText sizeWithFont:kFont14 Size:CGSizeMake(kScreen_Width - 20, kScreen_Height)].height;
    CGFloat topViewHeight = 45;
    return height + topViewHeight + 20;
}

@end
