//
//  OrderDetailsTableViewCell.h
//  HouseKeeper
//
//  Created by 高泽民 on 16/9/14.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "MyOrderModel.h"

@interface OrderDetailsTableViewCell : BaseTableViewCell

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIView *leftView;
@property (nonatomic, strong) UIView *leftLineView;

@property (nonatomic, assign) BOOL isLastRow;

@property (nonatomic, assign) BOOL isFirstRow;

@property (nonatomic, assign) OrderType orderType;

- (void)setTextWithIndex:(NSInteger)index;

@end

