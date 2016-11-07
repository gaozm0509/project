//
//  DoorEntryTableViewCell.m
//  HouseKeeper
//
//  Created by 高泽民 on 16/10/28.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "DoorEntryTableViewCell.h"

@implementation DoorEntryTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupSubViews];
    }
    return self;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"上门资产录入";
        _titleLabel.textColor = kText_Color;
        _titleLabel.font = kFont14;
    }
    return _titleLabel;
}

- (UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.text = @"99元上门费";
        _contentLabel.textAlignment = NSTextAlignmentCenter;
        _contentLabel.textColor = kText_Color;
        _contentLabel.font = kFont14;
    }
    return _contentLabel;
}

- (UIButton *)selectButton{
    if (!_selectButton) {
        _selectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_selectButton setImage:Image(@"service_勾选选中") forState:UIControlStateSelected];
        [_selectButton setImage:Image(@"service_勾选未选中") forState:UIControlStateNormal];
    }
    return _selectButton;
}

- (void)setupSubViews{
    [self addSubview:self.titleLabel];
    [self addSubview:self.contentLabel];
    [self addSubview:self.selectButton];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.width.lessThanOrEqualTo(@(kScreen_Width));
        make.height.lessThanOrEqualTo(@20);
        make.centerY.equalTo(self.mas_centerY);
    }];
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.lessThanOrEqualTo(@(kScreen_Width));
        make.height.lessThanOrEqualTo(@20);
    }];
    [_selectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(- 10);
        make.width.and.height.lessThanOrEqualTo(@44);
        make.centerY.equalTo(self.mas_centerY);
    }];
}

@end

@implementation DoorEntryTableViewCell1

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupSubViews];
    }
    return self;
}

- (UIImageView *)imgView{
    if (!_imgView) {
        _imgView = [[UIImageView alloc] initWithImage:Image(@"")];
    }
    return _imgView;
}

- (UILabel *)descriptionLabel{
    if (!_descriptionLabel) {
        _descriptionLabel = [[UILabel alloc] init];
        _descriptionLabel.text = @"深度录入";
        _descriptionLabel.textColor = kText_Color;
        _descriptionLabel.font = kFont14;
        _descriptionLabel.numberOfLines = 0;
        _descriptionLabel.lineBreakMode = NSLineBreakByCharWrapping;
    }
    return _descriptionLabel;
}

- (UILabel *)feeLabel{
    if (!_feeLabel) {
        _feeLabel = [[UILabel alloc] init];
        _feeLabel.textColor = kText_Color;
        _feeLabel.font = kFont14;
        _feeLabel.textAlignment = NSTextAlignmentRight;
        _feeLabel.text = @"上门服务只需299";
    }
    return _feeLabel;
}

- (void)setModel:(DoorEntryModel *)model{
    _model = model;
    if (_model.id.integerValue == 1) {
        _descriptionLabel.text = @"房屋资产录入，用专业的技术手段和方式，对家庭所有设备进行产品型号，详细数据的录入";
    }
    else{
        _descriptionLabel.text = @"房屋深度资产录入，用专业的技术手段和方式，对家庭所有的设备进行产品型号、详细数据的录入，检测评估设备数据，并进行室内空气质量检测与治理";
    }
    _feeLabel.text = [NSString stringWithFormat:@"上门服务费只需%@",_model.price];
}

- (void)setupSubViews{
    [self addSubview:self.imgView];
    [self addSubview:self.descriptionLabel];
    [self addSubview:self.feeLabel];
    
    [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.top.equalTo(self).offset(10);
        make.width.equalTo(_imgView.mas_height);
        make.bottom.equalTo(self.mas_bottom).offset(- 10);
    }];
    [_feeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(- 10);
        make.left.equalTo(_imgView.mas_right).offset(25);
        make.height.lessThanOrEqualTo(@20);
        make.bottom.equalTo(_imgView.mas_bottom);
    }];
    [_descriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_imgView.mas_right).offset(25);
        make.right.equalTo(self.mas_right).offset(- 10);
        make.top.equalTo(_imgView);
        make.bottom.lessThanOrEqualTo(_imgView.mas_bottom);
    }];
}

@end
