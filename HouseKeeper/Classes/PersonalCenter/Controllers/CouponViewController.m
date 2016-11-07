//
//  CouponViewController.m
//  HouseKeeper
//
//  Created by 高泽民 on 16/7/27.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "CouponViewController.h"
#import "iCarousel.h"
#import "XTSegmentControl.h"
#import "CouponTableView.h"

#define kMySegmentControl_Height 45.0

@interface CouponViewController ()<iCarouselDataSource,iCarouselDelegate>{
int _selectedIndex;
}

@property (nonatomic, strong) iCarousel *myCarousel;
@property (nonatomic ,strong) XTSegmentControl *mySegmentControl;
@property (assign, nonatomic) NSInteger oldSelectedIndex;

@end

@implementation CouponViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"优惠券";
    [self.view addSubview:self.myCarousel];
    [self setMySegmentControl];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Get and set

- (iCarousel *)myCarousel{
    if (!_myCarousel) {
        _myCarousel = [[iCarousel alloc]init];
        CGRect frame = CGRectMake(0,kMySegmentControl_Height, kScreen_Width, self.view.frame.size.height-kMySegmentControl_Height);
        _myCarousel.frame = frame;
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
        _mySegmentControl = [[XTSegmentControl alloc] initWithFrame:frame Items:@[@"未使用",@"已使用",@"已过期"]selectedBlock:^(NSInteger index) {
            if (index == _oldSelectedIndex) {
                return;
            }
            _oldSelectedIndex = index;
            [weakCarousel scrollToItemAtIndex:index animated:NO];
        }];
        if (_selectedIndex != 0) {
            [_mySegmentControl selectIndex:_selectedIndex];
            [weakCarousel scrollToItemAtIndex:_selectedIndex animated:NO];
        }
        _mySegmentControl.backgroundColor = [UIColor whiteColor];
        _oldSelectedIndex = 0;
        [self.view addSubview:_mySegmentControl];
    }
}

#pragma mark - Delegate

#pragma mark iCarousel Delegate
- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view{
    if (index == 0) {
        CouponTableView *couponTableView = (CouponTableView *)view;
        if (!couponTableView) {
            couponTableView = [[CouponTableView alloc]initWithFrame:carousel.bounds style:UITableViewStylePlain];
            couponTableView.couponType = CouponTypeUnUsed;
        }
        
        return couponTableView;
    }
    if (index == 1) {
        CouponTableView *couponTableView = (CouponTableView *)view;
        if (!couponTableView) {
            couponTableView = [[CouponTableView alloc]initWithFrame:carousel.bounds style:UITableViewStylePlain];
            couponTableView.couponType = CouponTypeUsed;
        }
        
        return couponTableView;
    }
    if (index == 2) {
        CouponTableView *couponTableView = (CouponTableView *)view;
        if (!couponTableView) {
            couponTableView = [[CouponTableView alloc]initWithFrame:carousel.bounds style:UITableViewStylePlain];
            couponTableView.couponType = CouponTypeOverdue;
        }

        return couponTableView;
    }
    return nil;
}

- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel{
    return 3;
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


#pragma mark - Net request



#pragma mark - Event


#pragma mark - Pravit method

@end
