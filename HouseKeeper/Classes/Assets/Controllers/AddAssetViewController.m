//
//  AddAssetViewController.m
//  HouseKeeper
//
//  Created by 高泽民 on 16/10/15.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "AddAssetViewController.h"
#import "ActionSheetStringPicker.h"
#import "ActionSheetDatePicker.h"
#import "AddAssetTableView.h"
#import "AssetAddOthersSheetView.h"

@interface AddAssetViewController ()<AddAssetTableViewDelegate>

@property (nonatomic, strong) AddAssetTableView *tableView;

@property (nonatomic, strong) FurnitureModel *furnitureModel;

@property (nonatomic, strong) AssetAddOthersSheetView *addOthersSheetView;

@property (nonatomic, strong) UIButton *submitButton;

@end

@implementation AddAssetViewController

#pragma mark - Cycle life
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"添加资产";
    
    _furnitureModel = [FurnitureModel new];
    _furnitureModel.room_id = self.receiveParams[@"roomId"];
    _furnitureModelBlock = self.receiveParams[@"block"];
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.submitButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Getter and setter

- (AddAssetTableView *)tableView{
    if (!_tableView) {
        _tableView = [[AddAssetTableView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height - 45 - kNavHeight)];
        _tableView.clickDelegate = self;
        _tableView.furnitureModel = _furnitureModel;
    }
    return _tableView;
}

