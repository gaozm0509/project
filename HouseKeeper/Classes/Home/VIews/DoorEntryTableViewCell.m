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

static NSString * const descriptionLabelTest1 = @"房屋资产录入，用专业的技术手段和方式，对家庭所有设备进行产品型号，详细数据的录入";

static NSString * const descriptionLabelTest2 = @"房屋深度资产录入，用专业的技术手段和方式，对家庭所有的设备进行产品型号、详细数据的录入，检测评估设备数据，并进行室内空气质量检测与治理";

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
        _imgView = [[UIImageView alloc] initWithImage:Image(@"smlr_buttom")];
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
        _descriptionLabel.text = descriptionLabelTest1;
    }
    else{
        _descriptionLabel.text = descriptionLabelTest2;
    }
    _feeLabel.text = [NSString stringWithFormat:@"上门服务费只需%@",_model.price];
    [self layoutIfNeeded];
}

- (void)setupSubViews{
    [self addSubview:self.imgView];
    [self addSubview:self.descriptionLabel];
    [self addSubview:self.feeLabel];
    
    
    [_feeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(- 10);
        make.left.equalTo(_imgView.mas_right).offset(25);
        make.height.lessThanOrEqualTo(@20);
        make.bottom.equalTo(self.mas_bottom).offset(- 10);
    }];
    [_descriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(115);
        make.right.equalTo(self.mas_right).offset(- 10);
        make.top.equalTo(self).offset(10);
        make.bottom.lessThanOrEqualTo(self.feeLabel.mas_top).offset(10);
    }];
    [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.right.equalTo(_descriptionLabel.mas_left).offset(-10);
        make.centerY.equalTo(self.mas_centerY);
        make.top.equalTo(self.descriptionLabel);
    }];
}

+ (CGFloat)getHieghtWithModel:(DoorEntryModel *)model{
//    NSString *text;
//    if (model.id.integerValue == 1) {
//        text = descriptionLabelTest1;
//    }
//    else{
//        text = descriptionLabelTest2;
//    }
    //数据分别为，左边距、imageView的宽度、imageView和_descriptionLabel的间距、右边距
    CGFloat height = [descriptionLabelTest2 getHeightWithFont:kFont14 constrainedToSize:CGSizeMake(kScreen_Width - 10 - 80 - 25 - 10, kScreen_Height)];
    //数字对应为，上边距、_feeLabel和_descriptionLabel的距离、_feeLabel的高度、下边距
    return height + 10 + 10 + 15 + 10;
}

@end
