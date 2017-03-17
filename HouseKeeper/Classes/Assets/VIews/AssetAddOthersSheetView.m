//
//  AssetAddOthersSheetView.m
//  HouseKeeper
//
//  Created by 高泽民 on 16/10/17.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "AssetAddOthersSheetView.h"

#define kTextColor [UIColor colorWithHexString:@"444444"]

@implementation AssetAddOthersSheetView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubViews];
    }
    return self;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.text = @"添加房间";
        _titleLabel.textColor = KMajorColor;
        _titleLabel.font = kFont14;
    }
    return _titleLabel;
}

- (UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = kBorderColor;
    }
    return _lineView;
}

- (UITextField *)nameField{
    if (!_nameField) {
        _nameField = [self nomalTextFieldWithleftViewTitle:@"属性名称" placeholder:@"请输入属性名称"];
    }
    return _nameField;
}

- (UITextField *)valueField{
    if (!_valueField) {
        _valueField = [self nomalTextFieldWithleftViewTitle:@"属性名称" placeholder:@"请输入属性值"];
    }
    return _valueField;
}

- (UIButton *)savebutton{
    if (!_savebutton) {
        _savebutton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_savebutton setTitle:@"添加" forState:UIControlStateNormal];
        [_savebutton setBackgroundColor:KMajorColor];
        [_savebutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _savebutton.titleLabel.font = kFont14;
        _savebutton.layer.cornerRadius = 3;
        _savebutton.layer.masksToBounds = YES;
    }
    return _savebutton;
}

- (UITextField *)nomalTextFieldWithleftViewTitle:(NSString *)leftTitle placeholder:(NSString *)placeholder{
    UITextField *textField = [[UITextField alloc]init];
    textField.font = kFont14;
    textField.textColor = kTextColor;
    textField.placeholder = placeholder;
    textField.leftViewMode = UITextFieldViewModeAlways;
    
    UILabel *leftLabel = [UILabel new];
    leftLabel.text = leftTitle;
    leftLabel.font = kFont14;
    leftLabel.textColor = kText_Color;
    leftLabel.textAlignment = NSTextAlignmentCenter;
    leftLabel.frame = CGRectMake(0, 0, 80, 45);
    
    textField.leftView = leftLabel;
    
    return textField;
}


- (void)setupSubViews{
    [self addSubview:self.titleLabel];
    [self addSubview:self.lineView];
    [self addSubview:self.nameField];
    [self addSubview:self.valueField];
    [self addSubview:self.savebutton];
    
    WS(weakSelf);
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf).offset(10);
        make.left.equalTo(weakSelf).offset(10);
        make.width.lessThanOrEqualTo(@200);
        make.height.lessThanOrEqualTo(@20);
    }];
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).offset(10);
        make.right.equalTo(weakSelf.mas_right).offset(- 10);
        make.height.offset(0.5);
        make.top.equalTo(weakSelf.titleLabel.mas_bottom).offset(10);
    }];
    [_nameField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).offset(10);
        make.top.equalTo(weakSelf.lineView.mas_bottom).offset(20);
        make.right.equalTo(weakSelf.mas_right).offset(- 10);
        make.height.offset(45);
    }];
    [_valueField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).offset(10);
        make.top.equalTo(weakSelf.nameField.mas_bottom).offset(10);
        make.right.equalTo(weakSelf.mas_right).offset(- 10);
        make.height.offset(45);
    }];
    [_savebutton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.mas_bottom).offset(- 10);
        make.left.equalTo(weakSelf).offset(10);
        make.right.equalTo(weakSelf.mas_right).offset(- 10);
        make.height.offset(45);
    }];
}

@end