//提交按钮
- (UIButton *)submitButton{
    if (!_submitButton) {
        _submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _submitButton.frame = CGRectMake(0, kScreen_Height - 45 - kNavHeight, kScreen_Width, 45);
        [_submitButton setTitle:@"提交" forState:UIControlStateNormal];
        [_submitButton setTitleColor:KMajorColor forState:UIControlStateNormal];
        _submitButton.titleLabel.font = kFont16;
        _submitButton.backgroundColor = [UIColor whiteColor];
        [_submitButton addTarget:self action:@selector(submitButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitButton;
}

- (AssetAddOthersSheetView *)addOthersSheetView{
    if (!_addOthersSheetView) {
        _addOthersSheetView = [[AssetAddOthersSheetView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 240)];
        [_addOthersSheetView.savebutton addTarget:self action:@selector(addOthersSumbit) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addOthersSheetView;
}

#pragma mark - Delegate
#pragma mark AddAssetTableViewDelegate

- (void)showCheckModelSheet{
    NSMutableDictionary *params = [NSMutableDictionary new];
    [params setValue:@"furniture" forKey:@"type"];
    [kApi_info_options httpRequestWithParams:params networkMethod:Post andBlock:^(id data, NSError *error) {
        if (error) {
            [self showError:error];
            return ;
        }
        
        if ([data[@"code"] integerValue] == 1) {
            RoomTypeList *furnitureTypeList = [[RoomTypeList alloc]initWithDic:data[@"data"]];
            
            NSMutableArray *idList = [NSMutableArray new];
            NSMutableArray *nameList = [NSMutableArray new];
            
            for (RoomType *furnitureType in furnitureTypeList.dataList) {
                [idList addObject:furnitureType.id];
                [nameList addObject:furnitureType.name];
            }
            
            [ActionSheetStringPicker showPickerWithTitle:@"选择设备类型" rows:nameList initialSelection:0 doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                
                _furnitureModel.type = selectedValue;
                _furnitureModel.type_id = [idList objectAtIndex:selectedIndex];
                [_tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
                
            } cancelBlock:nil origin:self.view];
        
        }
    }];

}

- (void)AutomaticMatchingButtonClick{
    if (_furnitureModel.model.length == 0) {
        [self showHudTipStr:@"请填写设备型号"];
        return;
    }
    NSMutableDictionary *params = [NSMutableDictionary new];
    [params setValue:_furnitureModel.model forKey:@"model"];
    [kApi_furniture_auto httpRequestWithParams:params networkMethod:Post andBlock:^(id data, NSError *error) {
        if (error) {
            [self showError:error];
            return;
        }
        if ([data[@"code"] integerValue] == 1) {
            
            FurnitureModel *model = [[FurnitureModel alloc]initWithDic:data[@"data"]];
            _furnitureModel.brand = model.brand;
            _furnitureModel.name = model.name;
            _furnitureModel.others = model.others;
            _tableView.isAuto = NO;
            _tableView.furnitureModel = _furnitureModel;
            
        }
    }];
}

- (void)purchase_dateTextFieldClickWithTextField:(UITextField *)textField{
    NSDate *selectedDate = [NSDate date];
    if (textField.text.length != 0) {
        selectedDate = [NSDate dateFromString:textField.text withFormat:@"yyyy-MM-dd"];
    }
    [ActionSheetDatePicker showPickerWithTitle:@"购买时间" datePickerMode:UIDatePickerModeDate selectedDate:selectedDate doneBlock:^(ActionSheetDatePicker *picker, id selectedDate, id origin) {
        
        textField.text = [NSDate stringFromDate:selectedDate withFormat:@"yyyy-MM-dd"];
        _furnitureModel.purchase_date = textField.text;
        
    } cancelBlock:nil origin:self.view];
}

//添加自动以属性
- (void)addOthers{
    [self.addOthersSheetView show];
}


//提交furniture
- (void)submitButtonClick{
    [self netRequest];
}

#pragma mark - Net request

- (void)netRequest{
    
    [self verifyFurnitureModel];
    
    NSMutableDictionary *params = [NSMutableDictionary new];
    [params setValue:_furnitureModel.room_id forKey:@"room_id"];
    [params setValue:_furnitureModel.type_id forKey:@"furniture_type_id"];
    [params setValue:_furnitureModel.fimei forKey:@"fimei"];
    [params setValue:_furnitureModel.name forKey:@"name"];
    [params setValue:_furnitureModel.brand forKey:@"brand"];
    [params setValue:_furnitureModel.schedule_period forKey:@"schedule_period"];
    [params setValue:_furnitureModel.model forKey:@"model"];
    [params setValue:_furnitureModel.serial forKey:@"serial"];
    [params setValue:_furnitureModel.purchase_date forKey:@"purchase_date"];
    [params setValue:_furnitureModel.schedule forKey:@"schedule"];
    [params setValue:_furnitureModel.invoice forKey:@"invoice"];
    [params setValue:_furnitureModel.others forKey:@"others"];
    [params setValue:_furnitureModel.created_by forKey:@"created_by"];
    [params setValue:@"0" forKey:@"schedule_period"];
    
    NSMutableArray *othersArr = [NSMutableArray array];
    
    for (OthersModel *othersModel in _furnitureModel.others) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setValue:othersModel.value forKey:othersModel.key];
        [othersArr addObject:dic];
    }
    
    NSString *othersJson = [NSString JSONString:othersArr];
    [params setValue:othersJson forKey:@"others"];
    
    [kApi_furniture_create httpRequestWithParams:params networkMethod:Post andBlock:^(id data, NSError *error) {
        if (error) {
            [self showError:error];
        }
        if ([data[@"code"] integerValue] == 1) {
            FurnitureModel *furnitureModel = [[FurnitureModel alloc]initWithDic:data[@"data"]];
            if (_furnitureModelBlock) {
                _furnitureModelBlock(furnitureModel);
                [self.navigationController popViewControllerAnimated:YES];
            }
        }
    }];
}

#pragma mark - Event method

- (void)addOthersSumbit{
    if (_addOthersSheetView.nameField.text.length == 0) {
        [self showHudTipStr:@"请输入属性名称"];
        return;
    }if (_addOthersSheetView.valueField.text.length == 0) {
        [self showHudTipStr:@"请输入属性值"];
        return;
    }
    
    [self.addOthersSheetView hid];
    
    OthersModel *otherModel = [OthersModel new];
    otherModel.key = _addOthersSheetView.nameField.text;
    otherModel.value = _addOthersSheetView.valueField.text;
    [_furnitureModel.others addObject:otherModel];
    [_tableView reloadData];
}

#pragma mark - Pravit method

- (BOOL)verifyFurnitureModel{
    if (_furnitureModel.model.length == 0) {
        [self showHudTipStr:@"请输入设备型号"];
        return NO;
    }
    if (_furnitureModel.name.length == 0) {
        [self showHudTipStr:@"请输入资产名称"];
        return NO;
    }
    if (_furnitureModel.brand.length == 0) {
        [self showHudTipStr:@"请输入资产品牌"];
        return NO;
    }
    if (_furnitureModel.purchase_date.length == 0) {
        [self showHudTipStr:@"请选择购买时间"];
        return NO;
    }
    return YES;
}

@end
