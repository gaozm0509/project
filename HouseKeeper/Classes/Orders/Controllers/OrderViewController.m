//
//  OrderViewController.m
//  HouseKeeper
//
//  Created by 高泽民 on 16/7/16.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "OrderViewController.h"
#import "XTSegmentControl.h"
#import "ToBePaidTableView.h"
#import "PayModel.h"

#define kMySegmentControl_Height 45.0
@interface OrderViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,ToBePaidTableViewDelegate,UIScrollViewDelegate>{
int _selectedIndex;
}

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic ,strong) XTSegmentControl *mySegmentControl;
@property (assign, nonatomic) NSInteger oldSelectedIndex;

@end

static NSString *collectionViewId = @"collectionViewId";

@implementation OrderViewController

#pragma mark - Lefe cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的订单";
    [self.view addSubview:self.collectionView];
    [self setMySegmentControl];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    self.hidesBottomBarWhenPushed = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Getter and setter

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, kMySegmentControl_Height, kScreen_Width, kScreen_Height - kNavHeight - kMySegmentControl_Height - kTabbarHeight) collectionViewLayout:layout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.backgroundColor = kBackgroundColor;
        _collectionView.pagingEnabled = YES;
        _collectionView.showsHorizontalScrollIndicator = NO;
        
        [_collectionView registerClass:[ToBePaidTableView class] forCellWithReuseIdentifier:collectionViewId];
    }
    return _collectionView;
}

#pragma mark 添加mySegmentControl

-(void)setMySegmentControl{
    CGRect frame = CGRectMake(0, 0, kScreen_Width, kMySegmentControl_Height);
    if (!_mySegmentControl) {
        WS(weakSelf);
        _mySegmentControl = [[XTSegmentControl alloc] initWithFrame:frame Items:@[@"待支付",@"已支付",@"安排中",@"服务中",@"已完成",@"全部"] selectedBlock:^(NSInteger index) {
            if (index == _oldSelectedIndex) {
                return;
            }
            _oldSelectedIndex = index;
            [weakSelf.collectionView setContentOffset:CGPointMake(kScreen_Width * index, 0) animated:NO];
        }];
        if (_selectedIndex != 0) {
            [_mySegmentControl selectIndex:_selectedIndex];
//            [weakSelf.myCarousel scrollToItemAtIndex:_selectedIndex animated:NO];
        }
        
        _oldSelectedIndex = 0;
        [self.view addSubview:_mySegmentControl];
    }
}

#pragma mark - Delegate

#pragma mark - UICollectionViewDataSource

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ToBePaidTableView *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionViewId forIndexPath:indexPath];
    cell.clickDelegate = self;
    
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 6;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(kScreen_Width, collectionView.height);//不懂为啥要减去45，但是不减会出错
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    
    OrderType type = OrderTypeToBePaid;
    switch (indexPath.row) {
        case 0:{
            type = OrderTypeToBePaid;
            break;
        }
        case 1:{
            type = OrderTypeCompletedPaid;
            break;
        }
        case 2:{
            type = OrderTypeArrange;
            break;
        }
        case 3:{
            type = OrderTypeServering;
            break;
        }
        case 4:{
            type = OrderTypeCompletedAll;
            break;
        }
        case 5:{
            type = OrderTypeAll;
            break;
        }
        default:
            break;
    }
    ToBePaidTableView *myCell = (ToBePaidTableView *)cell;
    if (myCell.orderType != type) {
        myCell.orderType = type;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    float offset = scrollView.contentOffset.x / kScreen_Width;
    if (offset > 0) {
        [_mySegmentControl moveIndexWithProgress:offset];
    }
}


#pragma mark ToBePaidTableViewDelegate


- (void)ToBePaidClickCellButtonWithModel:(MyOrderModel *)model{
    [self pushNewViewController:@"OrderDetailsViewController" params:@{@"orderType":@(model.status)}];
}

//支付
- (void)payWithModel:(MyOrderModel *)model{
    PayModel *payModel = [[PayModel alloc] initWithDic:@{}];
    payModel.id = model.id;
    payModel.member_id = model.member_id;
    payModel.amount = model.amount;
    payModel.furniture_id = model.furniture_id;
    payModel.order_date.date = model.order_date;
    payModel.state_id = model.state_id;
    payModel.type = model.type;
    [self pushNewViewController:@"CreatOrderViewController" params:@{@"orderModel":payModel}];
}

#pragma mark - Net request



#pragma mark - Pravit method




@end
