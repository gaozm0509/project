//
//  SecondContactsViewController.m
//  HouseKeeper
//
//  Created by 高泽民 on 16/12/4.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "SecondContactsViewController.h"
#import "PsersonalInfoTableViewCell.h"
#import "EditPsersonalInfoViewController.h"
#import "BaseTableView.h"

@interface SecondContactsViewController ()<UITableViewDelegate,UITableViewDataSource,PsersonalInfoTableViewCellDelegate>

@property (nonatomic, strong) BaseTableView *tableView;
@property (nonatomic, strong) UserAccout *userAccout;

@property (nonatomic, strong) UIButton *buttomButton;

@property (nonatomic, strong) UIButton *rightButton;


@end

@implementation SecondContactsViewController

#pragma mark - life circle
- (void)dealloc {
    NSLog(@"%s",__func__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"第二联系人";
    _userAccoutBlock = self.receiveParams[@"block"];
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.buttomButton];
    [self netRequest];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - method

- (void)editUserInfoWithIndexPath:(NSIndexPath *)indexPath{
    NSString *title = indexPath.row == 1 ? @"手机号" : @"姓名";
    WS(weakSelf);
    EditInfoBlock block = ^(UserAccout *userAccout){
        weakSelf.userAccout = userAccout;
        if (weakSelf.userAccoutBlock) {
            weakSelf.userAccoutBlock(_userAccout);
        }
        [weakSelf.tableView reloadData];
    };
    [self pushNewViewController:@"EditPsersonalInfoViewController" params:@{@"type":[NSString stringWithFormat:@"%ld",indexPath.row],@"userAccout":_userAccout,@"title":title,@"block":block,@"isSecond":@"YES"}];
}

#pragma mark - event

//新增第二联系人或者更新
- (void)submitClick{
    [self netRequestUpdataUserInfo];
}

- (void)deleteInfo{
    [self netRequestDeleteUserInfo];
}

#pragma mark - UITableViewDelegate && UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        static NSString *cellID = @"cellid0";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            [tableView addLineforPlainCell:cell forRowAtIndexPath:indexPath withLeftSpace:10];
            StateModel *stateModel = [UsersManager stateModel];
            cell.textLabel.text = stateModel.address;
            cell.textLabel.font = kFont14;
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        return cell;
    }
    else if(indexPath.section == 1){
        static NSString *cellId = @"PsersonalInfoTableViewCell11";
        PsersonalInfoTableViewCell1 *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[PsersonalInfoTableViewCell1 alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        
        [tableView addLineforPlainCell:cell forRowAtIndexPath:indexPath withLeftSpace:0];
        
        if (indexPath.row == 0) {
            cell.label.text = [NSString stringWithFormat:@"姓名 %@",_userAccout.b_name];
        }
        else if(indexPath.row == 1){
            cell.label.text = [NSString stringWithFormat:@"手机号 %@",_userAccout.b_mobile];
        }
        else{
            cell.label.text = [NSString stringWithFormat:@"出生日期 %@",_userAccout.b_birth];
        }
        return cell;

    }
    else{
        static NSString *cellId = @"PsersonalInfoTableViewCell12";
        PsersonalInfoTableViewCell2 *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[PsersonalInfoTableViewCell2 alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.delegate = self;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        [tableView addLineforPlainCell:cell forRowAtIndexPath:indexPath withLeftSpace:0];
        
        if (_userAccout.b_gender.integerValue == 1) {
            cell.manButton.selected = YES;
            cell.wemanButton.selected = NO;
        }
        else{
            cell.manButton.selected = NO;
            cell.wemanButton.selected = YES;
        }
        return cell;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 1) {
        return 2;
    }
    else if(section == 2){
        return 1;
    }
    else{
    
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 && indexPath.row == 0) {
        return 45;
    }
    return 45;
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section{
    view.tintColor = [UIColor clearColor];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    }
    return 10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        [self editUserInfoWithIndexPath:indexPath];
    }
}


#pragma mark - getter && setter

