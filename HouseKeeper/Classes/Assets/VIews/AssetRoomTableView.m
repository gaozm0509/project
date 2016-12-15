//
//  AssetRoomTableView.m
//  HouseKeeper
//
//  Created by 高泽民 on 16/9/11.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "AssetRoomTableView.h"

@interface AssetRoomTableView()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray<FurnitureModel *> *scheduleList;

@property (nonatomic, strong) UILabel *totalAssetsLabel;
@property (nonatomic, strong) UIButton *addButton;

@property (nonatomic, strong) UIView *headView;

@end

@implementation AssetRoomTableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.dataSource = self;
        self.delegate = self;
        self.backgroundColor = kBackgroundColor;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableHeaderView = self.headView;
    }
    return self;
}

- (UIView *)headView{
    if (!_headView) {
        _headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 50)];
        _headView.backgroundColor = kBackgroundColor;
        [_headView addSubview:self.totalAssetsLabel];
//        [_headView addSubview:self.addButton];
        
        [_totalAssetsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.headView).offset(10);
            make.centerY.equalTo(self.headView.mas_centerY);
            make.width.lessThanOrEqualTo(@(kScreen_Width));
            make.height.lessThanOrEqualTo(@20);
        }];
//        [_addButton mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.right.equalTo(self.headView.mas_right).offset(0);
//            make.width.and.height.offset(44);
//            make.centerY.equalTo(self.headView.mas_centerY);
//        }];
    }
    return _headView;
}

- (UILabel *)totalAssetsLabel{
    if (!_totalAssetsLabel) {
        _totalAssetsLabel = [UILabel new];
    }
    return _totalAssetsLabel;
}

- (UIButton *)addButton{
    if (!_addButton) {
        _addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addButton setImage:Image(@"添加") forState:UIControlStateNormal];
        [_addButton addTarget:self action:@selector(addFurniture) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addButton;
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        static NSString *cellId = @"cellId";
        AssetRoomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[AssetRoomTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        [tableView addLineforPlainCell:cell forRowAtIndexPath:indexPath withLeftSpace:10];
        cell.model = _scheduleList[indexPath.row];
        return cell;
    }
   static NSString *cellId = @"cellId1";
    AssetRoomTableViewCell1 *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[AssetRoomTableViewCell1 alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    [tableView addLineforPlainCell:cell forRowAtIndexPath:indexPath withLeftSpace:10];
    cell.model = _model.furnitures[indexPath.row];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return MIN(_model.furnitures.count, 1) + MIN(_scheduleList.count, 1);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 1) {
        return _model.furnitures.count;
    }
    return _scheduleList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 20)];
    
    UILabel *title = [[UILabel alloc]init];
    title.text = section == 0 ? @"保养提醒" : @"所有资产";
    title.textColor = Color_Hex(@"a4a4a4");
    title.font = kFont12;
    title.textAlignment = NSTextAlignmentCenter;
    [view addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(view);
        make.width.lessThanOrEqualTo(@100);
        make.height.offset(12);
    }];
    
    UIView *leftView = [[UIView alloc]init];
    leftView.backgroundColor = Color_Hex(@"a4a4a4");
    [view addSubview:leftView];
    [leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view).offset(10);
        make.height.offset(0.5);
        make.centerY.equalTo(view.mas_centerY);
        make.right.equalTo(title.mas_left).offset(- 10);
    }];
    
    UIView *rightView = [[UIView alloc]init];
    rightView.backgroundColor = Color_Hex(@"a4a4a4");
    [view addSubview:rightView];
    [rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(view.mas_right).offset(- 10);
        make.height.offset(0.5);
        make.centerY.equalTo(view.mas_centerY);
        make.left.equalTo(title.mas_right).offset(10);
    }];
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
        [self.clickDelegate clickTableViewCellWithModel:_model.furnitures[indexPath.row] indexPath:indexPath];
}

- (void)setModel:(RoomModel *)model{
    _model = model;
    
    NSMutableAttributedString *nameText = [[NSMutableAttributedString alloc]initWithString:@"资产共计数：" attributes:@{NSFontAttributeName:kFont14,NSForegroundColorAttributeName:kText_Color}];
    NSMutableAttributedString *value = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%ld",_model.furnitures.count] attributes:@{NSFontAttributeName:kFont14,NSForegroundColorAttributeName:KMajorYellowColor}];
    [nameText appendAttributedString:value];
    _totalAssetsLabel.attributedText = nameText;
    
    
    _scheduleList = [NSMutableArray new];
    
   //筛选需要保养得家具
    for (FurnitureModel *furnitureModel in model.furnitures) {
        if (furnitureModel.schedule_period.integerValue <= 15) {
            [_scheduleList addObject:furnitureModel];
        }
    }
    [self reloadData];
}

#pragma mark - Event

- (void)addFurniture{
    [self.clickDelegate showAddFurnitureView];
}

@end
