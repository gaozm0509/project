//
//  AddAssetTableViewCell.m
//  HouseKeeper
//
//  Created by 高泽民 on 16/10/15.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "AddAssetTableViewCell.h"

@implementation AddAssetTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupSubViews];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (UITextField *)modelTextField{
    if (!_modelTextField) {
        _modelTextField = [UITextField new];
        _modelTextField.placeholder = @"请选择";
        _modelTextField.textColor = KMajorColor;
        _modelTextField.font = kFont14;
        _modelTextField.leftViewMode = UITextFieldViewModeAlways;
        
        UILabel *leftViewLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 45)];
        leftViewLabel.text = @"设备类型:";
        leftViewLabel.textColor = kText_Color;
        leftViewLabel.font = kFont14;
        leftViewLabel.textAlignment = NSTextAlignmentCenter;
        
        _modelTextField.leftView = leftViewLabel;
        
        UIButton *checkModelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        checkModelButton.frame = CGRectMake(80, 0, kScreen_Width - 80, 45);
        [checkModelButton addTarget:self action:@selector(checkModel) forControlEvents:UIControlEventTouchUpInside];
        [_modelTextField addSubview:checkModelButton];
        
    }
    return _modelTextField;
}

- (void)setFurnitureModel:(FurnitureModel *)furnitureModel{
    _furnitureModel = furnitureModel;
    _modelTextField.text = _furnitureModel.type;
}

- (void)setupSubViews{
    [self addSubview:self.modelTextField];
    
    WS(weakSelf);
    [_modelTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf);
        make.top.equalTo(weakSelf);
        make.right.equalTo(weakSelf.mas_right);
        make.bottom.equalTo(weakSelf.mas_bottom);
    }];
}

- (void)checkModel{
    [self.delegate showCheckModelSheet];
}

@end



@implementation AddAssetTableViewCell1

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupSubViews];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (UITextField *)textField{
    if (!_textField) {
        _textField = [UITextField new];
        _textField.placeholder = @"输入设备型号";
        _textField.textColor = kText_Color;
        _textField.font = kFont14;
        _textField.leftViewMode = UITextFieldViewModeAlways;
        
        UILabel *leftViewLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 45)];
        leftViewLabel.text = @"设备型号:";
        leftViewLabel.textColor = kText_Color;
        leftViewLabel.font = kFont14;
        leftViewLabel.textAlignment = NSTextAlignmentCenter;
        
        _textField.leftView = leftViewLabel;
    }
    return _textField;
}

//- (void)setFurnitureModel:(FurnitureModel *)furnitureModel{
//    _furnitureModel = furnitureModel;
//    _textField.text = furnitureModel.model;
//}

- (void)setupSubViews{
    [self addSubview:self.textField];
    
    WS(weakSelf);
    [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf);
        make.top.equalTo(weakSelf);
        make.right.equalTo(weakSelf.mas_right);
        make.bottom.equalTo(weakSelf.mas_bottom);
    }];
}

@end


@implementation AddAssetTableViewCell2

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupSubViews];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (UIButton *)AutomaticMatchingButton{
    if (!_AutomaticMatchingButton) {
        _AutomaticMatchingButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_AutomaticMatchingButton setTitle:@"自动匹配" forState:UIControlStateNormal];
        _AutomaticMatchingButton.backgroundColor = KMajorColor;
        _AutomaticMatchingButton.layer.cornerRadius = 3;
        _AutomaticMatchingButton.layer.masksToBounds = YES;
        [_AutomaticMatchingButton addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    }
    return _AutomaticMatchingButton;
}

- (void)setupSubViews{
    [self addSubview:self.AutomaticMatchingButton];
    
    WS(weakSelf);
    [_AutomaticMatchingButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(weakSelf);
        make.height.offset(44);
        make.left.equalTo(weakSelf).offset(30);
    }];
}

- (void)click{
    [self.delegate AutomaticMatchingButtonClick];
}

@end


@implementation AddAssetTableViewAutoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupSubViews];
    }
    return self;
}

- (UILabel *)titlelabel{
    if (!_titlelabel) {
        _titlelabel = [[UILabel alloc]init];
        _titlelabel.text = @"添加自定义属性";
        _titlelabel.textColor = kText_Color;
        _titlelabel.font = kFont14;
    }
    return _titlelabel;
}

- (UIImageView *)rightIcon{
    if (!_rightIcon) {
        _rightIcon = [[UIImageView alloc]initWithImage:Image(@"向右")];
        _rightIcon.contentMode = UIViewContentModeCenter;
    }
    return _rightIcon;
}

- (void)setupSubViews{
    [self addSubview:self.titlelabel];
    [self addSubview:self.rightIcon];
    
    WS(weakSelf);
    [_titlelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).offset(10);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.width.lessThanOrEqualTo(@(kScreen_Width));
        make.height.equalTo(weakSelf.mas_height);
    }];
    [_rightIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.mas_right).offset(- 10);
        make.width.and.height.offset(10);
        make.centerY.equalTo(weakSelf.mas_centerY);
    }];
}

@end


@implementation AddAssetTableViewPurchase_dateCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupSubViews];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (UITextField *)purchase_dateTextField{
    if (!_purchase_dateTextField) {
        _purchase_dateTextField = [UITextField new];
        _purchase_dateTextField.placeholder = @"请选择购买时间（必填）";
        _purchase_dateTextField.textColor = KMajorColor;
        _purchase_dateTextField.font = kFont14;
        _purchase_dateTextField.leftViewMode = UITextFieldViewModeAlways;
        
        UILabel *leftViewLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 45)];
        leftViewLabel.text = @"购买时间:";
        leftViewLabel.textColor = kText_Color;
        leftViewLabel.font = kFont14;
        leftViewLabel.textAlignment = NSTextAlignmentCenter;
        
        _purchase_dateTextField.leftView = leftViewLabel;
        
        UIButton *checkModelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        checkModelButton.frame = CGRectMake(80, 0, kScreen_Width - 80, 45);
        [checkModelButton addTarget:self action:@selector(checkPurchase_dateText) forControlEvents:UIControlEventTouchUpInside];
        [_purchase_dateTextField addSubview:checkModelButton];
        
    }
    return _purchase_dateTextField;
}

- (void)setFurnitureModel:(FurnitureModel *)furnitureModel{
    _furnitureModel = furnitureModel;
    _purchase_dateTextField.text = _furnitureModel.purchase_date;
}

- (void)setupSubViews{
    [self addSubview:self.purchase_dateTextField];
    
    WS(weakSelf);
    [_purchase_dateTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf);
        make.top.equalTo(weakSelf);
        make.right.equalTo(weakSelf.mas_right);
        make.bottom.equalTo(weakSelf.mas_bottom);
    }];
}

- (void)checkPurchase_dateText{
    [self.delegate purchase_dateTextFieldClickWithTextField:_purchase_dateTextField];
}


@end
