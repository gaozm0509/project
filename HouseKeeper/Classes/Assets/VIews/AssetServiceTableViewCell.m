//
//  AssetServiceTableViewCell.m
//  HouseKeeper
//
//  Created by 高泽民 on 16/10/17.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "AssetServiceTableViewCell.h"

@implementation AssetServiceTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupSubViews];
    }
    return self;
}

- (UIImageView *)loctionIcon{
    if (!_loctionIcon) {
        _loctionIcon = [[UIImageView alloc] initWithImage:Image(@"地址管理")];
        _loctionIcon.contentMode = UIViewContentModeCenter;
    }
    return _loctionIcon;
}

- (UILabel *)phoneLabel{
    if (!_phoneLabel ) {
        _phoneLabel = [[UILabel alloc]init];
        _phoneLabel.font = kFont14;
        _phoneLabel.textColor = kText_Color;
    }
    return _phoneLabel;
}

- (UILabel *)loctionLabel{
    if (!_loctionLabel) {
        _loctionLabel = [[UILabel alloc] init];
        _loctionLabel.font = kFont14;
        _loctionLabel.textColor = kText_Color;
    }
    return _loctionLabel;
}

- (void)setupSubViews{
    [self addSubview:self.loctionIcon];
    [self addSubview:self.loctionLabel];
    [self addSubview:self.phoneLabel];
    
    WS(weakSelf);
    [_loctionIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).offset(10);
        make.width.and.height.offset(40);
        make.centerY.equalTo(weakSelf.mas_centerY);
    }];
    [_phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.loctionIcon.mas_right).offset(10);
        make.bottom.equalTo(weakSelf.mas_centerY);
        make.height.offset(20);
        make.width.lessThanOrEqualTo(@(kScreen_Width));
    }];
    [_loctionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.loctionIcon.mas_right).offset(10);
        make.top.equalTo(weakSelf.mas_centerY);
        make.height.offset(20);
        make.width.lessThanOrEqualTo(@(kScreen_Width));
    }];
}

@end

@implementation AssetServiceTableViewCell1

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupSubViews];
    }
    return self;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 90, 45)];
        _titleLabel.font = kFont14;
        _titleLabel.text = @"选择服务类型";
        _titleLabel.textColor = kText_Color;
    }
    return _titleLabel;
}

- (UIButton *)maintenanceButton{
    if (!_maintenanceButton) {
        _maintenanceButton = [[UIButton alloc]initWithFrame:CGRectMake(100, 0, 70, 45) horizontal:5 title:@"保养" image:Image(@"勾选选中") font:kFont14];
        [_maintenanceButton setTitleColor:kText_Color forState:UIControlStateSelected];
        [_maintenanceButton setTitleColor:Color_Hex(@"666666") forState:UIControlStateNormal];
        [_maintenanceButton setImage:Image(@"勾选未选中") forState:UIControlStateNormal];
        [_maintenanceButton setImage:Image(@"勾选选中") forState:UIControlStateSelected];
        _maintenanceButton.selected = YES;
        [_maintenanceButton addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        _maintenanceButton.tag = 1001;
    }
    return _maintenanceButton;
}

- (UIButton *)warrantyButton{
    if (!_warrantyButton) {
        _warrantyButton = [[UIButton alloc]initWithFrame:CGRectMake(180, 0, 70, 45) horizontal:5 title:@"保修" image:Image(@"勾选未选中") font:kFont14];
        [_warrantyButton setTitleColor:kText_Color forState:UIControlStateSelected];
        [_warrantyButton setTitleColor:Color_Hex(@"666666") forState:UIControlStateNormal];
        [_warrantyButton setImage:Image(@"勾选未选中") forState:UIControlStateNormal];
        [_warrantyButton setImage:Image(@"勾选选中") forState:UIControlStateSelected];
        _warrantyButton.selected = NO;
        [_warrantyButton addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        _warrantyButton.tag = 1002;
    }
    return _warrantyButton;
}

- (void)click:(UIButton *)button{
    _maintenanceButton.selected = !_maintenanceButton.selected;
    _warrantyButton.selected = !_warrantyButton.selected;
    [self.delegate chosenMaintenanceOrWarrantyButton:_maintenanceButton.selected];
}

- (void)setupSubViews{
    [self addSubview:self.titleLabel];
    [self addSubview:self.maintenanceButton];
    [self addSubview:self.warrantyButton];
}

@end
