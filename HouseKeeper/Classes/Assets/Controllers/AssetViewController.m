//
//  AssetViewController.m
//  HouseKeeper
//
//  Created by 高泽民 on 16/7/16.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "AssetViewController.h"
#import "AssetTableView.h"

@interface AssetViewController ()<AssetTableViewDelegate>

@property (nonatomic, strong) AssetTableView *tableView;

@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UIButton *rightButton;

@end

@implementation AssetViewController

#pragma mark - Lefe cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的资产";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.leftButton];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.rightButton];
    
    [self.view addSubview:self.tableView];
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

#pragma mark AssetTableViewDelegate

//前去采集
- (void)assetCollection{

}

//更换
- (void)assetChange{

}

//点击cell
- (void)clickTableViewCellWithModel:(NSString *)model{
    [self pushNewViewController:@"AssetRoomViewController" params:@{@"title":model}];
}

#pragma mark - Net request



#pragma mark - Event

- (void)click:(UIButton *)button{
    if (button.tag == 1001) {
        //添加按钮
        
    }
    if (button.tag == 1002) {
        //搜索按钮
    }
}

#pragma mark - Pravit method




@end
