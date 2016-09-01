//
//  InvoiceTableViewCell.m
//  HouseKeeper
//
//  Created by 高泽民 on 16/8/12.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "InvoiceTableViewCell.h"

@implementation InvoiceTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupSubView];
    }
    return self;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = kFont12;
        _titleLabel.textColor = Color_Hex(@"323232");
    }
    return _titleLabel;
}

- (UIImageView *)arrowView{
    if (!_arrowView) {
        _arrowView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"向右"]];
    }
    return _arrowView;
}

- (void)setupSubView{
    [self addSubview:self.titleLabel];
    [self addSubview:self.arrowView];
    
    WS(weakSelf);
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.left.equalTo(weakSelf).offset(10);
        make.width.offset(200);
        make.height.offset(12);
    }];
    [_arrowView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.mas_right).offset(- 10);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.width.offset(6);
        make.height.offset(10);
    }];
}

@end
