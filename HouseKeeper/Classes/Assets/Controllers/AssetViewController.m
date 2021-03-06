//
//  AssetViewController.m
//  HouseKeeper
//
//  Created by 高泽民 on 16/7/16.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "AssetViewController.h"
#import "AssetTableView.h"
#import "AsssetAddRoomSheetView.h"
#import "ActionSheetStringPicker.h"
#import "AssetBatchAddRoomSheetView.h"

@interface AssetViewController ()<AssetTableViewDelegate,BaseSheetViewDelegate,AssetBatchAddRoomSheetViewDeleagte>

@property (nonatomic, strong) AssetTableView *tableView;

@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UIButton *rightButton;
@property (nonatomic, strong) AsssetAddRoomSheetView *sheetView;
@property (nonatomic, strong) AssetBatchAddRoomSheetView *batchSheetView;

@property (nonatomic, strong) StateModel *model;
@property (nonatomic ,strong) RoomListModel *roomListModel;

@property (nonatomic, strong) NSString *typeId;//被选中的room的typeId；

@property (nonatomic, strong) RoomTypeList *roomTypeList;

@property (nonatomic, strong) AssetDeleteRoomSheetView *editSheet;
@property (nonatomic, strong) RoomModel *editRoomModel;

@end

@implementation AssetViewController

#pragma mark - Lefe cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的资产";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.leftButton];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.rightButton];
    
    [self.view addSubview:self.tableView];
    [self netRequest];
    
    _roomTypeList = [[RoomTypeList alloc] initWithDic:@{}];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Getter and setter

- (AssetTableView *)tableView{
    if (!_tableView) {
        _tableView = [[AssetTableView alloc]initWithFrame:kViewFrame];
        _tableView.clickDelegate = self;
        _tableView.isHeadOpen = YES;
        _tableView.isFootOpen = NO;
        
        WS(weakSelf);
        [_tableView setMorePage:^(int Page) {
            [weakSelf netRequest_GetRooms];
        }];
    }
    return _tableView;
}

- (UIButton *)leftButton{
    if (!_leftButton) {
        _leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftButton.frame = CGRectMake(0, 0, 44, 44);
        [_leftButton setImage:Image(@"添加") forState:UIControlStateNormal];
        _leftButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _leftButton.tag = 1001;
        [_leftButton addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftButton;
}

- (UIButton *)rightButton{
    if (!_rightButton) {
        _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightButton.frame = CGRectMake(0, 0, 44, 44);
//        [_rightButton setImage:Image(@"搜索") forState:UIControlStateNormal];
        [_rightButton setTitle:@"预约" forState:UIControlStateNormal];
        [_rightButton setTitleColor:KMajorColor forState:UIControlStateNormal];
        _rightButton.titleLabel.font = kFont14;
        _rightButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        _rightButton.tag = 1002;
        [_rightButton addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightButton;
}

- (AssetBatchAddRoomSheetView *)batchSheetView{
    if (!_batchSheetView) {
        _batchSheetView = [[AssetBatchAddRoomSheetView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 300)];
        _batchSheetView.delegate = self;
        _batchSheetView.textFieldClickDelegate = self;
        _batchSheetView.tag = 2001;
    }
    return _batchSheetView;
}

#pragma mark - Delegate


- (void)BaseSheetViewSave{
    
    NSMutableDictionary *params = [NSMutableDictionary new];
    [params setValue:_model.id forKey:@"state_id"];
    [params setValue:_typeId forKey:@"type_id"];
    [params setValue:_sheetView.roomNameField.text forKey:@"name"];
    
    [kApi_room_create httpRequestWithParams:params networkMethod:Post andBlock:^(id data, NSError *error) {
        if (error) {
            [self showError:error];
            return ;
        }
        if ([data[@"code"] integerValue] == 1) {
            [self showHudTipStr:@"保存成功"];
            [self netRequest_GetRooms];
            [self.sheetView hid];
        }
    }];
}

#pragma mark AssetBatchAddRoomSheetViewDeleagte


- (void)textFieldClickWithIndex:(NSInteger)index{
    NSArray *arr = @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10"];
    
    
    ActionSheetStringPicker *picker = [[ActionSheetStringPicker alloc] initWithTitle:@"数量选择" rows:arr initialSelection:0 doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
        
        _roomTypeList.dataList[index].num = selectedValue;
        _batchSheetView.model = _roomTypeList;
        
    } cancelBlock:nil origin:self.view];
    
    [picker setDoneButton:[picker getDoneButton]];
    [picker setCancelButton:[picker getCancelButton]];
    [picker showActionSheetPicker];
    
}

- (void)AssetBatchAddRoomSheetViewSave{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:_model.id forKey:@"state_id"];
    
    NSMutableArray *roomTypeList = [NSMutableArray array];
    for (RoomType *roomType in _roomTypeList.dataList) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        if (roomType.num.integerValue != 0) {
            [dic setValue:roomType.id forKey:@"type_id"];
            [dic setValue:roomType.name forKey:@"name"];
            [dic setValue:@(roomType.num.integerValue) forKey:@"num"];
            
            [roomTypeList addObject:dic];
        }
    }
    
    [params setValue:[roomTypeList stringTOjson] forKey:@"rooms"];
    [kApi_room_batchcreate httpRequestWithParams:params networkMethod:Post andBlock:^(id data, NSError *error) {
        if (error) {
            [self showError:error];
            return ;
        }
        if ([data[@"code"] integerValue] == 1) {
            [_batchSheetView hid];
            [self netRequest_GetRooms];
        }
    }];
}

#pragma mark BaseSheetViewDelegate

#pragma mark AssetTableViewDelegate

//前去采集
- (void)assetCollection{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:@"room" forKey:@"type"];
    [kApi_info_options httpRequestWithParams:params networkMethod:Post andBlock:^(id data, NSError *error) {
        if (error) {
            [self showError:error];
            return ;
        }
        if ([data[@"code"] integerValue] == 1) {
            [self.batchSheetView show];
            _roomTypeList = [[RoomTypeList alloc] initWithDic:data[@"data"]];
            _batchSheetView.model = _roomTypeList;
        }
    }];
}

