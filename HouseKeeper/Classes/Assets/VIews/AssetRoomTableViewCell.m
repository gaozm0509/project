//
//  AssetRoomTableViewCell.m
//  HouseKeeper
//
//  Created by 高泽民 on 16/9/11.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "AssetRoomTableViewCell.h"

@implementation AssetRoomTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupSubViews];
    }
    return self;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.text = @"挂式空调";
        _titleLabel.textColor = kText_Color;
        _titleLabel.font = kFont12;
    }
    return _titleLabel;
}

- (UILabel *)contentlabel{
    if (!_contentlabel) {
        _contentlabel = [[UILabel alloc]init];
        _contentlabel.textColor = Color_Hex(@"db7742");
        _contentlabel.font = kFont12;
    }
    return _contentlabel;
}

- (UILabel *)appliancesName{
    if (!_appliancesName) {
        _appliancesName = [[UILabel alloc]init];
        _appliancesName.text = @"QY-KFR";
        _appliancesName.textColor = Color_Hex(@"a4a4a4");
        _appliancesName.font = kFont12;
    }
    return _appliancesName;
}

- (UIImageView *)rightIcon{
    if (!_rightIcon) {
        _rightIcon = [[UIImageView alloc]initWithImage:Image(@"向右")];
    }
    return _rightIcon;
}

- (void)setModel:(FurnitureModel *)model{
    _model = model;
    _titleLabel.text = _model.name;
    _appliancesName.text = _model.model;
    _contentlabel.text = _model.schedule_description;
}

- (void)setupSubViews{
    [self addSubview:self.titleLabel];
    [self addSubview:self.contentlabel];
    [self addSubview:self.appliancesName];
    [self addSubview:self.rightIcon];
    
    WS(weakSelf);
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).offset(10);
        make.width.lessThanOrEqualTo(@(kScreen_Width));
        make.height.offset(12);
        make.top.offset(9);
    }];
    [_rightIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.mas_right).offset(- 10);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.width.offset(6);
        make.height.offset(12);
    }];
    [_contentlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.rightIcon.mas_left).offset(- 10);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.width.lessThanOrEqualTo(@(kScreen_Width));
        make.height.offset(12);
    }];
    [_appliancesName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.mas_bottom).offset(- 9);
        make.height.offset(12);
        make.width.lessThanOrEqualTo(@(kScreen_Width));
        make.left.equalTo(weakSelf.titleLabel);
    }];
    
}

@end


@implementation AssetRoomTableViewCell1

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupSubViews];
    }
    return self;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.text = @"挂式空调";
        _titleLabel.textColor = kText_Color;
        _titleLabel.font = kFont12;
    }
    return _titleLabel;
}

- (UILabel *)appliancesName{
    if (!_appliancesName) {
        _appliancesName = [[UILabel alloc]init];
        _appliancesName.text = @"QY-KFR";
        _appliancesName.textColor = Color_Hex(@"a4a4a4");
        _appliancesName.font = kFont12;
    }
    return _appliancesName;
}

- (UIImageView *)rightIcon{
    if (!_rightIcon) {
        _rightIcon = [[UIImageView alloc]initWithImage:Image(@"向右")];
    }
    return _rightIcon;
}

- (void)setModel:(FurnitureModel *)model{
    _model = model;
    _titleLabel.text = _model.name;
    _appliancesName.text = _model.model;
}

- (void)setupSubViews{
    [self addSubview:self.titleLabel];
    [self addSubview:self.appliancesName];
    [self addSubview:self.rightIcon];
    
    WS(weakSelf);
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).offset(10);
        make.width.lessThanOrEqualTo(@(kScreen_Width));
        make.height.offset(12);
        make.top.offset(9);
    }];
    [_rightIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.mas_right).offset(- 10);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.width.offset(6);
        make.height.offset(12);
    }];
    [_appliancesName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.mas_bottom).offset(- 9);
        make.height.offset(12);
        make.width.lessThanOrEqualTo(@(kScreen_Width));
        make.left.equalTo(weakSelf.titleLabel);
    }];
}

@end

