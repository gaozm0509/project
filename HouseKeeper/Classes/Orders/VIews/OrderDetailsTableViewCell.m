//
//  OrderDetailsTableViewCell.m
//  HouseKeeper
//
//  Created by 高泽民 on 16/9/14.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "OrderDetailsTableViewCell.h"

@implementation OrderDetailsTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupSubViews];
    }
    return self;
}

- (UILabel *)orderNumberLabel{
    if (!_orderNumberLabel) {
        _orderNumberLabel = [[UILabel alloc]init];
    }
    return _orderNumberLabel;
}

@end
