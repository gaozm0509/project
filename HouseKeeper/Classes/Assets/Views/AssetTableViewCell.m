//
//  AssetTableViewCell.m
//  HouseKeeper
//
//  Created by gzm on 16/9/11.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "AssetTableViewCell.h"

#define kTextColor Color_Hex(@"000000")
#define kFont kFont13

@implementation AssetTableViewCell

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
        _titleLabel.text = @"客厅";
        _titleLabel.textColor = Color_Hex(@"666666");
        _titleLabel.font = kFont14;
    }
    return _titleLabel;
}

- (UIImageView *)rightIcon{
    if (!_rightIcon) {
        _rightIcon = [[UIImageView alloc]initWithImage:Image(@"向右按钮")];
    }
    return _rightIcon;
}

- (void)setRoomModel:(RoomModel *)roomModel{
    _roomModel = roomModel;
    _titleLabel.text = _roomModel.name;
}

- (void)setupSubViews{
    [self addSubview:self.titleLabel];
    [self addSubview:self.rightIcon];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.height.offset(14);
        make.width.lessThanOrEqualTo(@(kScreen_Width));
        make.centerY.equalTo(self.mas_centerY);
    }];
    [_rightIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(- 10);
        make.centerY.equalTo(self.mas_centerY);
        make.width.offset(6);
        make.height.offset(10);
    }];
}

@end



@implementation AssetTableViewFirstCell

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
        _titleLabel.text = @"客厅一";
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = kFont14;
    }
    return _titleLabel;
}

- (void)setRoomListModel:(RoomListModel *)roomListModel{
    _roomListModel = roomListModel;
    _titleLabel.text = roomListModel.name;
}

- (void)setupSubViews{
    [self addSubview:self.titleLabel];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.height.offset(14);
        make.width.lessThanOrEqualTo(@(kScreen_Width));
        make.centerY.equalTo(self.mas_centerY);
    }];
}

@end



@implementation AssetTableHeadViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupSubViews];
    }
    return self;
}

- (UIImageView *)leftImageView{
    if (!_leftImageView) {
        _leftImageView = [[UIImageView alloc]initWithImage:Image(@"地址")];
    }
    return _leftImageView;
}

- (UILabel *)communityLabel{
    if (!_communityLabel) {
        _communityLabel = [[UILabel alloc]init];
        _communityLabel.font = kFont;
        _communityLabel.textColor = kTextColor;
        _communityLabel.text = @"金地自在城3期  26栋206号";
    }
    return _communityLabel;
}

- (UILabel *)apartmentLabel{
    if (!_apartmentLabel) {
        _apartmentLabel = [[UILabel alloc] init];
        _apartmentLabel.font = kFont;
        _apartmentLabel.textColor = kTextColor;
        _apartmentLabel.text = @"B户型  2室2厅2卫";
    }
    return _apartmentLabel;
}

- (UILabel *)addressLabel{
    if (!_addressLabel) {
        _addressLabel = [[UILabel alloc]init];
        _addressLabel.font = kFont;
        _addressLabel.textColor = kTextColor;
        _addressLabel.text = @"松江－泗泾  松江区泗通路";
    }
    return _addressLabel;
}

- (UIButton *)collectionButton{
    if (!_collectionButton) {
        _collectionButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_collectionButton setTitle:@"前去采集" forState:UIControlStateNormal];
        [_collectionButton setTitleColor:KMajorColor forState:UIControlStateNormal];
        _collectionButton.titleLabel.font = kFont;
        _collectionButton.tag = 1001;
        [_collectionButton addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _collectionButton;
}

- (UIButton *)changeButton{
    if (!_changeButton) {
        _changeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_changeButton setTitle:@"更换" forState:UIControlStateNormal];
        [_changeButton setTitleColor:kTextColor forState:UIControlStateNormal];
        _changeButton.titleLabel.font = kFont;
        _changeButton.tag = 1002;
        [_changeButton addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _changeButton;
}

- (void)setModel:(StateModel *)model{
    _model = model;
    _addressLabel.text = _model.address;
    _apartmentLabel.text = _model.layout;
    _communityLabel.text = _model.residential;
}

#pragma parvit method
- (void)click:(UIButton *)button{
    switch (button.tag) {
        case 1001:
            [self.delegate assetCollection];
            break;
        case 1002:
            [self.delegate assetChange];
            break;
        default:
            break;
    }
}

- (void)setupSubViews{
    [self addSubview:self.communityLabel];
    [self addSubview:self.apartmentLabel];
    [self addSubview:self.addressLabel];
    [self addSubview:self.collectionButton];
//    [self addSubview:self.changeButton];
    
    [_communityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.width.lessThanOrEqualTo(@(kScreen_Width));
        make.height.mas_lessThanOrEqualTo(20);
        make.bottom.equalTo(self.mas_centerY).offset(- 5);
    }];
    [_apartmentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.communityLabel).offset(0);
        make.left.equalTo(self.communityLabel.mas_right).offset(10);
        make.width.lessThanOrEqualTo(@(kScreen_Width));
        make.height.mas_lessThanOrEqualTo(20);
    }];
    [_addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_centerY).offset(5);
        make.left.equalTo(self.communityLabel);
        make.width.lessThanOrEqualTo(@(kScreen_Width));
        make.height.mas_lessThanOrEqualTo(20);
    }];
    [_collectionButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(- 10);
        make.centerY.equalTo(self.addressLabel.mas_centerY);
        make.height.mas_lessThanOrEqualTo(20);
        make.width.mas_lessThanOrEqualTo(kScreen_Width);
    }];
}

@end
