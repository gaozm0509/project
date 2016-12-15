//
//  CouponTableViewCell.m
//  HouseKeeper
//
//  Created by 高泽民 on 16/7/27.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "CouponTableViewCell.h"

@implementation CouponTableViewCell

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
        [self setBackgroundColor:[UIColor clearColor]];
        [self setupSubViews];
    }
    return self;
}

- (UIView *)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc]init];
        _bgView.backgroundColor = [UIColor whiteColor];
        _bgView.layer.cornerRadius = 8;
    }
    return _bgView;
}

- (UILabel *)sumLabel{
    if (!_sumLabel) {
        _sumLabel = [[UILabel alloc]init];
        _sumLabel.text = @"￥10.00";
        _sumLabel.textColor = [UIColor blackColor];
        _sumLabel.textAlignment = NSTextAlignmentCenter;
        _sumLabel.font = [UIFont systemFontOfSize:25];
    }
    return _sumLabel;
}

- (UIImageView *)line{
    if(!_line){
        _line = [[UIImageView alloc]initWithImage:[UIImage imageWithColor:[UIColor blackColor]]];
    }
    return _line;
}

- (UILabel *)nameLabl{
    if (!_nameLabl) {
        _nameLabl = [[UILabel alloc]init];
        _nameLabl.text = @"洗衣优惠券";
        _nameLabl.textColor = Color_Hex(@"666666");
        _nameLabl.font = kFont15;
    }
    return _nameLabl;
}

- (UILabel *)instructionLabel{
    if (!_instructionLabel) {
        _instructionLabel = [[UILabel alloc]init];
        _instructionLabel.text = kText;
        _instructionLabel.font = kFont12;
        _instructionLabel.textColor = Color_Hex(@"666666");
        _instructionLabel.numberOfLines = 0;
        _instructionLabel.lineBreakMode = NSLineBreakByWordWrapping;
    }
    return _instructionLabel;
}

- (UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.text = @"2016-06-02至2016-07-09";
        _timeLabel.font = kFont12;
        _timeLabel.textColor = Color_Hex(@"666666");
    }
    return _timeLabel;
}

- (UILabel *)stateLabel{
    if (!_stateLabel) {
        _stateLabel = [[UILabel alloc]init];
        _stateLabel.text = @"";
        if (_couponType == CouponTypeUsed) {
            _stateLabel.text = @"已使用";
        }
        if (_couponType == CouponTypeOverdue) {
            _stateLabel.text = @"已过期";
        }
        _stateLabel.font = kFont20;
        _stateLabel.textAlignment = NSTextAlignmentRight;
        _stateLabel.textColor = Color_Hex(@"FF8F3b");
    }
    return _stateLabel;
}

- (void)setCouponType:(CouponType)couponType{
    _couponType = couponType;
    _stateLabel.text = @"";
    if (_couponType == CouponTypeUsed) {
        _stateLabel.text = @"已使用";
    }
    if (_couponType == CouponTypeOverdue) {
        _stateLabel.text = @"已过期";
    }
}

- (void)setModel:(CouponModel *)model{
    _model = model;
    _sumLabel.text =[NSString stringWithFormat:@"￥%@",_model.amount];
    _nameLabl.text = _model.couponDescription;
    _instructionLabel.text = [NSString stringWithFormat:@"满%@元可使用",_model.limit_amount];
    _timeLabel.text = [NSString stringWithFormat:@"有效期至%@",_model.expire_date];
}

- (void)setupSubViews{
    
    [self addSubview:self.bgView];
    [_bgView addSubview:self.sumLabel];
    [_bgView addSubview:self.line];
    [_bgView addSubview:self.nameLabl];
    [_bgView addSubview:self.instructionLabel];
    [_bgView addSubview:self.timeLabel];
    [_bgView addSubview:self.stateLabel];
    
    WS(weakSelf);
    [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).offset(kMarginleft);
        make.right.equalTo(weakSelf.mas_right).offset(- kMarginleft);
        make.top.equalTo(weakSelf);
        make.bottom.equalTo(weakSelf.mas_bottom);
    }];
    [_sumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.bgView.mas_centerY);
        make.left.equalTo(weakSelf.bgView).offset(kMarginleft);
        make.width.offset(kBgViewWidht / 3 - kMarginleft);
        make.height.offset(30);
    }];
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset(1);
        make.top.equalTo(weakSelf.bgView).offset(kMarginleft);
        make.bottom.equalTo(weakSelf.bgView.mas_bottom).offset(- kMarginleft);
        make.left.equalTo(weakSelf.bgView).offset(kScreen_Width / 3);
    }];
    [_nameLabl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.line);
        make.height.offset(15);
        make.left.equalTo(weakSelf.line.mas_right).offset(kMarginleft);
        make.right.equalTo(weakSelf.bgView.mas_right).offset(- kMarginleft - kStateLabelWidth);
    }];
    CGFloat height = [kText sizeWithFont:kFont12 Size:CGSizeMake(kBgViewWidht - kBgViewWidht / 3 - kMarginleft - kStateLabelWidth, MAXFLOAT)].height;
    [_instructionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.nameLabl.mas_bottom).offset(5);
        make.height.offset(height);
        make.left.equalTo(weakSelf.line.mas_right).offset(kMarginleft);
        make.right.equalTo(weakSelf.bgView.mas_right).offset(- kMarginleft - kStateLabelWidth);
    }];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.line.mas_bottom).offset(0);
        make.height.offset(12);
        make.left.equalTo(weakSelf.line.mas_right).offset(kMarginleft);
        make.right.equalTo(weakSelf.bgView.mas_right).offset(- kMarginleft);
    }];
    [_stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.right.equalTo(weakSelf.bgView.mas_right).offset(- kMarginleft);
        make.height.offset(30);
        make.left.width.offset(kStateLabelWidth);
    }];
}

@end
