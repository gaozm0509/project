//
//  AssetTableViewCell.m
//  HouseKeeper
//
//  Created by gzm on 16/9/11.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "AssetTableViewCell.h"

#define kTextColor Color_Hex(@"323232")
#define kFont kFont12

@implementation AssetTableViewCell


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
        _leftImageView = [[UIImageView alloc]initWithImage:UIImage(@"地址")];
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
        _addressLabel.text = @"B户型  2室2厅2卫";
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

#pragma parvit method
- (void)click:(UIButton *)button{

}

- (void)setupSubViews{
    [self addSubview:self.leftImageView];
    [self addSubview:self.communityLabel];
    [self addSubview:self.apartmentLabel];
    [self addSubview:self.addressLabel];
    [self addSubview:self.collectionButton];
    [self addSubview:self.changeButton];
    
    WS(weakSelf)
    [_leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).offset(10);
        make.top.equalTo(weakSelf).offset(10);
        make.width.and.height.offset(60);
    }];
    [_communityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.leftImageView.mas_right).offset(10);
        make.width.lessThanOrEqualTo(@(kScreen_Width));
        make.height.offset(12);
        make.top.equalTo(weakSelf).offset(15);
    }];
    [_apartmentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.communityLabel.mas_bottom).offset(10);
        make.left.equalTo(weakSelf.communityLabel);
        make.width.lessThanOrEqualTo(@(kScreen_Width));
        make.height.offset(12);
    }];
    [_addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.apartmentLabel.mas_bottom).offset(10);
        make.left.equalTo(weakSelf.communityLabel);
        make.width.lessThanOrEqualTo(@(kScreen_Width));
        make.height.offset(12);
    }];
    [_collectionButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.mas_right).offset(- 10);
        make.centerY.equalTo(weakSelf.communityLabel.mas_centerY);
        make.height.offset(30);
        make.width.lessThanOrEqualTo(@50);
    }];
    [_changeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.mas_right).offset(- 10);
        make.centerY.equalTo(weakSelf.addressLabel.mas_centerY);
        make.height.offset(30);
        make.width.offset(30);
    }];
}

@end