//
//  BalanceView.m
//  HouseKeeper
//
//  Created by 高泽民 on 16/7/19.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "BalanceView.h"

#define kCircleViewHeight 100
@interface BalanceView()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIView *circleView;
@property (nonatomic, strong) UILabel *balanceTitelLabel;

@property (nonatomic, strong)UITableView *tabelView;

@end

@implementation BalanceView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubViews];
    }
    return self;
}

- (UIView *)topView{
    if (!_topView) {
        _topView = [[UIView alloc]init];
        _topView.backgroundColor = [UIColor whiteColor];
    }
    return _topView;
}

- (UIView *)circleView{
    if (!_circleView) {
        _circleView = [[UIView alloc]init];
        _circleView.backgroundColor = KMajorColor;
        _circleView.layer.cornerRadius = kCircleViewHeight/2;
    }
    return _circleView;
}

- (UILabel *)balanceTitelLabel{
    if (!_balanceTitelLabel) {
        _balanceTitelLabel = [[UILabel alloc]init];
        _balanceTitelLabel.backgroundColor = [UIColor clearColor];
        _balanceTitelLabel.text = @"余额";
        _balanceTitelLabel.font = [UIFont systemFontOfSize:12];
        _balanceTitelLabel.textAlignment = NSTextAlignmentCenter;
        _balanceTitelLabel.textColor = [UIColor whiteColor];
    }
    return _balanceTitelLabel;
}

- (UILabel *)balanceLabel{
    if (!_balanceLabel) {
        _balanceLabel = [[UILabel alloc]init];
        _balanceLabel.backgroundColor = [UIColor clearColor];
        _balanceLabel.text = @"1002.00";
        _balanceLabel.font = [UIFont systemFontOfSize:16];
        _balanceLabel.textAlignment = NSTextAlignmentCenter;
        _balanceLabel.textColor = [UIColor whiteColor];
    }
    return _balanceLabel;
}

- (UITableView *)tabelView{
    if (!_tabelView) {
        _tabelView = [[UITableView alloc]init];
        _tabelView.delegate = self;
        _tabelView.dataSource= self;
        _tabelView.backgroundColor = [UIColor clearColor];
        _tabelView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tabelView;
}

#pragma mark - TableView delegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"cellId";
    BalanceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[BalanceTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        [tableView addLineforPlainCell:cell forRowAtIndexPath:indexPath withLeftSpace:10];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.model = _listModel.dataList[indexPath.row];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _listModel.dataList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kMarginTop + kHeight + kMarginTop + kHeight +kMarginTop;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 55;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 44)];
    view.backgroundColor = [UIColor whiteColor];
    UILabel *label = [[UILabel alloc]init];
    label.text  = @"交易记录";
    label.font = [UIFont systemFontOfSize:12];
    label.textColor  =[UIColor blackColor];
    label.textAlignment = NSTextAlignmentCenter;
    [view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(view);
        make.width.offset(80);
        make.height.equalTo(view.mas_height);
    }];
    return view;
}

- (void)setListModel:(BalanceHistoryListModel *)listModel{
    _listModel = listModel;
    [self.tabelView reloadData];
}

#pragma mark - Pravit method
-(void)setupSubViews{
    [self addSubview:self.topView];
    [_topView addSubview:self.circleView];
    [_circleView addSubview:self.balanceLabel];
    [_circleView addSubview:self.balanceTitelLabel];
    [self addSubview:self.tabelView];
    
    WS(ws);
    [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.equalTo(ws);
        make.right.equalTo(ws.mas_right);
        make.height.offset(kCircleViewHeight * 1.5);
    }];
    [_circleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(ws.topView);
        make.height.offset(kCircleViewHeight);
        make.width.offset(kCircleViewHeight);
    }];
    [_balanceTitelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(ws.circleView.mas_centerY);
        make.centerX.equalTo(ws.circleView.mas_centerX);
        make.left.equalTo(ws);
        make.height.offset(20);
    }];
    [_balanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.circleView.mas_centerY);
        make.centerX.equalTo(ws.circleView.mas_centerX);
        make.height.offset(20);
        make.left.equalTo(ws.circleView);
    }];
    [_tabelView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws);
        make.bottom.equalTo(ws.mas_bottom);
        make.right.equalTo(ws.mas_right);
        make.top.equalTo(ws.topView.mas_bottom);
    }];
}

@end
