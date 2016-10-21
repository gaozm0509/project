//
//  AddAssetTableView.m
//  HouseKeeper
//
//  Created by 高泽民 on 16/10/15.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "AddAssetTableView.h"

#define kManuallyRows 7

@interface AddAssetTableView()<UITableViewDelegate,UITableViewDataSource,AddAssetTableViewCellDelegate,UITextFieldDelegate>

@property (nonatomic, assign) NSInteger rows;


@end

@implementation AddAssetTableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.dataSource = self;
        self.delegate = self;
        self.backgroundColor = kBackgroundColor;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        _isAuto = YES;
        _rows = 3;
    }
    return self;
}

- (void)setFurnitureModel:(FurnitureModel *)furnitureModel{
    _furnitureModel = furnitureModel;
    [self reloadData];
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 1) {
        static NSString *cellId = @"section1";
        AddAssetTableViewAutoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[AddAssetTableViewAutoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        [tableView addLineforPlainCell:cell forRowAtIndexPath:indexPath withLeftSpace:10];
        return cell;
    }
    
    if (indexPath.row == 0) {
        static NSString *cellId = @"cellId";
        AddAssetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[AddAssetTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.delegate = self;
        }
        [tableView addLineforPlainCell:cell forRowAtIndexPath:indexPath withLeftSpace:10];
        cell.furnitureModel = _furnitureModel;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    if (indexPath.row == 1) {
        static NSString *cellId = @"cellId1";
        AddAssetTableViewCell1 *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[AddAssetTableViewCell1 alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.textField.delegate = self;
        cell.textField.tag = 1001 + indexPath.row;
        cell.textField.text =  _furnitureModel.model;
        
        [tableView addLineforPlainCell:cell forRowAtIndexPath:indexPath withLeftSpace:10];
        
        return cell;
    }
    if (_isAuto) {
        if (indexPath.row == 2) {
            static NSString *cellId = @"cellId2";
            AddAssetTableViewCell2 *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
            if (!cell) {
                cell = [[AddAssetTableViewCell2 alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
                cell.delegate = self;
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [tableView addLineforPlainCell:cell forRowAtIndexPath:indexPath withLeftSpace:10];
            return cell;
        }
    }
    else{
        if (indexPath.row >= 2 && indexPath.row < kManuallyRows && indexPath.row != 4) {
            static NSString *cellId = @"cellId1";
            AddAssetTableViewCell1 *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
            if (!cell) {
                cell = [[AddAssetTableViewCell1 alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            }
            NSString *leftViewText = @"资产名称:";
            NSString *placeholder = @"请输入资产名称（必填）";
            
            cell.textField.delegate = self;
            cell.textField.tag = 1001 + indexPath.row;
            NSString *text = _furnitureModel.name;
            
            if (indexPath.row == 3) {
                leftViewText = @"资产品牌:";
                placeholder = @"请输入资产名称（必填）";
                text = _furnitureModel.brand;
            }
            if (indexPath.row == 5) {
                leftViewText = @"设备序列号:";
                placeholder = @"请输入设备序列号";
                text = _furnitureModel.serial;
            }
            if (indexPath.row == 6) {
                leftViewText = @"设备IMEI:";
                placeholder = @"请输入设备IMEI";
                text = _furnitureModel.fimei;
            }
            UILabel *leftViewLabel = (UILabel *)cell.textField.leftView;
            cell.textField.placeholder = placeholder;
            leftViewLabel.text = leftViewText;
            cell.textField.text = text;
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [tableView addLineforPlainCell:cell forRowAtIndexPath:indexPath withLeftSpace:10];
            return cell;
        }
        if (indexPath.row == 4) {
            static NSString *cellId = @"cellId4";
            AddAssetTableViewPurchase_dateCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
            if (!cell) {
                cell = [[AddAssetTableViewPurchase_dateCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
                cell.delegate = self;
            }
            [tableView addLineforPlainCell:cell forRowAtIndexPath:indexPath withLeftSpace:10];
            cell.furnitureModel = _furnitureModel;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        
        if (indexPath.row >= kManuallyRows) {
            static NSString *cellId = @"cellId1";
            AddAssetTableViewCell1 *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
            if (!cell) {
                cell = [[AddAssetTableViewCell1 alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            OthersModel *othersModel = _furnitureModel.others[indexPath.row - kManuallyRows];
            
            UILabel *leftViewLabel = (UILabel *)cell.textField.leftView;
            leftViewLabel.text = othersModel.key;
            cell.textField.text = othersModel.value;
            
            
            [tableView addLineforPlainCell:cell forRowAtIndexPath:indexPath withLeftSpace:10];
            
            return cell;
        }
    }
    
    return nil;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (_isAuto) {
        return 1;
    }
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_isAuto) {
        return 3;
    }
    if (section == 1) {
        return 1;
    }
    return kManuallyRows + _furnitureModel.others.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_isAuto) {
        if (indexPath.row == 2) {
            return 90;
        }
        return 45;
    }
    return 45;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 45)];
        view.backgroundColor = [UIColor clearColor];
        return view;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 1){
        return 10;
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        [self.clickDelegate addOthers];
    }
}

#pragma mark - AddAssetTableViewCellDelegate

- (void)showCheckModelSheet{
    [self.clickDelegate showCheckModelSheet];
}

- (void)AutomaticMatchingButtonClick{
    [self.clickDelegate AutomaticMatchingButtonClick];
}

- (void)purchase_dateTextFieldClickWithTextField:(UITextField *)textField{
    [self.clickDelegate purchase_dateTextFieldClickWithTextField:textField];
}




#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    switch (textField.tag - 1001) {
        case 1:{
            _furnitureModel.model = textField.text;
            break;
        }
        case 2:{
            _furnitureModel.name = textField.text;
            break;
        }
        case 3:{
            _furnitureModel.brand = textField.text;
            break;
        }
        case 4:{
            _furnitureModel.purchase_date = textField.text;
            break;
        }
        case 5:{
            _furnitureModel.serial = textField.text;
            break;
        }
        case 6:{
            _furnitureModel.fimei = textField.text;
            break;
        }
        default:
            break;
    }
    return YES;
}


@end
