//
//  PersonalCenterTableViewCell.m
//  HouseKeeper
//
//  Created by 高泽民 on 16/7/26.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "PersonalCenterTableViewCell.h"



@implementation PersonalCenterTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupSubView];
    }
    return self;
}

- (UIImageView *)leftIcon{
    if (!_leftIcon) {
        _leftIcon = [[UIImageView alloc]initWithImage:[UIImage imageWithColor:[UIColor redColor]]];
    }
    return _leftIcon;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = kTextFont;
        _titleLabel.textColor = kTextColor;
    }
    return _titleLabel;
}



- (UIImageView *)rightIcon{
    if (!_rightIcon) {
        _rightIcon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"向右"]];
    }
    return _rightIcon;
}


- (UILabel *)rightLabel{
    if (!_rightLabel) {
        _rightLabel = [[UILabel alloc] init];
        _rightLabel.font = kFont14;
        _rightLabel.textColor = kText_Color;
        _rightLabel.text = @"暂无";
    }
    return _rightLabel;
}


- (void)setupSubView{
    [self addSubview:self.leftIcon];
    [self addSubview:self.titleLabel];
    [self addSubview:self.rightIcon];
    [self addSubview:self.rightLabel];
    
    WS(weakSelf);
    [_leftIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).offset(kMarginLeft);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.width.offset(15);
        make.height.offset(15);
    }];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.leftIcon.mas_right).offset(kMarginLeft);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.width.offset(200);
        make.top.equalTo(weakSelf);
    }];
    [_rightIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.mas_right).offset(- kMarginLeft);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.height.offset(10);
        make.width.offset(6);
    }];
    [_rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.rightIcon.mas_left).offset(- 5);
        make.width.mas_lessThanOrEqualTo(kScreen_Width);
        make.height.mas_lessThanOrEqualTo(20);
        make.centerY.equalTo(self.mas_centerY);
    }];
  
}

@end

@implementation PersonalCenterTableViewTopCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellEditingStyleNone;
        [self setupSubViews];
    }
    return self;
}

- (UIImageView *)headImage{
    if (!_headImage) {
        _headImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"dddddd"]];
        _headImage.layer.cornerRadius = kHeadWidht / 2;
        _headImage.layer.masksToBounds = YES;
        _headImage.layer.borderWidth = 1;
        _headImage.layer.borderColor = KMajorColor.CGColor;
        _headImage.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(avatarClick)];
        [_headImage addGestureRecognizer:gesture];
    }
    return _headImage;
}

- (UILabel *)nameLabel{
    if (!_nameLabel ) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.text = @"用户名：明明";
        _nameLabel.textColor = KMajorColor;
        _nameLabel.font = [UIFont systemFontOfSize:14];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _nameLabel;
}

- (UILabel *)phoneLabel{
    if (!_phoneLabel) {
        _phoneLabel = [[UILabel alloc]init];
        _phoneLabel.text = @"手机号：18036396675";
        _phoneLabel.textColor = KMajorColor;
        _phoneLabel.font = [UIFont systemFontOfSize:14];
        _phoneLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _phoneLabel;
}

- (CustomView *)balanceView{
    if (!_balanceView) {
        _balanceView = [[CustomView alloc]init];
        _balanceView.image = [UIImage imageNamed:@"余额"];
        _balanceView.valueLabel.text = @"1090元";
        [_balanceView addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        _balanceView.tag = 1001;
    }
    return _balanceView;
}

- (CustomView *)couponView{
    if (!_couponView) {
        _couponView = [[CustomView alloc]init];
        _couponView.image = [UIImage imageNamed:@"优惠卷"];
        _couponView.valueLabel.text = @"3张";
        _couponView.tag = 1002;
        [_couponView addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _couponView;
}

- (CustomView *)integralView{
    if (!_integralView) {
        _integralView = [[CustomView alloc]init];
        _integralView.image = [UIImage imageNamed:@"积分"];
        _integralView.valueLabel.text = @"1000管家币";
        _integralView.tag = 1003;
        [_integralView addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _integralView;
}

- (UIView *)bottomLine{
    if (!_bottomLine) {
        _bottomLine = [[UIView alloc]init];
        _bottomLine.backgroundColor = kBorderColor;
    }
    return _bottomLine;
}

- (void)setModel:(UserAccout *)model{
    _model = model;
    [_headImage sd_setImageWithURL:[NSURL URLWithString:_model.avatar] placeholderImage:kPlaceholderImage];
    _balanceView.valueLabel.text = [NSString stringWithFormat:@"%.2f元",_model.balance.floatValue];
    _nameLabel.text = _model.name;
    _phoneLabel.text = _model.mobile;
    _couponView.valueLabel.text = [NSString stringWithFormat:@"%ld张",_model.couponNumbers];
    
}

- (void)setupSubViews{
    [self addSubview:self.headImage];
    [self addSubview:self.nameLabel];
    [self addSubview:self.phoneLabel];
    
    [self addSubview:self.balanceView];
    [self addSubview:self.couponView];
//    [self addSubview:self.integralView];
    
    [self addSubview:self.bottomLine];
    
    WS(weakSelf);
    [_headImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf).offset(12 + 20);
        make.height.offset(kHeadWidht);
        make.width.offset(kHeadWidht);
        make.centerX.equalTo(weakSelf.mas_centerX);
    }];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.headImage.mas_bottom).offset(25);
        make.height.offset(14);
        make.width.offset(kScreen_Width);
        make.centerX.equalTo(weakSelf.mas_centerX);
    }];
    [_phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.nameLabel.mas_bottom).offset(15);
        make.height.offset(14);
        make.width.offset(kScreen_Width);
        make.centerX.equalTo(weakSelf.mas_centerX);
    }];
    
    [_balanceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(kScreen_Width / 4 - kScreen_Width / 8);
        make.top.equalTo(weakSelf.phoneLabel.mas_bottom).offset(30);
        make.width.and.height.offset(kScreen_Width / 4);
        
    }];
    [_couponView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(- (kScreen_Width / 4 - kScreen_Width / 8));
        make.width.and.height.offset(kScreen_Width / 4);
        make.top.equalTo(weakSelf.phoneLabel.mas_bottom).offset(30);
    }];
