//
//  LifeServiceViewController.m
//  
//
//  Created by 高泽民 on 16/10/24.
//
//

#import "LifeServiceViewController.h"
#import "LifeServiceCollectionView.h"
#import "KeychainItemWrapper.h"
#import "BannerModel.h"
#import "PC_AgreementAboutViewController.h"


@interface LifeServiceViewController ()<LifeServiceCollectionViewDelegate>

@property(nonatomic, strong) LifeServiceCollectionView *collectionView;
@property (nonatomic, strong) UIButton *rightButton;
@property (nonatomic, strong) BannerListModel *bannerListModel;

@end

@implementation LifeServiceViewController

#pragma mark - Cycle life
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"生活服务";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightButton];
    [self netRequestBanner];
    
    [self.view addSubview:self.collectionView];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Getter and setter

- (UIButton *)rightButton{
    if (!_rightButton) {
        _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightButton.frame = CGRectMake(0, 0, 30, 30);
        [_rightButton setTitle:@"到家" forState:UIControlStateNormal];
        [_rightButton setTitleColor:KMajorColor forState:UIControlStateNormal];
        _rightButton.titleLabel.font = kFont14;
        [_rightButton addTarget:self action:@selector(rightButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightButton;
}

- (LifeServiceCollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 0.5;
        layout.minimumInteritemSpacing = 0;
        _collectionView = [[LifeServiceCollectionView alloc]initWithFrame:kViewFrame collectionViewLayout:layout];
        _collectionView.clickDelegate = self;
    }
    return _collectionView;
}

#pragma mark - Delegate
#pragma mark LifeServiceCollectionViewDelegate

- (void)clickItemWithIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 1:{
            if(indexPath.row == 0){
                //资产录入
                [self pushNewViewController:@"DoorEntryViewController" params:@{@"priceId":@"1"}];
            }
            if(indexPath.row == 1){
                //充值返现
                [self pushNewViewController:@"RechargeViewController"];
                
            }
            if(indexPath.row == 2){
                //深度检测
                [self pushNewViewController:@"DoorEntryViewController" params:@{@"priceId":@"2"}];
                
            }
            if(indexPath.row == 3){
                //空气治理
                [self pushNewViewController:@"AirTreatmentViewController"];
            }
            break;
        }
        case 2:{
            if(indexPath.row == 0){
                //绿植水培

                KeychainItemWrapper *keychain=[[KeychainItemWrapper alloc] initWithIdentifier:kImeiCode accessGroup:nil];
                NSString *imeiCode = [keychain  objectForKey:(id)kSecAttrService];
                
                NSString *url = [NSString stringWithFormat:@"https://kdt.im/-cSggr?mobile=%@&memberid=%@&seckey=%@",[UsersManager phone],[UsersManager memberId],imeiCode];
                [self pushNewViewController:@"WebViewController" params:@{@"title":@"绿植水培",@"url":url}];
                
            }
            if(indexPath.row == 1){
                //楼盘介绍
                
            }
            break;
        }
        default:
            break;
    }
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    if (_bannerListModel.data.count != 0 && _bannerListModel.data.count - 1 >= index && _bannerListModel.data[index].type.integerValue == 5) {
        {
            [self pushNewViewController:@"WebViewController" params:@{@"url":_bannerListModel.data[index].link}];
        }
    }
    else{
        switch (index) {
            case 2:{
                //
                
                [self pushNewViewController:@"PC_AgreementAboutViewController" params:@{@"title":@"关于我们",@"plistKey":@"About"}];
                break;
            }
            case 1:{
                //资产录入
                [self pushNewViewController:@"DoorEntryViewController" params:@{@"priceId":@"1"}];
                break;
            }
            case 3:{
                //空气治理
                [self pushNewViewController:@"AirTreatmentViewController"];
                break;
            }
            case 0:{
                //绿植水培
                
                KeychainItemWrapper *keychain=[[KeychainItemWrapper alloc] initWithIdentifier:kImeiCode accessGroup:nil];
                NSString *imeiCode = [keychain  objectForKey:(id)kSecAttrService];
                
                NSString *url = [NSString stringWithFormat:@"https://kdt.im/-cSggr?mobile=%@&memberid=%@&seckey=%@",[UsersManager phone],[UsersManager memberId],imeiCode];
                [self pushNewViewController:@"WebViewController" params:@{@"title":@"绿植水培",@"url":url}];
                
                break;
            }
            default:
                break;
        }
    }
}

#pragma mark - Net request

- (void)netRequestBanner{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:@"0" forKey:@"type"];
    [kApi_member_banner httpRequestWithParams:params hudView:nil networkMethod:Post andBlock:^(id data, NSError *error) {
        if (error) {
            [self showError:error];
            return ;
        }
        if ([data[@"code"] integerValue] == 1) {
            _bannerListModel = [[BannerListModel alloc] initWithDic:data];
            self.collectionView.bannerListModel = _bannerListModel;
            
            
        }
    }];
}


#pragma mark - Event method

- (void)rightButtonClick{
    
    //添加imei
    KeychainItemWrapper *keychain=[[KeychainItemWrapper alloc] initWithIdentifier:kImeiCode accessGroup:nil];
    NSString *imeiCode = [keychain  objectForKey:(id)kSecAttrService];
    
    NSString *url = [NSString stringWithFormat:@"%@/service/advertisement/authenticate/%@/%@",kApi_Host,[UsersManager memberId],imeiCode];
    
    [self pushNewViewController:@"WebViewController" params:@{@"url":url,@"isNavExist":@"NO",@"title":@"到家服务"}];
}



#pragma mark - Pravit method


@end
