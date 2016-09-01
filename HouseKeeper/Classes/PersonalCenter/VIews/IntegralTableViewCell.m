//
//  IntegralTableViewCell.m
//  HouseKeeper
//
//  Created by 高泽民 on 16/8/11.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "IntegralTableViewCell.h"

@implementation IntegralTableViewCell

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
        [self setupSubView];
    }
    return self;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = Color_Hex(@"323232");
        _titleLabel.font = kFont12;
        _titleLabel.text = @"地毯洗涤";
    }
    return _titleLabel;
}

- (UILabel *)integrallabel{
    if (!_integrallabel) {
        _integrallabel = [[UILabel alloc]init];
        _integrallabel.textColor = Color_Hex(@"323232");
        _integrallabel.font = kFont12;
        _integrallabel.textAlignment = NSTextAlignmentRight;
        _integrallabel.text = @"获得积分：100";
    }
    return _integrallabel;
}

- (UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.textColor = Color_Hex(@"a4a4a4");
        _timeLabel.font = kFont10;
        _timeLabel.text = @"2016-03-02 12:33:22";
    }
    return _timeLabel;
}

- (void)setupSubView{
    [self addSubview:self.timeLabel];
    [self addSubview:self.titleLabel];
    [self addSubview:self.integrallabel];
    
    WS(weakSelf);
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf).offset(10);
        make.left.equalTo(weakSelf).offset(10);
        make.height.offset(12);
        make.right.equalTo(weakSelf.mas_centerX);
    }];
    [_integrallabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.mas_right).offset(- 10);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.left.equalTo(weakSelf.mas_centerX);
        make.height.offset(12);
    }];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.mas_bottom).offset(- 10);
        make.left.equalTo(weakSelf).offset(10);
        make.height.offset(10);
        make.right.equalTo(weakSelf.mas_centerX);
    }];
}

+ (CGFloat)getCellHeight{
    return 50;
}

@end
