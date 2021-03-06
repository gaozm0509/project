//
//  SettingViewController.m
//  HouseKeeper
//
//  Created by 高泽民 on 16/10/19.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "SettingViewController.h"
#import "SettingTableView.h"
#import "LoginViewController.h"

@interface SettingViewController ()<BaseTableViewDelegate>

@property (nonatomic, strong) SettingTableView *tableView;

@property (nonatomic, strong) UIButton *logOutButton;

@end

@implementation SettingViewController

#pragma mark - Cycle life
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    
    [self setupSubViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Getter and setter

- (SettingTableView *)tableView{
    if (!_tableView) {
        _tableView = [[SettingTableView alloc] initWithFrame:kViewFrame];
        _tableView.clickDelegate = self;
    }
    return _tableView;
}

- (UIButton *)logOutButton{
    if (!_logOutButton) {
        _logOutButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_logOutButton setTitle:@"退出登录" forState:UIControlStateNormal];
        [_logOutButton setTitleColor:KMajorColor forState:UIControlStateNormal];
        _logOutButton.titleLabel.font = kFont14;
        _logOutButton.backgroundColor = [UIColor whiteColor];
        [_logOutButton setTag:1001];
        [_logOutButton addTarget:self action:@selector(logOutButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _logOutButton;
}

#pragma mark - Delegate

#pragma mark BaseTableViewDelegate

- (void)BaseTableViewClickWithIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0){
        //个人信息
        [self pushNewViewController:@"PsersonalInfoViewController"];
    }
    if (indexPath.section == 1){
        //用户协议
        [self pushNewViewController:@"PC_AgreementAboutViewController" params:@{@"plistKey":@"Agreement",@"title":@"用户协议"}];
    }
    if(indexPath.section == 2){
        //关于我们
        [self pushNewViewController:@"PC_AgreementAboutViewController" params:@{@"plistKey":@"About",@"title":@"关于我们"}];
    }
}

#pragma mark - Net request



#pragma mark - Event method

- (void)logOutButtonClick:(UIButton *)button{
    
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"退出登录" message:nil preferredStyle:UIAlertControllerStyleActionSheet];

    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    UIAlertAction *doneAction = [UIAlertAction actionWithTitle:@"退出" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIWindow *window = [[UIApplication sharedApplication].delegate window];
        LoginViewController *rootVC = [LoginViewController new];
        rootVC.isFirstStartUp = YES;
        window.rootViewController = rootVC;
        
        //通知服务器推出操作
        [kApi_member_signOut httpRequestWithParams:nil networkMethod:Post andBlock:^(id data, NSError *error) {
        }];
        
        //清除UserDefaults中的缓存
        [UsersManager loginOutAndCleanUserDefaults];
        
        //清除文件中的缓存
        [self clearCachingAndFinishBlock:nil];
        
    }];
                                  
    [alertVC addAction:doneAction];
    [alertVC addAction:cancelAction];
    
     [self presentViewController:alertVC animated:YES completion:nil];
}

#pragma mark - Pravit method

- (void)setupSubViews{
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.logOutButton];
    
    WS(weakSelf);
    [_logOutButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.view.mas_bottom);
        make.left.equalTo(weakSelf.view);
        make.right.equalTo(weakSelf.view.mas_right);
        make.height.offset(45);
    }];
}

@end
