//
//  IntegralViewController.m
//  HouseKeeper
//
//  Created by 高泽民 on 16/8/11.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "IntegralViewController.h"
#import "IntegralTableView.h"

@interface IntegralViewController ()

@property (nonatomic, strong) IntegralTableView *tabelView;

@end

@implementation IntegralViewController

#pragma mark - Cycle life
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"积分";
    [self.view addSubview:self.tabelView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Getter and setter

- (IntegralTableView *)tabelView{
    if (!_tabelView) {
        CGRect frame = CGRectMake(0, 0, kScreen_Width, kScreen_Height - kNavHeight);
        _tabelView = [[IntegralTableView alloc]initWithFrame:frame style:UITableViewStylePlain];
    }
    return _tabelView;
}

#pragma mark - Delegate



#pragma mark - Net request



#pragma mark - Event method



#pragma mark - Pravit method

@end
