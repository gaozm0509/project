//
//  AsssetAddRoomSheetView.m
//  HouseKeeper
//
//  Created by 高泽民 on 16/10/13.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "AsssetAddRoomSheetView.h"

#define kTextColor [UIColor colorWithHexString:@"444444"]
#define kTextFont kFont14

@implementation AsssetAddRoomSheetView

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
        _titleLabel.font = kTextFont;
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

- (UITextField *)roomNameField{
    if (!_roomNameField) {
        _roomNameField = [[UITextField alloc]init];
        _roomNameField.textColor = [UIColor colorWithHexString:@"444444"];
        _roomNameField.font = kTextFont;
        _roomNameField.placeholder = @"房间名称";
        _roomNameField.leftViewMode = UITextFieldViewModeAlways;
        
        UILabel *leftView = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 70, 45)];
        leftView.textColor = kTextColor;
        leftView.font = kTextFont;
        leftView.text = @"房间名称";
        
        _roomNameField.leftView = leftView;
    }
    return _roomNameField;
}

- (UITextField *)roomTypeField{
    if (!_roomTypeField) {
        _roomTypeField = [[UITextField alloc]init];
        _roomTypeField.textColor = [UIColor colorWithHexString:@"444444"];
        _roomTypeField.font = kTextFont;
        _roomTypeField.placeholder = @"请选择房间类型";
        _roomTypeField.leftViewMode = UITextFieldViewModeAlways;
        [_roomTypeField setEnabled:NO];
        
        UILabel *leftView = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 70, 45)];
        leftView.textColor = kTextColor;
        leftView.font = kTextFont;
        leftView.text = @"房间类型";
        
        
        _roomTypeField.leftView = leftView;
    }
    return _roomTypeField;
}

- (UIButton *)roomTypeButton{
    if (!_roomTypeButton) {
        _roomTypeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _roomTypeButton;
}

- (UIButton *)savebutton{
    if (!_savebutton) {
        _savebutton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_savebutton setTitle:@"添加" forState:UIControlStateNormal];
        [_savebutton setBackgroundColor:KMajorColor];
        [_savebutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _savebutton.titleLabel.font = kTextFont;
        [_savebutton addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
        _savebutton.layer.cornerRadius = 3;
        _savebutton.layer.masksToBounds = YES;
    }
    return _savebutton;
}

#pragma mark - pravit method


- (void)save{
    [self.delegate BaseSheetViewSave];
}

- (void)setupSubViews{
    [self addSubview:self.titleLabel];
    [self addSubview:self.lineView];
    [self addSubview:self.roomNameField];
    [self addSubview:self.roomTypeField];
    [self addSubview:self.savebutton];
    [self addSubview:self.roomTypeButton];
    
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
    [_roomNameField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).offset(10);
        make.top.equalTo(weakSelf.lineView.mas_bottom).offset(20);
        make.right.equalTo(weakSelf.mas_right).offset(- 10);
        make.height.offset(45);
    }];
    [_roomTypeField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).offset(10);
        make.top.equalTo(weakSelf.roomNameField.mas_bottom).offset(10);
        make.right.equalTo(weakSelf.mas_right).offset(- 10);
        make.height.offset(45);
    }];
    [_roomTypeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.roomTypeField).offset(- 70);
        make.height.equalTo(weakSelf.roomTypeField.mas_height);
        make.right.equalTo(weakSelf.roomTypeField.mas_right);
        make.top.equalTo(weakSelf.roomTypeField);
    }];
    [_savebutton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.mas_bottom).offset(- 10);
        make.left.equalTo(weakSelf).offset(10);
        make.right.equalTo(weakSelf.mas_right).offset(- 10);
        make.height.offset(45);
    }];
}

@end
