//
//  LifeServiceTableView.m
//  HouseKeeper
//
//  Created by 高泽民 on 16/11/24.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "LifeServiceTableView.h"


@interface LifeServiceTableView()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation LifeServiceTableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.dataSource = self;
        self.delegate = self;
        self.backgroundColor = kBackgroundColor;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return self;
}

- (void)setListModel:(LifeServiceListDataModel *)listModel{
    _listModel = listModel;
    [self reloadData];
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.listModel.isDetailViewController) {
        if (indexPath.section == 0) {
            
            static NSString *cellId = @"cellId0";
            LifeServiceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
            if (!cell) {
                cell = [[LifeServiceTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            }
            [tableView addLineforPlainCell:cell forRowAtIndexPath:indexPath withLeftSpace:0];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            if (self.listModel.dataList.count > indexPath.section) {
                cell.model = self.listModel.dataList[indexPath.section];
            }
            
            return cell;
            
        }
        else{
        
            static NSString *cellId = @"cellId1";
            LifeServiceTableViewCell1 *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
            if (!cell) {
                cell = [[LifeServiceTableViewCell1 alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            }
            [tableView addLineforPlainCell:cell forRowAtIndexPath:indexPath withLeftSpace:35];

            LifeServiceListModel *model = self.listModel.dataList[0];
            
            if (indexPath.row == 0) {
                cell.leftIcon.image = Image(@"地址管理");
                cell.titleLabel.text = model.address;
            }
            else{
                cell.leftIcon.image = Image(@"service_电话");
                cell.titleLabel.text = model.telephone;
            }
            return cell;
        }
    }
    
    static NSString *cellId = @"cellId";
    LifeServiceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[LifeServiceTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    [tableView addLineforPlainCell:cell forRowAtIndexPath:indexPath withLeftSpace:0];
    if (self.listModel.dataList.count > indexPath.section) {
        cell.model = self.listModel.dataList[indexPath.section];
    }
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.listModel.isDetailViewController) {
        return 2;
    }
    return self.listModel.dataList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.listModel.isDetailViewController && section == 1){
        return 2;
    }
    return 1;
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section{
    view.tintColor = [UIColor clearColor];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return [LifeServiceTableViewCell getHeight];
    }
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    }
    return 10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section < self.listModel.dataList.count) {
        if (self.listModel.isDetailViewController) {
            return;
        }
        if ([self.clickDelegate respondsToSelector:@selector(BaseTableViewClickWithModel:)] && self.listModel.dataList.count > indexPath.section) {
            [self.clickDelegate BaseTableViewClickWithModel:self.listModel.dataList[indexPath.section]];
        }
    }
    else if(indexPath.row == 1){
        //拨号
        LifeServiceListModel *model = self.listModel.dataList[0];
        NSURL* url = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"tel:%@",model.telephone]];
        [[ UIApplication sharedApplication]openURL:url];
    }
}


@end
