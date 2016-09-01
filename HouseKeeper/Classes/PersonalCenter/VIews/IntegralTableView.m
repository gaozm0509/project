//
//  IntegralTableView.m
//  HouseKeeper
//
//  Created by 高泽民 on 16/8/11.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "IntegralTableView.h"

#define kHeadCircleHeight 100

@interface IntegralTableView()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation IntegralTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.tableHeaderView = self.myHeadView;
    }
    return self;
}

- (HeadView *)myHeadView{
    if (!_myHeadView) {
        _myHeadView = [[HeadView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 215)];
    }
    return _myHeadView;
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"cellId";
    IntegralTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[IntegralTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        [tableView addLineforPlainCell:cell forRowAtIndexPath:indexPath withLeftSpace:10];
    }
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [IntegralTableViewCell getCellHeight];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 14;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 14)];
    
    UIView *leftView = [[UIView alloc]init];
    leftView.backgroundColor = Color_Hex(@"a4a5a4");
//    [view addSubview:leftView];
    
    UILabel *label = [[UILabel alloc]init];
    label.text = @"积分说明";
    label.font = kFont14;
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = Color_Hex(@"a4a4a4");
    [view addSubview:label];
    
    UIView *rightLine = [[UIView alloc]init];
    rightLine.backgroundColor = Color_Hex(@"a4a5a4");
//    [view addSubview:rightLine];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(view);
        make.width.offset(70);
        make.height.offset(14);
    }];
//    [leftView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(view).offset(10);
//        make.right.equalTo(label.mas_left);
//        make.height.offset(0.5);
//        make.centerY.equalTo(view.mas_centerY);
//    }];
//    [rightLine mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(view.mas_right).offset(10);
//        make.left.equalTo(label.mas_leftMargin);
//        make.height.offset(0.5);
//        make.centerY.equalTo(view.mas_centerY);
//    }];
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}

@end


@implementation HeadView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubViews];
    }
    return self;
}

- (UIView *)circleView{
    if (!_circleView) {
        _circleView = [[UIView alloc]init];
        _circleView.backgroundColor = KMajorColor;
        _circleView.layer.cornerRadius = kHeadCircleHeight / 2;
        _circleView.layer.masksToBounds = YES;
    }
    return _circleView;
}

- (UILabel *)circleTitleLabel{
    if (!_circleTitleLabel) {
        _circleTitleLabel = [[UILabel alloc]init];
        _circleTitleLabel.textColor = [UIColor whiteColor];
        _circleTitleLabel.font = kFont16;
        _circleTitleLabel.textAlignment = NSTextAlignmentCenter;
        _circleTitleLabel.text = @"管家币";
    }
    return _circleTitleLabel;
}

- (UILabel *)cicleValueLabel{
    if (!_cicleValueLabel) {
        _cicleValueLabel = [[UILabel alloc]init];
        _cicleValueLabel.textColor = [UIColor whiteColor];
        _cicleValueLabel.font = kFont19;
        _cicleValueLabel.textAlignment = NSTextAlignmentCenter;
        _cicleValueLabel.text = @"1000";
    }
    return _cicleValueLabel;
}

- (UIButton *)integralMallButton{
    if (!_integralMallButton) {
        _integralMallButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_integralMallButton setImage:[UIImage imageNamed:@"积分商城"] forState:UIControlStateNormal];
        _integralMallButton.tag = 1001;
        [_integralMallButton addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _integralMallButton;
}

- (UIButton *)exchangeRecordButton{
    if (!_exchangeRecordButton) {
        _exchangeRecordButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_exchangeRecordButton setImage:[UIImage imageNamed:@"兑换记录"] forState:UIControlStateNormal];
        _exchangeRecordButton.tag = 1002;
        [_exchangeRecordButton addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _exchangeRecordButton;
}

- (UIButton *)integralDescriptionButton{
    if (!_integralDescriptionButton) {
        _integralDescriptionButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_integralDescriptionButton setImage:[UIImage imageNamed:@"积分说明"] forState:UIControlStateNormal];
        _integralDescriptionButton.tag = 1003;
        [_integralDescriptionButton addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _integralDescriptionButton;
}

- (void)setupSubViews{
    [self addSubview:self.circleView];
    [_circleView addSubview:self.circleTitleLabel];
    [_circleView addSubview:self.cicleValueLabel];
    
    [self addSubview:self.integralMallButton];
    [self addSubview:self.exchangeRecordButton];
    [self addSubview:self.integralDescriptionButton];
    
    WS(weakSelf);
    [_circleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf).offset(30);
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.width.and.height.offset(kHeadCircleHeight);
    }];
    [_circleTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.circleView).offset(22);
        make.width.equalTo(weakSelf.circleView.mas_width);
        make.centerX.equalTo(weakSelf.circleView.mas_centerX);
        make.height.offset(16);
    }];
    [_cicleValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.circleTitleLabel.mas_bottom).offset(13);
        make.height.offset(19);
        make.width.equalTo(weakSelf.circleView.mas_width);
        make.centerX.equalTo(weakSelf.circleView.mas_centerX);
    }];
    [_integralMallButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).offset(25);
        make.width.offset(75);
        make.height.offset(25);
        make.top.equalTo(weakSelf.circleView.mas_bottom).offset(30);
    }];
    [_exchangeRecordButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.width.offset(75);
        make.height.offset(25);
        make.top.equalTo(weakSelf.circleView.mas_bottom).offset(30);
    }];
    [_integralDescriptionButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.mas_right).offset(- 25);
        make.width.offset(75);
        make.height.offset(25);
        make.top.equalTo(weakSelf.circleView.mas_bottom).offset(30);
    }];
}

- (void)click:(UIButton *)button{
    switch (button.tag) {
        case 1001:{
            
            break;
        }
        case 1002:{
            
            break;
        }
        case 1003:{
            
            break;
        }
            
        default:
            break;
    }
}

@end