//    [_integralView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(weakSelf.phoneLabel.mas_bottom).offset(30);
//        make.bottom.equalTo(weakSelf.mas_bottom).offset(- 15);
//        make.right.equalTo(weakSelf.mas_right);
//        make.width.offset(kScreen_Width /3);
//    }];
    [_bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).offset(10);
        make.right.equalTo(weakSelf.mas_right).offset(- 10);
        make.bottom.equalTo(weakSelf.mas_bottom);
        make.height.offset(0.5);
    }];
}

- (void)click:(UIButton *)button{
    [self.delegate click:button.tag - 1001];
}

- (void)avatarClick{
    [self.delegate click:4];
}

+ (CGFloat)getHieght{
    return 12 + kHeadWidht + 25 +14 +15 + 14 + 30 + 45 + 68 + 7.5;
}

@end

@implementation CustomView

- (instancetype)init{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupSubViews];
    }
    return self;
}

- (UILabel *)valueLabel{
    if (!_valueLabel) {
        _valueLabel = [[UILabel alloc]init];
        _valueLabel.textColor = Color_Hex(@"323232");
        _valueLabel.font = [UIFont systemFontOfSize:14];
        _valueLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _valueLabel;
}

- (UILabel *)titlelabel{
    if (!_titlelabel) {
        _titlelabel = [[UILabel alloc]init];
        _titlelabel.textColor = Color_Hex(@"666666");
        _titlelabel.font = [UIFont systemFontOfSize:12];
        _titlelabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titlelabel;
}

- (UIImageView *)img{
    if (!_img) {
        _img = [[UIImageView alloc]init];
    }
    return _img;
}

- (void)setImage:(UIImage *)image{
    _img.image = image;
    WS(weakSelf);
    [_img mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.width.offset(image.size.width);
        make.top.equalTo(weakSelf);
        make.height.offset(image.size.height);
    }];
}

- (void)setupSubViews{
    [self addSubview:self.valueLabel];
    [self addSubview:self.titlelabel];
    [self addSubview:self.img];
    
    WS(weakSelf);
    [_img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.width.offset(45);
        make.top.equalTo(weakSelf);
        make.height.offset(56);
    }];
//    [_titlelabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(weakSelf.mas_centerX);
//        make.height.offset(12);
//        make.left.equalTo(weakSelf);
//        make.top.equalTo(weakSelf.img.mas_bottom).offset(5);
//    }];
    [_valueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.height.offset(14);
        make.left.equalTo(weakSelf);
        make.top.equalTo(weakSelf.img.mas_bottom).offset(5);
    }];
    
}

@end


@implementation PersonalCenterTableViewBottomCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupSubviews];
    }
    return self;
}

- (UILabel *)leftLabel{
    if (!_leftLabel) {
        _leftLabel = [[UILabel alloc]init];
        _leftLabel.textColor = kTextColor;
        _leftLabel.font = kTextFont;
    }
    return _leftLabel;
}

- (UILabel *)centerLabel{
    if (!_centerLabel) {
        _centerLabel = [[UILabel alloc]init];
        _centerLabel.textColor = kTextColor;
        _centerLabel.font = kTextFont;
        _centerLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _centerLabel;
}

- (UIImageView *)rightIcon{
    if (!_rightIcon) {
        _rightIcon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"向右"]];
    }
    return _rightIcon;
}

- (void)setupSubviews{
    [self addSubview:self.leftLabel];
    [self addSubview:self.centerLabel];
    [self addSubview:self.rightIcon];
    
    WS(weakSelf);
    [_leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).offset(kMarginLeft);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.top.equalTo(weakSelf);
        make.width.offset(100);
    }];
    [_centerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(weakSelf);
        make.top.equalTo(weakSelf);
        make.width.offset(100);
    }];
    [_rightIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.right.equalTo(weakSelf.mas_right).offset(- kMarginLeft);
        make.height.offset(10);
        make.width.offset(6);
    }];
}

@end
