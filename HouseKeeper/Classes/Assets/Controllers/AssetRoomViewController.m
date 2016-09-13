//
//  AssetRoomViewController.m
//  HouseKeeper
//
//  Created by 高泽民 on 16/9/11.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "AssetRoomViewController.h"
#import "AssetRoomTableView.h"

@interface AssetRoomViewController ()

@property (nonatomic, strong) AssetRoomTableView *tableView;
@property (nonatomic, strong) UIButton *rightButton;

@end

@implementation AssetRoomViewController

#pragma mark - Cycle life
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.receiveParams[@"title"];
    
    [self.view addSubview:self.tableView];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.rightButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Getter and setter

- (AssetRoomTableView *)tableView{
    if (!_tableView) {
        _tableView = [[AssetRoomTableView alloc]initWithFrame:kViewFrame];
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



#pragma mark - Net request



#pragma mark - Event method

- (void)click:(UIButton *)button{
    if (button.tag == 1001) {
        //搜索
        
    }
}

#pragma mark - Pravit method

@end
