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
@property (nonatomic, strong) UIButton *rightButton;
@property (nonatomic, strong) RoomModel *roomModel;

@end

@implementation AssetRoomViewController

#pragma mark - Cycle life
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _roomModel = self.receiveParams[@"model"];
    self.title = _roomModel.name;
    
    [self.view addSubview:self.tableView];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.rightButton];
    
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

- (UIButton *)rightButton{
    if (!_rightButton) {
        _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightButton.frame = CGRectMake(0, 0, 44, 44);
        [_rightButton setImage:Image(@"搜索") forState:UIControlStateNormal];
        _rightButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        _rightButton.tag = 1001;
        [_rightButton addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightButton;
}



#pragma mark - Delegate

#pragma mark AssetRoomTableViewDelegate

- (void)clickTableViewCellWithModel:(FurnitureModel *)model{
    [self pushNewViewController:@"FurnitureDetailsViewController" params:@{@"model":model}];
}

- (void)showAddFurnitureView{
    FurnitureModelBlock block = ^(FurnitureModel *model){
        [_roomModel.furnitures addObject:model];
        _tableView.model = _roomModel;
    };
    [self pushNewViewController:@"AddAssetViewController" params:@{@"roomId":_roomModel.id,@"block":block}];
}


#pragma mark - Net request



#pragma mark - Event method

- (void)click:(UIButton *)button{
    if (button.tag == 1001) {
        //搜索

    }
    
}

#pragma mark - Pravit method

@end
