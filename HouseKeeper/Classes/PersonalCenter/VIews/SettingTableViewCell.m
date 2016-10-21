//
//  SettingTableViewCell.m
//  HouseKeeper
//
//  Created by 高泽民 on 16/10/19.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "SettingTableViewCell.h"

@implementation SettingTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupSubViews];
    }
    return self;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = kText_Color;
        _titleLabel.font = kFont14;
    }
    return _titleLabel;
}

- (UIImageView *)rightIcon{
    if (!_rightIcon) {
        _rightIcon = [[UIImageView alloc]initWithImage:Image(@"向右")];
        _rightIcon.contentMode = UIViewContentModeCenter;
    }
    return _rightIcon;
}


- (void)setupSubViews{
    [self addSubview:self.titleLabel];
    [self addSubview:self.rightIcon];
    
    WS(weakSelf);
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).offset(10);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.width.lessThanOrEqualTo(@100);
        make.height.lessThanOrEqualTo(@20);
    }];
    [_rightIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.mas_right).offset(- 10);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.height.and.width.offset(15);
    }];
}

@end


@implementation SettingTableViewCell1
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupSubViews];
    }
    return self;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = kText_Color;
        _titleLabel.font = kFont14;
        _titleLabel.text = @"当前版本";
    }
    return _titleLabel;
}

- (UILabel *)contentlabel{
    if (!_contentlabel) {
        _contentlabel = [[UILabel alloc]init];
        _contentlabel.textColor = kText_Color;
        _contentlabel.font = kFont14;
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        CFShow((__bridge CFTypeRef)(infoDictionary));
        // app版本
        NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
        _contentlabel.text = [NSString stringWithFormat:@"管家女士v%@",app_Version];
    }
    return _contentlabel;
}


- (void)setupSubViews{
    [self addSubview:self.titleLabel];
    [self addSubview:self.contentlabel];
    
    WS(weakSelf);
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).offset(10);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.width.lessThanOrEqualTo(@100);
        make.height.lessThanOrEqualTo(@20);
    }];
    [_contentlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.mas_right).offset(- 10);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.height.lessThanOrEqualTo(@15);
        make.width.lessThanOrEqualTo(@100);
    }];
}

@end
