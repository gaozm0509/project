//
//  PsersonalInfoTableViewCell.m
//  HouseKeeper
//
//  Created by 高泽民 on 16/11/7.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "PsersonalInfoTableViewCell.h"

static CGFloat avaterHeight = 80;

@implementation PsersonalInfoTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupSubViews];
        
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (UIImageView *)avaterImageView{
    if (!_avaterImageView) {
        _avaterImageView = [[UIImageView alloc] init];
        _avaterImageView.layer.masksToBounds = YES;
        _avaterImageView.layer.cornerRadius = avaterHeight / 2;
        _avaterImageView.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(avaterClick)];
        [_avaterImageView addGestureRecognizer:gesture];
    }
    return _avaterImageView;
}

- (void)setupSubViews{
    [self addSubview:self.avaterImageView];
    [_avaterImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.and.height.offset(avaterHeight);
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);
    }];
}

- (void)avaterClick{
    [self.delegate avaterClick];
}

@end

@implementation PsersonalInfoTableViewCell1

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupSubViews];
        
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (UILabel *)label{
    if (!_label) {
        _label = [[UILabel alloc] init];
        _label.textColor = kText_Color;
        _label.font = kFont14;
    }
    return _label;
}

- (UIImageView *)rightIcon{
    if (!_rightIcon) {
        _rightIcon = [[UIImageView alloc] initWithImage:Image(@"向右")];
        _rightIcon.contentMode = UIViewContentModeCenter;
    }
    return _rightIcon;
}

- (void)setupSubViews{
    [self addSubview:self.label];
    [self addSubview:self.rightIcon];
    [_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.width.mas_lessThanOrEqualTo(kScreen_Width);
        make.centerY.equalTo(self.mas_centerY);
        make.height.mas_lessThanOrEqualTo(@20);
    }];
    [_rightIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(- 10);
        make.width.and.height.offset(15);
        make.centerY.equalTo(self.mas_centerY);
    }];
}

@end

@implementation PsersonalInfoTableViewCell2

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupSubViews];
        
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"性别";
        _titleLabel.font = kFont14;
        _titleLabel.textColor = kText_Color;
    }
    return _titleLabel;
}

- (UIButton *)manButton{
    if (!_manButton) {
        CGRect frame = CGRectMake(50, 0, 45, 45);
        _manButton = [[UIButton alloc] initWithFrame:frame horizontal:5 title:@"男" image:Image(@"勾选未选中") font:kFont14];
        [_manButton setImage:Image(@"勾选选中") forState:UIControlStateSelected];
        [_manButton setTitleColor:kText_Color forState:UIControlStateNormal];
        _manButton.selected = YES;
        [_manButton addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        _manButton.tag = 1001;
    }
    return _manButton;
}

- (UIButton *)wemanButton{
    if (!_wemanButton) {
        CGRect frame = CGRectMake(105, 0, 45, 45);
        _wemanButton = [[UIButton alloc] initWithFrame:frame horizontal:5 title:@"女" image:Image(@"勾选未选中") font:kFont14];
        [_wemanButton setImage:Image(@"勾选选中") forState:UIControlStateSelected];
        [_wemanButton setTitleColor:kText_Color forState:UIControlStateNormal];
        
        [_wemanButton addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        _wemanButton.tag = 1002;
    }
    return _wemanButton;
}

- (void)click:(UIButton *)button{
    if (button.selected) {
        return;
    }
    [self.delegate editGenderWithGender:button.tag - 1000];
}



- (void)setupSubViews{
    [self addSubview:self.titleLabel];
    [self addSubview:self.manButton];
    [self addSubview:self.wemanButton];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.width.mas_lessThanOrEqualTo(50);
        make.height.mas_lessThanOrEqualTo(@20);
        make.centerY.equalTo(self.mas_centerY);
    }];
}

@end