- (BaseTableView *)tableView{
    if (!_tableView) {
        _tableView = [[BaseTableView alloc] initWithFrame:kViewFrame];
        _tableView.height = _tableView.height - 45;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = kBackgroundColor;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (UIButton *)buttomButton{
    if (!_buttomButton) {
        _buttomButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 45)];
        _buttomButton.top = self.tableView.bottom;
        [_buttomButton setTitle:@"确定" forState:UIControlStateNormal];
        [_buttomButton setTitleColor:KMajorColor forState:UIControlStateNormal];
        [_buttomButton addTarget:self action:@selector(submitClick) forControlEvents:UIControlEventTouchUpInside];
        _buttomButton.titleLabel.font = kFont14;
        _buttomButton.backgroundColor = [UIColor whiteColor];
    }
    return _buttomButton;
}

- (UIButton *)rightButton{
    if (!_rightButton) {
        _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightButton.frame = CGRectMake(0, 0, 30, 20);
        [_rightButton setTitle:@"删除" forState:UIControlStateNormal];
        [_rightButton setTitleColor:KMajorColor forState:UIControlStateNormal];
        _rightButton.titleLabel.font = kFont12;
        [_rightButton addTarget:self action:@selector(deleteInfo) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightButton;
}

#pragma mark - API

//获取个人信息
- (void)netRequest{
    [kApi_member_info httpRequestWithParams:nil networkMethod:Post andBlock:^(id data, NSError *error) {
        if (error) {
            [self showError:error];
            return ;
        }
        if ([data[@"code"] integerValue] == 1) {
            
            _userAccout = [[UserAccout alloc] initWithDic:data[@"data"]];
            [self.tableView reloadData];
            if (_userAccout.b_mobile.length !=0 ) {
                self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightButton];
            }
            
        }
    }];
}

//编辑性别
- (void)netRequest_editGender:(NSInteger)gender{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:_userAccout.b_name forKey:@"b_name"];
    [params setValue:_userAccout.b_mobile forKey:@"b_mobile"];
    [params setValue:@(gender) forKey:@"b_gender"];
    [params setValue:_userAccout.b_birth forKey:@"b_birth"];
    [kApi_member_update httpRequestWithParams:params hudView:self.hudView networkMethod:Post andBlock:^(id data, NSError *error) {
        if (error) {
            [self showError:error];
            return ;
        }
        if ([data[@"code"] integerValue] == 1) {
            _userAccout = [[UserAccout alloc] initWithDic:data[@"data"]];
            if (self.userAccoutBlock) {
                self.userAccoutBlock(_userAccout);
            }
            [_tableView reloadData];
        }
    }];
}


- (void)netRequestUpdataUserInfo{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    if (_userAccout.b_name.length == 0) {
        [self showHudTipStr:@"姓名不能为空"];
        return;
    }
    if (_userAccout.b_mobile.length == 0) {
        [self showHudTipStr:@"手机号不能为空"];
        return;
    }
    
    [params setValue:_userAccout.b_name forKey:@"b_name"];
    [params setValue:_userAccout.b_mobile forKey:@"b_mobile"];
    [params setValue:_userAccout.b_gender forKey:@"b_gender"];
    [params setValue:_userAccout.b_birth forKey:@"b_birth"];
    [kApi_member_update httpRequestWithParams:params hudView:nil networkMethod:Post andBlock:^(id data, NSError *error) {
        if (error) {
            [self showError:error];
            return ;
        }
        if ([data[@"code"] integerValue] == 1) {
            _userAccout = [[UserAccout alloc] initWithDic:data[@"data"]];
            [_tableView reloadData];
            [self showHudTipStr:@"保存成功"];
        }
    }];
}

- (void)netRequestDeleteUserInfo{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:@"" forKey:@"b_name"];
    [params setValue:@"" forKey:@"b_mobile"];
    [params setValue:@"" forKey:@"b_gender"];
    [kApi_member_update httpRequestWithParams:params hudView:nil networkMethod:Post andBlock:^(id data, NSError *error) {
        if (error) {
            [self showError:error];
            return ;
        }
        if ([data[@"code"] integerValue] == 1) {
            _userAccout = [[UserAccout alloc] initWithDic:data[@"data"]];
            [_tableView reloadData];
        }
    }];
}

#pragma mark - override

- (void)editGenderWithGender:(NSInteger)gender{
    _userAccout.gender = [NSString stringWithFormat:@"%ld",gender];
}


@end
