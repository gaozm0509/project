//
//  AssetRoomViewController.m
//  HouseKeeper
//
//  Created by 高泽民 on 16/9/11.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "AssetRoomViewController.h"
#import "AssetRoomTableView.h"
#import "AddAssetViewController.h"


@interface AssetRoomViewController ()<AssetRoomTableViewDelegate>

@property (nonatomic, strong) AssetRoomTableView *tableView;
@property (nonatomic, strong) UIButton *addButton;
@property (nonatomic, strong) RoomModel *roomModel;

@end

@implementation AssetRoomViewController

#pragma mark - Cycle life
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _roomModel = self.receiveParams[@"model"];
    self.title = _roomModel.name;
    
    [self.view addSubview:self.tableView];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.addButton];
    
    [self netRequest];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Getter and setter

- (AssetRoomTableView *)tableView{
    if (!_tableView) {
        _tableView = [[AssetRoomTableView alloc]initWithFrame:kViewFrame];
        _tableView.model = _roomModel;
        _tableView.clickDelegate = self;
    }
    return _tableView;
}

- (UIButton *)addButton{
    if (!_addButton) {
        _addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _addButton.frame = CGRectMake(0, 0, 44, 44);
        [_addButton setImage:Image(@"添加") forState:UIControlStateNormal];
        _addButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        _addButton.tag = 1001;
        [_addButton addTarget:self action:@selector(addFurnitureView) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addButton;
}

#pragma mark - Delegate

#pragma mark AssetRoomTableViewDelegate

- (void)deleteFurnitureWithModel:(FurnitureModel *)model{
    [self netRequest_deleteFurnitureWithModel:model];
}

- (void)clickTableViewCellWithModel:(FurnitureModel *)model indexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        [self pushNewViewController:@"AsssetServiceViewController" params:@{@"model":model}];
    }
    else{
        [self pushNewViewController:@"FurnitureDetailsViewController" params:@{@"model":model}];
    }
}

- (void)showAddFurnitureView{

}

#pragma mark - Net request



#pragma mark - Event method

- (void)netRequest_deleteFurnitureWithModel:(FurnitureModel *)model{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:model.id forKey:@"furniture_id"];
    [kApi_furniture_delete httpRequestWithParams:params hudView:self.hudView networkMethod:Post andBlock:^(id data, NSError *error) {
        if (error) {
            [self showError:error];
            return ;
        }
        if ([data[@"code"] integerValue] == 1) {
            [self.roomModel.furnitures removeObject:model];
            self.tableView.model = self.tableView.model;
        }
    }];
}

- (void)addFurnitureView{
    FurnitureModelBlock block = ^(FurnitureModel *model){
        [_roomModel.furnitures addObject:model];
        _tableView.model = _roomModel;
    };
    [self pushNewViewController:@"AddAssetViewController" params:@{@"roomId":_roomModel.id,@"block":block}];
}

#pragma mark - Pravit method

@end
