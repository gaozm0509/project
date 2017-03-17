//
//  RechargeTableViewCell.m
//  HouseKeeper
//
//  Created by 高泽民 on 16/10/31.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "RechargeTableViewCell.h"

@implementation RechargeTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.textField];
    }
    return self;
}

- (UITextField *)textField{
    if (!_textField) {
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 45)];
        _textField.textColor = kText_Color;
        _textField.placeholder = @"请输入金额";
        _textField.font = kFont14;
        _textField.leftViewMode = UITextFieldViewModeAlways;
        _textField.rightViewMode = UITextFieldViewModeAlways;
        _textField.keyboardType = UIKeyboardTypeDecimalPad;
        
        UILabel *leftView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width - 20 - 80, 45)];
        leftView.textColor = kText_Color;
        leftView.font = kFont14;
        leftView.text = @"   充值金额";
        
        UILabel *rightView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 20, 45)];
        rightView.textColor = kText_Color;
        rightView.font = kFont14;
        rightView.text = @"元";
        
        _textField.leftView = leftView;
        _textField.rightView = rightView;
        
        
    }
    return _textField;
}

@end
