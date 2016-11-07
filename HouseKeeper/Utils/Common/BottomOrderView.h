//
//  BottomOrderView.h
//  HouseKeeper
//
//  Created by 高泽民 on 16/11/2.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "BaseVIew.h"

typedef void(^OrderAction)(NSString *sun);

@interface BottomOrderView : BaseVIew

@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UIButton *orderButton;

@property (nonatomic, strong) NSString *sum;
@property (nonatomic, strong) NSString *orderTitle;

@property (nonatomic, copy) OrderAction orderAction;

@end
