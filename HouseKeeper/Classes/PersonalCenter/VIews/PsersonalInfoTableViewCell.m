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
    }
    return _avaterImageView;
}

- (void)setupSubViews{
    [self addSubview:self.avaterImageView];
    [_avaterImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.height.and.with.offset(avaterHeight);
    }];
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

- (void)setupSubViews{
    [self addSubview:self.label];
    [_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.width.mas_lessThanOrEqualTo(kScreen_Width);
        make.centerY.equalTo(self.mas_centerY);
        make.height.mas_lessThanOrEqualTo(@20);
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
    }
    return _manButton;
}

- (UIButton *)wemanButton{
    if (!_wemanButton) {
        CGRect frame = CGRectMake(105, 0, 45, 45);
        _wemanButton = [[UIButton alloc] initWithFrame:frame horizontal:5 title:@"女" image:Image(@"勾选未选中") font:kFont14];
        [_wemanButton setImage:Image(@"勾选选中") forState:UIControlStateSelected];
        [_wemanButton setTitleColor:kText_Color forState:UIControlStateNormal];
    }
    return _wemanButton;
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
