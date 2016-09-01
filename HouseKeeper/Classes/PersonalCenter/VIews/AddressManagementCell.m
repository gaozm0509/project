//
//  PersonalCenterCell.m
//  HouseKeeper
//
//  Created by 高泽民 on 16/7/16.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "AddressManagementCell.h"

#define kTextFont kFont12
#define kTextColor Color_Hex(@"323232")

@interface AddressManagementCell(){}

@end

@implementation AddressManagementCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupSubViews];
    }
    return self;
}

- (UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.text = @"王先生";
        _nameLabel.textColor = kTextColor;
        _nameLabel.font = kTextFont;
    }
    return _nameLabel;
}

- (UILabel *)phoneNumLabel{
    if (!_phoneNumLabel) {
        _phoneNumLabel = [[UILabel alloc]init];
        _phoneNumLabel.text = @"18036396675";
        _phoneNumLabel.textColor = kTextColor;
        _phoneNumLabel.font = kTextFont;
    }
    return _phoneNumLabel;
}

- (UILabel *)addressLabel{
    if (!_addressLabel) {
        _addressLabel = [[UILabel alloc]init];
        _addressLabel.textColor = kTextColor;
        _addressLabel.font = kTextFont;
        _addressLabel.font = [UIFont systemFontOfSize:12];
        _addressLabel.numberOfLines = 0;
        _addressLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _addressLabel.text = @"上海市浦东新区益丰路33弄";
    }
    return _addressLabel;
}

- (UIButton *)editButton{
    if (!_editButton) {
        _editButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_editButton setTitle:@"编辑" forState:UIControlStateNormal];
        [_editButton setTitleColor:kTextColor forState:UIControlStateNormal];
        _editButton.titleLabel.font = kTextFont;
        _editButton.tag = 1001;
    }
    return _editButton;
}

+ (CGFloat)getHieght{
    return 60;
}

- (void)setupSubViews{
    [self addSubview:self.nameLabel];
    [self addSubview:self.phoneNumLabel];
    [self addSubview:self.addressLabel];
    [self addSubview:self.editButton];
    
    WS(ws);
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws).offset(kMarginTop);
        make.left.equalTo(ws).offset(10);
        make.width.offset(50);
        make.height.offset(12);
    }];
    [_phoneNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(ws.nameLabel.mas_bottom);
        make.left.equalTo(ws.nameLabel.mas_right).offset(10);
        make.height.offset(12);
        make.width.offset(90);
    }];
    [_editButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(ws.mas_right).offset(- kMarginLeft);
        make.centerY.equalTo(ws.mas_centerY);
        make.width.offset(50);
    }];
    [_addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nameLabel.mas_bottom).offset(kMarginTop);
        make.height.offset(kAdreeHeight);
        make.left.equalTo(ws.nameLabel);
        make.right.equalTo(ws.editButton).offset(- kMarginLeft);
    }];
}


@end
