//
//  NewFeaturesViewController.m
//  MBDoctorClient
//
//  Created by 高泽民 on 16/2/5.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "NewFeaturesViewController.h"
#import "AppDelegate.h"
#import "TabBarViewController.h"
#import "LoginViewController.h"
#import "UsersManager.h"

#define kTotalPage 3
@interface NewFeaturesViewController ()

@end

@implementation NewFeaturesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.scrollView];
    [self.view addSubview:self.skipButton];
    [self.view addSubview:self.pageControl];
    WS(ws);
    [_skipButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.view).with.offset(10);
        make.right.equalTo(ws.view.mas_right).with.offset(-10);
        make.width.offset(44);
        make.height.offset(44);
    }];
    [_pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(ws.view.mas_bottom).with.offset(-kScreen_Height * 0.1);
        make.centerX.equalTo(ws.view.mas_centerX);
        make.height.offset(20);
        make.width.offset(100);
    }];
    for (int i=0; i<kTotalPage; i++) {
        UIImageView *image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"splash%d",i+1]]];
        image.frame = CGRectMake(kScreen_Width*i, 0, kScreen_Width, kScreen_Height);
        [_scrollView addSubview:image];
    }
    
    [self.scrollView addObserver:self forKeyPath:@"panGestureRecognizer.state" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    [self.scrollView removeObserver:self forKeyPath:@"panGestureRecognizer.state"];
}

#pragma maek getter and setter

- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:kScreen_Bounds];
        _scrollView.contentSize = CGSizeMake(kScreen_Width*kTotalPage, kScreen_Height);
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
        _scrollView.bounces = NO;
    }
    return _scrollView;
}

- (UIButton *)skipButton {
    if (!_skipButton) {
        _skipButton = [[UIButton alloc]init];
        [_skipButton setImage:[UIImage imageNamed:@"new_close"] forState:UIControlStateNormal];
        _skipButton.tag = 1001;
        [_skipButton addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _skipButton;
}


- (UIPageControl *)pageControl{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc]init];
        _pageControl.numberOfPages = kTotalPage;
        _pageControl.pageIndicatorTintColor = Color_Hex(@"999999");
        _pageControl.currentPageIndicatorTintColor = KMajorColor;
    }
    return _pageControl;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    self.pageControl.currentPage = scrollView.contentOffset.x / kScreen_Width;
}

#pragma mark pravit method

- (void)click:(UIButton *)button{
    switch (button.tag) {
        case 1001:{
            AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
            if ([UsersManager memberId] != nil) {
                TabBarViewController *VC = [[TabBarViewController alloc]init];
                [app.window setRootViewController:VC];
            }
            else{
                LoginViewController *VC = [[LoginViewController alloc]init];
                [app.window setRootViewController:VC];
            }

            break;
        }
        case 2000:{
        //下一页
            _scrollView.contentOffset = CGPointMake((_pageControl.currentPage+1)*kScreen_Width, 0) ;
            _pageControl.currentPage =_scrollView.contentOffset.x/kScreen_Width;
            break;
        }
        case 2001:{
        //最后一页
            AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
            if ([UsersManager memberId] != nil) {
                TabBarViewController *VC = [[TabBarViewController alloc]init];
                [app.window setRootViewController:VC];
            }
            else{
                LoginViewController *VC = [[LoginViewController alloc]init];
                [app.window setRootViewController:VC];
            }
            break;
        }
        default:
            break;
    }
}

- (void)scrollViewSwipe{
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    if ([UsersManager memberId] != nil) {
        TabBarViewController *VC = [[TabBarViewController alloc]init];
        [app.window setRootViewController:VC];
    }
    else{
        LoginViewController *VC = [[LoginViewController alloc]init];
        [app.window setRootViewController:VC];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
    if ([keyPath isEqualToString:@"panGestureRecognizer.state"]) {
        if (_scrollView.panGestureRecognizer.state == UIGestureRecognizerStateEnded) {
            if (_pageControl.currentPage == kTotalPage - 1) {
                [self scrollViewSwipe];
            }
        }
    }
}

@end
