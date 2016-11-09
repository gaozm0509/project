//
//  PsersonalInfoViewController.m
//  HouseKeeper
//
//  Created by 高泽民 on 16/11/7.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "PsersonalInfoViewController.h"
#import "PsersonalInfoTableView.h"
#import "EditPsersonalInfoViewController.h"

@interface PsersonalInfoViewController ()<BaseTableViewDelegate,PsersonalInfoTableViewDelegate>

@property (nonatomic, strong) PsersonalInfoTableView *tableView;

@end

@implementation PsersonalInfoViewController

#pragma mark - Cycle life
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人信息";
    
    [self.view addSubview:self.tableView];
    
    [self netRequest];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Getter and setter

- (PsersonalInfoTableView *)tableView{
    if (!_tableView) {
        _tableView = [[PsersonalInfoTableView alloc] initWithFrame:kViewFrame];
        _tableView.clickDelegate = self;
        _tableView.editGenderDelegate = self;
    }
    return _tableView;
}

#pragma mark - Delegate

- (void)BaseTableViewClickWithIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 1) {
        //编辑name
    }
    else{
        //编辑nickName
        
    }
    NSString *title = indexPath.row == 1 ? @"姓名" : @"昵称";
    WS(weakSelf);
    EditInfoBlock block = ^(UserAccout *userAccout){
        weakSelf.tableView.userAccout = userAccout;
        [weakSelf.tableView reloadData];
    };
    [self pushNewViewController:@"EditPsersonalInfoViewController" params:@{@"type":[NSString stringWithFormat:@"%ld",indexPath.row],@"userAccout":_tableView.userAccout,@"title":title,@"block":block}];
}

- (void)editGenderWithGender:(NSInteger)gender{
    [self netRequest_editGender:(NSInteger)gender];
}

#pragma mark - Net request

- (void)netRequest{
    [kApi_member_info httpRequestWithParams:nil networkMethod:Post andBlock:^(id data, NSError *error) {
        if (error) {
            [self showError:error];
            return ;
        }
        if ([data[@"code"] integerValue] == 1) {
            
            UserAccout *userAccout = [[UserAccout alloc] initWithDic:data[@"data"]];
            _tableView.userAccout = userAccout;
            
        }
    }];
}

- (void)netRequest_editGender:(NSInteger)gender{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:_tableView.userAccout.nickname forKey:@"nickname"];
    [params setValue:_tableView.userAccout.name forKey:@"name"];
    [params setValue:@(gender) forKey:@"gender"];
    [params setValue:_tableView.userAccout.birth forKey:@"birth"];
    [kApi_member_update httpRequestWithParams:params networkMethod:Post andBlock:^(id data, NSError *error) {
        if (error) {
            [self showError:error];
            return ;
        }
        if ([data[@"code"] integerValue] == 1) {
            _tableView.userAccout = [[UserAccout alloc] initWithDic:data[@"data"]];
            [_tableView reloadData];
        }
    }];
}

#pragma mark - Event method



#pragma mark - Pravit method

@end
