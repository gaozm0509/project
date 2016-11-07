//
//  OrderViewController.m
//  HouseKeeper
//
//  Created by 高泽民 on 16/7/16.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "OrderViewController.h"
#import "iCarousel.h"
#import "XTSegmentControl.h"
#import "ToBePaidTableView.h"

#define kMySegmentControl_Height 45.0
@interface OrderViewController ()<iCarouselDataSource,iCarouselDelegate,ToBePaidTableViewDelegate>{
int _selectedIndex;
}

@property (nonatomic, strong) iCarousel *myCarousel;
@property (nonatomic ,strong) XTSegmentControl *mySegmentControl;
@property (assign, nonatomic) NSInteger oldSelectedIndex;

@end

@implementation OrderViewController

#pragma mark - Lefe cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的订单";
    [self.view addSubview:self.myCarousel];
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

- (iCarousel *)myCarousel{
    if (!_myCarousel) {
        _myCarousel = [[iCarousel alloc]init];
        _myCarousel.frame = CGRectMake(0, kMySegmentControl_Height, kScreen_Width, kScreen_Height - kNavHeight - kMySegmentControl_Height);
        _myCarousel.dataSource = self;
        _myCarousel.delegate = self;
        _myCarousel.decelerationRate = 1.0;
        _myCarousel.scrollSpeed = 1.0;
        _myCarousel.type = iCarouselTypeLinear;
        _myCarousel.pagingEnabled = YES;
        _myCarousel.clipsToBounds = YES;
        _myCarousel.bounceDistance = 0.2;
    }
    return _myCarousel;
}

#pragma mark 添加mySegmentControl
-(void)setMySegmentControl{
    CGRect frame = [UIView frameWithOutNavTab];
    //添加滑块
    frame.origin.y = 0;
    frame.size.height = kMySegmentControl_Height;
    if (!_mySegmentControl) {
        __weak typeof(_myCarousel) weakCarousel = _myCarousel;
        _mySegmentControl = [[XTSegmentControl alloc] initWithFrame:frame Items:@[@"待支付",@"服务中",@"已完成",@"全部"] selectedBlock:^(NSInteger index) {
            if (index == _oldSelectedIndex) {
                return;
            }
            _oldSelectedIndex = index;
            [weakCarousel scrollToItemAtIndex:index animated:YES];
        }];
        if (_selectedIndex != 0) {
            [_mySegmentControl selectIndex:_selectedIndex];
            [weakCarousel scrollToItemAtIndex:_selectedIndex animated:NO];
        }
        
        _oldSelectedIndex = 0;
        [self.view addSubview:_mySegmentControl];
    }
}

#pragma mark - Delegate

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view{
    OrderType type = OrderTypeToBePaid;
    switch (index) {
        case 0:{
            type = OrderTypeCompletedPaid;
            ToBePaidTableView *toBePaidTableView = (ToBePaidTableView *)view;
            if (!toBePaidTableView) {
                toBePaidTableView = [[ToBePaidTableView alloc]initWithFrame:carousel.bounds];
                toBePaidTableView.clickDelegate = self;
            }
            toBePaidTableView.orderType = type;
            return toBePaidTableView;
            break;
        }
        case 1:{
            type = OrderTypeArrange;
            ToBePaidTableView *toBePaidTableView = (ToBePaidTableView *)view;
            if (!toBePaidTableView) {
                toBePaidTableView = [[ToBePaidTableView alloc]initWithFrame:carousel.bounds];
                toBePaidTableView.clickDelegate = self;
            }
            toBePaidTableView.orderType = type;
            
            return toBePaidTableView;
            break;
        }
        case 2:{
            type = OrderTypeServering;
            ToBePaidTableView *toBePaidTableView = (ToBePaidTableView *)view;
            if (!toBePaidTableView) {
                toBePaidTableView = [[ToBePaidTableView alloc]initWithFrame:carousel.bounds];
                toBePaidTableView.clickDelegate = self;
            }
            toBePaidTableView.orderType = type;
            
            return toBePaidTableView;
            break;
        }
        case 3:{
            type = OrderTypeCompletedAll;
            ToBePaidTableView *toBePaidTableView = (ToBePaidTableView *)view;
            if (!toBePaidTableView) {
                toBePaidTableView = [[ToBePaidTableView alloc]initWithFrame:carousel.bounds];
                toBePaidTableView.clickDelegate = self;
            }
            toBePaidTableView.orderType = type;
            
            return toBePaidTableView;
            break;
        }
        default:{
            type = OrderTypeAll;
            ToBePaidTableView *toBePaidTableView = (ToBePaidTableView *)view;
            if (!toBePaidTableView) {
                toBePaidTableView = [[ToBePaidTableView alloc]initWithFrame:carousel.bounds];
                toBePaidTableView.clickDelegate = self;
            }
            toBePaidTableView.orderType = type;
            
            return toBePaidTableView;
            break;
        }
    }
    
}

- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel{
    return 4;
}

- (void)carouselDidScroll:(iCarousel *)carousel{
    if (_mySegmentControl) {
        float offset = carousel.scrollOffset;
        if (offset > 0) {
            [_mySegmentControl moveIndexWithProgress:offset];
        }
    }
}

- (void)carouselDidEndScrollingAnimation:(iCarousel *)carousel
{
    if (_mySegmentControl) {
        [_mySegmentControl endMoveIndex:carousel.currentItemIndex];
    }
    if (_oldSelectedIndex != carousel.currentItemIndex) {
        _oldSelectedIndex = carousel.currentItemIndex;
    }
}

#pragma mark ToBePaidTableViewDelegate

- (void)ToBePaidClickCellButton{
    [self pushNewViewController:@"PayViewController"];
}

#pragma mark - Net request



#pragma mark - Pravit method




@end