// 删除
- (void)deleteTableViewCellWithModel:(RoomModel *)model{
    [self netRequest_deleteRoomWithModel:model];
}

// 编辑
- (void)editTableViewCellWithModel:(RoomModel *)model{
    _editRoomModel = model;
    _editSheet = [[AssetDeleteRoomSheetView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 180)];
    [_editSheet show];
    
    [_editSheet.savebutton addTarget:self action:@selector(editRoom) forControlEvents:UIControlEventTouchUpInside];
}

//更换
- (void)assetChange{

}

//点击cell
- (void)clickTableViewCellWithModel:(RoomModel *)model{
    [self pushNewViewController:@"AssetRoomViewController" params:@{@"model":model}];
}

#pragma mark - Net request

- (void)netRequest_editRoomWithModel:(RoomModel *)roomModel{
    NSMutableDictionary *params = [NSMutableDictionary new];
    [params setValue:@"1" forKey:@"rights"];
    [params setValue:roomModel.id forKey:@"room_id"];
    [params setValue:roomModel.name forKey:@"name"];
    [params setValue:roomModel.area forKey:@"area"];
    [kApi_room_update httpRequestWithParams:params hudView:self.hudView networkMethod:Post andBlock:^(id data, NSError *error) {
        if (error) {
            [self showError:error];
            return ;
        }
        if ([data[@"code"] integerValue] == 1) {
            [self netRequest_GetRooms];
            [self.editSheet hid];
        }
    }];
}

- (void)netRequest_deleteRoomWithModel:(RoomModel *)roomModel{
    NSMutableDictionary *params = [NSMutableDictionary new];
    [params setValue:@"1" forKey:@"rights"];
    [params setValue:roomModel.id forKey:@"room_id"];
    [kApi_room_delete httpRequestWithParams:params hudView:self.hudView networkMethod:Post andBlock:^(id data, NSError *error) {
        if (error) {
            [self showError:error];
            return ;
        }
        if ([data[@"code"] integerValue] == 1) {
            [self netRequest_GetRooms];
        }
    }];
}

