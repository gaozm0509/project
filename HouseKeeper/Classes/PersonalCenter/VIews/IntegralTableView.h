//
//  IntegralTableView.h
//  HouseKeeper
//
//  Created by 高泽民 on 16/8/11.
//  Copyright © 2016年 zm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IntegralTableViewCell.h"

@class HeadView;
@interface IntegralTableView : UITableView

@property (nonatomic, strong) HeadView *myHeadView;

@end


@interface HeadView : UIView

@property (nonatomic, strong) UIView *circleView;
@property (nonatomic ,strong) UILabel *circleTitleLabel;
@property (nonatomic ,strong) UILabel *cicleValueLabel;

@property (nonatomic, strong) UIButton *integralMallButton;
@property (nonatomic ,strong) UIButton *exchangeRecordButton;
@property (nonatomic ,strong) UIButton *integralDescriptionButton;

@end
