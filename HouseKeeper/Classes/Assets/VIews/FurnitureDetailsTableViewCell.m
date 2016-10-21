//
//  FurnitureDetailsTableViewCell.m
//  HouseKeeper
//
//  Created by 高泽民 on 16/10/14.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "FurnitureDetailsTableViewCell.h"

@implementation FurnitureDetailsTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupSubViews];
    }
    return self;
}

- (UIImageView *)logoImageView{
    if (!_logoImageView) {
        _logoImageView = [[UIImageView alloc]init];
    }
    return _logoImageView;
}

- (UILabel *)modelLabel{
    if (!_modelLabel) {
        _modelLabel = [UILabel new];
        _modelLabel.textColor = kText_Color;
        _modelLabel.font = kFont16;
    }
    return _modelLabel;
}

- (UILabel *)serialLabel{
    if (!_serialLabel) {
        _serialLabel = [[UILabel alloc]init];
        _serialLabel.textColor = Color_Hex(@"666666");
        _serialLabel.font = kFont14;
    }
    return _serialLabel;
}

- (void)setModel:(FurnitureModel *)model{
    _model = model;
    _modelLabel.text = model.model;
    _serialLabel.text = model.serial;
}

- (void)setupSubViews{
    [self addSubview:self.logoImageView];
    [self addSubview:self.modelLabel];
    [self addSubview:self.serialLabel];

    WS(weakSelf);
    [_logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).offset(10);
        make.top.equalTo(weakSelf).offset(10);
        make.width.offset(kScreen_Width / 3);
        make.bottom.equalTo(weakSelf.mas_bottom).offset(10);
    }];
    [_modelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.logoImageView).offset(10);
        make.left.equalTo(weakSelf.logoImageView.mas_right).offset(10);
        make.height.lessThanOrEqualTo(@20);
        make.right.equalTo(weakSelf.mas_right).offset(- 10);
    }];
    [_serialLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.modelLabel.mas_bottom).offset(20);
        make.left.equalTo(weakSelf.modelLabel);
        make.height.lessThanOrEqualTo(@100);
        make.right.equalTo(weakSelf.modelLabel.mas_right);
    }];
}

@end


@implementation FurnitureDetailsTableViewCell1

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupSubViews];
    }
    return self;
}

- (UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [UILabel new];
        _nameLabel.textColor = Color_Hex(@"666666");
        _nameLabel.font = kFont14;
    }
    return _nameLabel;
}

- (void)setupSubViews{
    [self addSubview:self.nameLabel];
    WS(weakSelf);
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.left.equalTo(weakSelf).offset(10);
        make.right.equalTo(weakSelf.mas_right).offset(- 10);
        make.height.equalTo(weakSelf.mas_height);
    }];
}

@end


@implementation FurnitureDetailsTableViewCell2

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupSubViews];
    }
    return self;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.textColor = Color_Hex(@"666666");
        _titleLabel.font = kFont14;
    }
    return _titleLabel;
}

- (UIImageView *)rightIcon{
    if (!_rightIcon) {
        _rightIcon = [[UIImageView alloc] initWithImage:Image(@"向右")];
        _rightIcon.contentMode = UIViewContentModeCenter;
    }
    return _rightIcon;
}

- (void)setupSubViews{
    [self addSubview:self.titleLabel];
    [self addSubview:self.rightIcon];
    WS(weakSelf);
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.left.equalTo(weakSelf).offset(10);
        make.width.lessThanOrEqualTo(@100);
        make.height.equalTo(weakSelf.mas_height);
    }];
    [_rightIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.and.height.offset(10);
        make.right.equalTo(weakSelf.mas_right).offset(- 10);
        make.centerY.equalTo(weakSelf.mas_centerY);
    }];
}

@end


@implementation FurnitureDetailsTableViewCell3

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}


@end
