//
//  LifeServiceViewController.m
//  
//
//  Created by 高泽民 on 16/10/24.
//
//

#import "LifeServiceViewController.h"
#import "LifeServiceCollectionView.h"

@interface LifeServiceViewController ()<LifeServiceCollectionViewDelegate>

@property(nonatomic, strong) LifeServiceCollectionView *collectionView;

@end

@implementation LifeServiceViewController

#pragma mark - Cycle life
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"生活服务";
    
    [self.view addSubview:self.collectionView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Getter and setter

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
        case 0:{
            if (indexPath.row == 0) {
                //维修
                
            }
            if (indexPath.row == 1) {
                //绿植
                
            }
            if (indexPath.row == 2) {
                //洗衣
                
            }
            if (indexPath.row == 3) {
                //保洁
                
            }
            if (indexPath.row == 4) {
                //地毯清洗
                
            }
            if (indexPath.row == 5) {
                //装修
                
            }
            if (indexPath.row == 6) {
                //京东
                
            }
            if (indexPath.row == 7) {
                //维修
                
            }
            
            break;
        }
        case 1:{
            if(indexPath.row == 0){
                //资产录入
                
            }
            if(indexPath.row == 1){
                //充值返现
                
            }
            if(indexPath.row == 2){
                //深度检测
                
            }
            if(indexPath.row == 3){
                //空气治理
                
            }
            break;
        }
        case 2:{
            if(indexPath.row == 0){
                //绿植水培
                
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

#pragma mark - Net request



#pragma mark - Event method



#pragma mark - Pravit method

@end
