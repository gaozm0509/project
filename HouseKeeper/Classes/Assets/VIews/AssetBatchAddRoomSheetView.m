//
//  AssetBatchAddRoomSheetView.m
//  HouseKeeper
//
//  Created by 高泽民 on 16/10/26.
//  Copyright © 2016年 zm. All rights reserved.
//

#define kTextColor [UIColor colorWithHexString:@"444444"]
#define kTextFont kFont14

#import "AssetBatchAddRoomSheetView.h"

@interface AssetBatchAddRoomSheetView()

@end
@implementation AssetBatchAddRoomSheetView

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

- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
    }
    return _scrollView;
}

- (UIButton *)saveButton{
    if (!_saveButton) {
        _saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_saveButton setTitle:@"添加" forState:UIControlStateNormal];
        [_saveButton setBackgroundColor:KMajorColor];
        [_saveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _saveButton.titleLabel.font = kTextFont;
        [_saveButton addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
        _saveButton.layer.cornerRadius = 3;
        _saveButton.layer.masksToBounds = YES;
    }
    return _saveButton;
}

- (void)setModel:(RoomTypeList *)model{
    _model = model;
    
    [_scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    for (NSInteger i = 0; i < model.dataList.count; i ++) {
        RoomType *roomType = [model.dataList objectAtIndex:i];
        
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(10, i * (45 + 0.5), kScreen_Width - 20, 45)];
        textField.textColor = KMajorColor;
        textField.font = kFont14;
        textField.text = [NSString stringWithFormat:@"%ld",[roomType.count integerValue]];
        textField.leftViewMode = UITextFieldViewModeAlways;
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 45)];
        label.textColor = [UIColor blackColor];
        label.font = kFont14;
        label.text = roomType.name;
        label.textAlignment = NSTextAlignmentCenter;
        textField.leftView = label;
        
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(80, 0, kScreen_Width - 100, 45)];
        button.tag = 2001 + i;
        [button addTarget:self action:@selector(textFieldClick:) forControlEvents:UIControlEventTouchUpInside];
        
        CALayer *line = [[CALayer alloc] init];
        line.frame = CGRectMake(10, i * (45 + 0.5) + 45, kScreen_Width - 20, 0.5);
        line.backgroundColor = kBorderColor.CGColor;
        
        [_scrollView addSubview:textField];
        [textField addSubview:button];
        [_scrollView.layer addSublayer:line];
    }
    
    _scrollView.contentSize = CGSizeMake(0, model.dataList.count * (45 + 0.5));
}

- (void)textFieldClick:(UIButton *)button{
    [self.textFieldClickDelegate textFieldClickWithIndex:button.tag - 2001];
}

- (void)save{
    [self.delegate BaseSheetViewSave];
}

- (void)setupSubViews{
    [self addSubview:self.titleLabel];
    [self addSubview:self.lineView];
    [self addSubview:self.scrollView];
    [self addSubview:self.saveButton];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(10);
        make.left.equalTo(self).offset(10);
        make.width.lessThanOrEqualTo(@200);
        make.height.lessThanOrEqualTo(@20);
    }];
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.right.equalTo(self.mas_right).offset(- 10);
        make.height.offset(0.5);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
    }];
    [_saveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).offset(- 10);
        make.left.equalTo(self).offset(10);
        make.right.equalTo(self.mas_right).offset(- 10);
        make.height.offset(45);
    }];
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.saveButton.mas_top).offset(- 10);
        make.top.equalTo(self.lineView.mas_bottom).offset(10);
    }];
}

@end
