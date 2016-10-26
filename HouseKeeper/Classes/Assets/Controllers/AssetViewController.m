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
#import "ActionSheetPicker.h"

@interface AssetViewController ()<AssetTableViewDelegate,BaseSheetViewDelegate>

@property (nonatomic, strong) AssetTableView *tableView;

@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UIButton *rightButton;
@property (nonatomic, strong) AsssetAddRoomSheetView *sheetView;

@property (nonatomic, strong) StateModel *model;
@property (nonatomic ,strong) RoomListModel *roomListModel;

@property (nonatomic, strong) NSString *typeId;//被选中的room的typeId；

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
        [_rightButton setImage:Image(@"搜索") forState:UIControlStateNormal];
        _rightButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        _rightButton.tag = 1002;
        [_rightButton addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightButton;
}

#pragma mark - Delegate

- (void)BaseSheetViewSave{
    NSLog(@"BaseSheetViewSave");
    
    NSMutableDictionary *params = [NSMutableDictionary new];
    [params setValue:_model.id forKey:@"state_id"];
    [params setValue:_typeId forKey:@"type_id"];
    [params setValue:_sheetView.roomNameField.text forKey:@"name"];
    
    [kApi_room_create httpRequestWithParams:params networkMethod:Post andBlock:^(id data, NSError *error) {
        if (error) {
            [self showError:error];
            return ;
        }
        if ([data[@"code"] integerValue] == 0) {
            [self showHudTipStr:@"保存成功"];
        }
    }];
}

#pragma mark AssetTableViewDelegate

//前去采集
- (void)assetCollection{

}

//更换
- (void)assetChange{

}

//点击cell
- (void)clickTableViewCellWithModel:(RoomModel *)model{
    [self pushNewViewController:@"AssetRoomViewController" params:@{@"model":model}];
}

#pragma mark - Net request

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
        }
    }];
}

- (void)netRequest_GetRooms{
    NSMutableDictionary *params = [NSMutableDictionary new];
    [params setValue:_model.id forKey:@"state_id"];
    [kApi_furniture httpRequestWithParams:params networkMethod:Post andBlock:^(id data, NSError *error) {
        if (error) {
            [self showError:error];
            return ;
        }
        if ([data[@"code"] integerValue] == 1) {
            
            
            NSDictionary *dataDic = data[@"data"];
            
            NSMutableArray *dataList = [NSMutableArray new];
            NSArray *allKeys = [dataDic allKeys];
            for (NSString *key in allKeys) {
                [dataList addObject:[dataDic objectForKey:key]];
            }
            
            RoomClassModel *roomClassModel = [[RoomClassModel alloc]initWithDic:@{@"data":dataList}];
            _tableView.roomClassModel = roomClassModel;
        }
    }];
}

#pragma mark - Event

- (void)click:(UIButton *)button{
    if (button.tag == 1001) {
        //添加按钮
        [self sheetViewShow];
    }
    if (button.tag == 1002) {
        //搜索按钮
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
            
            [ActionSheetStringPicker showPickerWithTitle:@"房间类型" rows:nameList initialSelection:0 doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                
                _typeId = [idList objectAtIndex:selectedIndex];
                _sheetView.roomTypeField.text = selectedValue;
                
            } cancelBlock:nil origin:self.view];

            
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
