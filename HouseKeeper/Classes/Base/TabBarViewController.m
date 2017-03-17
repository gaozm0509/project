//
//  TabBarViewController.m
//  HouseKeeper
//
//  Created by 高泽民 on 16/7/16.
//  Copyright © 2016年 zm. All rights reserved.
//

#import "TabBarViewController.h"

@interface TabBarViewController ()<UITabBarControllerDelegate>

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.delegate = self;
    
    [self.tabBar setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]]];
    [self.tabBar setShadowImage:[UIImage new]];
    
    [self setUpController];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITabBarControllerDelegate


- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    return YES;
}

- (void)setUpController{
    UINavigationController *home = [[UINavigationController alloc]initWithRootViewController:[[HomeViewController alloc]init]];
    UINavigationController *order = [[UINavigationController alloc]initWithRootViewController:[[OrderViewController alloc]init]];
    UINavigationController *asset = [[UINavigationController alloc]initWithRootViewController:[[AssetViewController alloc]init]];
    UINavigationController *personalCenter = [[UINavigationController alloc]initWithRootViewController:[[PersonalCenterViewController alloc]init]];

    
    home.title = @"首页";
    order.title = @"我的订单";
    asset.title = @"我的资产";
    personalCenter.title = @"个人中心";
    self.viewControllers = @[home,order,asset,personalCenter];
    
    home.tabBarItem.image = [UIImage imageNamed:@"unselected_tab1"];
    order.tabBarItem.image = [UIImage imageNamed:@"unselected_tab2"];
    asset.tabBarItem.image = [UIImage imageNamed:@"unselected_tab3"];
    personalCenter.tabBarItem.image = [UIImage imageNamed:@"unselected_tab4"];
    
    home.tabBarItem.selectedImage = [[UIImage imageNamed:@"selected_tab1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    order.tabBarItem.selectedImage = [[UIImage imageNamed:@"selected_tab2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    asset.tabBarItem.selectedImage = [[UIImage imageNamed:@"selected_tab3"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    personalCenter.tabBarItem.selectedImage = [[UIImage imageNamed:@"selected_tab4"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    [home.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:KMajorColor} forState:UIControlStateSelected];
    [order.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:KMajorColor} forState:UIControlStateSelected];
    [asset.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:KMajorColor} forState:UIControlStateSelected];
    [personalCenter.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:KMajorColor} forState:UIControlStateSelected];
}

- (void)setTabar{
    self.tabBar.tintColor = KMajorColor;
    for (int i = 1; i <= 4; i ++) {
        UITabBarItem *item = self.tabBar.items[i-1];
        [item setImage:[UIImage imageNamed:[NSString stringWithFormat:@"unselect_tab%d",i]]];
        [item setSelectedImage:[UIImage imageNamed:[NSString stringWithFormat:@"select_tab%d",i]]];
    }
}



@end