- (void)netRequest{
    NSMutableDictionary *params = [NSMutableDictionary new];
    [params setValue:@"1" forKey:@"rights"];
    [kApi_state httpRequestWithParams:params networkMethod:Post andBlock:^(id data, NSError *error) {
        if (error) {
            [self showError:error];
        }
        if ([data[@"code"] integerValue] == 1) {
            StateModelDataModel *dataModel= [[StateModelDataModel alloc]initWithDic:data[@"data"]];
            _model = [dataModel.StateModelList firstObject];
            _tableView.model = _model;
            
            [self netRequest_GetRooms];
            
            [UsersManager saveStateModel:_model];
            [_tableView noDataViewShowDefaultWithDataSource:dataModel.StateModelList];
        }
    }];
}

- (void)netRequest_GetRooms{
    NSMutableDictionary *params = [NSMutableDictionary new];
    [params setValue:_model.id forKey:@"state_id"];
    [kApi_furniture httpRequestWithParams:params networkMethod:Post andBlock:^(id data, NSError *error) {
        _tableView.isMJStop = YES;
        if (error) {
            [self showError:error];
            return ;
        }
        if ([data[@"code"] integerValue] == 1) {
            [_tableView.roomClassModel.roomClasses removeAllObjects];
            
            NSDictionary *dataDic = data[@"data"];
            if (![dataDic isKindOfClass:[NSDictionary class]]) {
                RoomClassModel *roomClassModel = [[RoomClassModel alloc]initWithDic:@{@"data":dataDic}];
                _tableView.roomClassModel = roomClassModel;
            }
            else{
                NSMutableArray *dataList = [NSMutableArray new];
                NSArray *allKeys = [dataDic allKeys];
                for (NSString *key in allKeys) {
                    [dataList addObject:[dataDic objectForKey:key]];
                }
                
                RoomClassModel *roomClassModel = [[RoomClassModel alloc]initWithDic:@{@"data":dataList}];
                _tableView.roomClassModel = roomClassModel;
            }
            
        }
    }];
}

#pragma mark - Event

- (void)editRoom{
    _editRoomModel.name = _editSheet.nameField.text;
    [self netRequest_editRoomWithModel:_editRoomModel];
}

- (void)click:(UIButton *)button{
    if (button.tag == 1001) {
        //添加按钮
        [self sheetViewShow];
    }
    if (button.tag == 1002) {
        //预约
        [self pushNewViewController:@"DoorEntryViewController" params:@{@"priceId":@"1"}];
    }
}

- (void)clickRoomTypeField:(UITextField *)textFiled{
    NSLog(@"clickRoomTypeField");
    NSMutableDictionary *params= [NSMutableDictionary new];
    [params setValue:@"room" forKey:@"type"];
    [kApi_info_options httpRequestWithParams:params networkMethod:Post andBlock:^(id data, NSError *error) {
        if (error) {
            [self showError:error];
            return ;
        }
        if ([data[@"code"] integerValue] == 1) {
            RoomTypeList *dataList = [[RoomTypeList alloc]initWithDic:data[@"data"]];
            NSMutableArray *nameList = [NSMutableArray new];
            NSMutableArray *idList = [NSMutableArray new];
            for (RoomType *roomType in dataList.dataList) {
                [nameList addObject:roomType.name];
                [idList addObject:roomType.id];
            }
           
            ActionSheetStringPicker *picker = [[ActionSheetStringPicker alloc] initWithTitle:@"房间类型" rows:nameList initialSelection:0 doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                
                _typeId = [idList objectAtIndex:selectedIndex];
                _sheetView.roomTypeField.text = selectedValue;
                
            } cancelBlock:nil origin:self.view];
            
            [picker setDoneButton:[picker getDoneButton]];
            [picker setCancelButton:[picker getCancelButton]];
            [picker showActionSheetPicker];
        }
    }];
}

#pragma mark - Pravit method

- (void)sheetViewShow{
    if (!_sheetView) {
        _sheetView = [[AsssetAddRoomSheetView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 240)];
        _sheetView.delegate = self;
        [_sheetView.roomTypeButton addTarget:self action:@selector(clickRoomTypeField:) forControlEvents:UIControlEventTouchUpInside];
    }
    [_sheetView show];
}




@end
